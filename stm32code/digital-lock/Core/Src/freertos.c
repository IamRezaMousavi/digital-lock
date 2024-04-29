/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * File Name          : freertos.c
 * Description        : Code for freertos applications
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2023 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */
/* USER CODE END Header */

/* Includes ------------------------------------------------------------------*/
#include "FreeRTOS.h"
#include "cmsis_os.h"
#include "main.h"
#include "task.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include "Fingerprint.h"
#include "KeyPad.h"
#include "cJSON.h"
#include "ds1307_for_stm32_hal.h"
#include "ee24.h"
#include "gsm.h"
#include "lcd.h"
#include "local_config.h"
#include "modes.h"
#include "sha-256.h"
#include "usart.h"
#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
#define LCD_BK_ON      HAL_GPIO_WritePin(LCDBK_GPIO_Port, LCDBK_Pin, GPIO_PIN_SET)
#define LCD_BK_OFF     HAL_GPIO_WritePin(LCDBK_GPIO_Port, LCDBK_Pin, GPIO_PIN_RESET)
#define RELAY_ON       HAL_GPIO_WritePin(RELAY_GPIO_Port, RELAY_Pin, GPIO_PIN_SET)
#define RELAY_OFF      HAL_GPIO_WritePin(RELAY_GPIO_Port, RELAY_Pin, GPIO_PIN_RESET)
#define BUZZER_ON      HAL_GPIO_WritePin(BUZZER_GPIO_Port, BUZZER_Pin, GPIO_PIN_SET)
#define BUZZER_OFF     HAL_GPIO_WritePin(BUZZER_GPIO_Port, BUZZER_Pin, GPIO_PIN_RESET)
#define FINGERPRINT_ON HAL_GPIO_WritePin(FINGERPRINT_EN_GPIO_Port, FINGERPRINT_EN_Pin, GPIO_PIN_SET)
#define FINGERPRINT_OFF \
  HAL_GPIO_WritePin(FINGERPRINT_EN_GPIO_Port, FINGERPRINT_EN_Pin, GPIO_PIN_RESET)

#define EEPROM_SIZE 32

/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/
/* USER CODE BEGIN Variables */
Lcd_HandleTypeDef  lcd;
EE24_HandleTypeDef ee24;
Mode               activeMode             = NORMAL;
uint8_t            ee24_data[EEPROM_SIZE] = {0};
char               welcomeMessage[8]      = "WELCOME";
char               errorMessage[8]        = "ERROR";
char               password[SIZE_OF_SHA_256_HASH_STRING]
    = "ff98ef67b552532453d1ad8b1912a776ab1b30bf3814fa009b8ffe3c3e5b7efe"; // 235689
char    passwordtemp[16] = {0};
uint8_t passwordIndex    = 0;
uint8_t relayDelay       = 5;
uint8_t userLastId       = 1;

#ifdef PHONENUMBER
char phoneNumber[] = PHONENUMBER;
#else
char phoneNumber[] = "099****8679";
#endif

/* USER CODE END Variables */
/* Definitions for counterTask */
osThreadId_t         counterTaskHandle;
const osThreadAttr_t counterTask_attributes = {
    .name       = "counterTask",
    .stack_size = 128 * 1,
    .priority   = (osPriority_t)osPriorityNormal,
};
/* Definitions for keypadTask */
osThreadId_t         keypadTaskHandle;
const osThreadAttr_t keypadTask_attributes = {
    .name       = "keypadTask",
    .stack_size = 128 * 4,
    .priority   = (osPriority_t)osPriorityLow,
};
/* Definitions for gsmTask */
osThreadId_t         gsmTaskHandle;
const osThreadAttr_t gsmTask_attributes = {
    .name       = "gsmTask",
    .stack_size = 128 * 5,
    .priority   = (osPriority_t)osPriorityLow,
};
/* Definitions for settingsTask */
osThreadId_t         settingsTaskHandle;
const osThreadAttr_t settingsTask_attributes = {
    .name       = "settingsTask",
    .stack_size = 128 * 6,
    .priority   = (osPriority_t)osPriorityLow,
};

/* Private function prototypes -----------------------------------------------*/
/* USER CODE BEGIN FunctionPrototypes */

void clearVaribles() {
  Lcd_clear(&lcd);
  passwordIndex = 0;

  for (uint8_t i = 0; i < 16; i++)
    passwordtemp[i] = 0;
}

void setDateTime() {
  // const char *DAYS_OF_WEEK[7]
  //     = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

  DS1307_SetTimeZone(+3, 30);
  DS1307_SetDate(1);
  DS1307_SetMonth(1);
  DS1307_SetYear(2024);
  DS1307_SetHour(12);
  DS1307_SetMinute(30);
  DS1307_SetSecond(30);
}

void getDateTime(char *ans) {
  struct tm st = {
      .tm_sec  = (int)DS1307_GetSecond(),        /* Seconds.	[0-60] (1 leap second) */
      .tm_min  = (int)DS1307_GetMinute(),        /* Minutes.	[0-59] */
      .tm_hour = (int)DS1307_GetHour(),          /* Hours.	[0-23] */
      .tm_mday = (int)DS1307_GetDate(),          /* Day.		[1-31] */
      .tm_mon  = ((int)DS1307_GetMonth()) - 1,   /* Month.	[0-11] */
      .tm_year = ((int)DS1307_GetYear()) - 1900, /* Year	- 1900.  */
      .tm_wday = (int)DS1307_GetDayOfWeek(),     /* Day of week.	[0-6] */
  };
  // time_t t = mktime(&st);
  // sprintf(ans, "%ld", t);
  strftime(ans, 16, "%m-%d %H:%M:%S", &st);
}

void openLock() {
  RELAY_ON;
  osDelay(relayDelay * 1000);
  RELAY_OFF;
}

void checkPasswordAndOpen() {
  activeMode = CHECK_PASSWORD;

  int result = hash_check(passwordtemp, password);

  if (result == 0) {
    // if same password
    Lcd_clear(&lcd);
    Lcd_string(&lcd, welcomeMessage);
    openLock();
  } else {
    Lcd_clear(&lcd);
    Lcd_string(&lcd, errorMessage);
    osDelay(relayDelay * 1000);
  }

  activeMode = NORMAL;
  clearVaribles();
}

void smsCallBack(char *message) {
  if (message == NULL || *message == '\0')
    return;

  const cJSON *mode        = NULL;
  cJSON       *jsonMessage = cJSON_Parse(message);
  if (jsonMessage == NULL)
    goto end;

  mode = cJSON_GetObjectItemCaseSensitive(jsonMessage, "mode");
  if (!cJSON_IsNumber(mode))
    goto end;

  int modeNumber = mode->valuedouble;
  switch (modeNumber) {
    case SEND_STATUS:
      cJSON *object = cJSON_CreateObject();
      char   t[10]  = {0};
      getDateTime(t);
      cJSON_AddStringToObject(object, "time", t);
      cJSON_AddStringToObject(object, "name", "Reza");
      cJSON_AddNumberToObject(object, "code", 1402);
      char *ss = cJSON_PrintUnformatted(object);
      if (ss == NULL)
        ss = "Null";

      // Gsm_SendSms(phoneNumber, ss);
      cJSON_Delete(object);
      break;

    case GET_SETTINGS_FROM_SMS:
      // TODO
      break;

    default:
      break;
  }

end:
  cJSON_Delete(jsonMessage);
}

void createUser() {
  activeMode = CREATE_USER;
  Lcd_clear(&lcd);
  Lcd_string(&lcd, "Create User");
  Lcd_cursor(&lcd, 1, 0);
  Lcd_string(&lcd, "Ready?");

  char input_key = -1, answer = -1;

  input_key = KeyPad_WaitForKeyGetChar(0);
  if (!(input_key >= '0' && input_key <= '9')) {
    Lcd_clear(&lcd);
    activeMode = NORMAL;
    return;
  }

  while (answer != FINGERPRINT_OK) {
    Lcd_clear(&lcd);
    Lcd_string(&lcd, "Get Finger 1");
    answer = r308_getimage();
    switch (answer) {
      case FINGERPRINT_OK:
        Lcd_clear(&lcd);
        Lcd_string(&lcd, "FP: OK");
        break;

      default:
        Lcd_clear(&lcd);
        Lcd_string(&lcd, "FP: Try again!");
        break;
    }

    if (answer == FINGERPRINT_OK) {
      answer = r308_genchar(0x01);
      switch (answer) {
        case FINGERPRINT_OK:
          Lcd_clear(&lcd);
          Lcd_string(&lcd, "FP:GenChar1 OK");
          break;

        default:
          Lcd_clear(&lcd);
          Lcd_string(&lcd, "FP:GenChar1 Err");
          break;
      }
    }

    Lcd_cursor(&lcd, 1, 0);
    Lcd_string(&lcd, "Ready?");
    input_key = KeyPad_WaitForKeyGetChar(0);
    if (!(input_key >= '0' && input_key <= '9')) {
      Lcd_clear(&lcd);
      activeMode = NORMAL;
      return;
    }
  }

  input_key = -1, answer = -1;
  while (answer != FINGERPRINT_OK) {
    Lcd_clear(&lcd);
    Lcd_string(&lcd, "Get Finger 2");
    answer = r308_getimage();
    switch (answer) {
      case FINGERPRINT_OK:
        Lcd_clear(&lcd);
        Lcd_string(&lcd, "FP: OK");
        break;

      default:
        Lcd_clear(&lcd);
        Lcd_string(&lcd, "FP: Try again!");
        break;
    }

    if (answer == FINGERPRINT_OK) {
      answer = r308_genchar(0x02);
      switch (answer) {
        case FINGERPRINT_OK:
          Lcd_clear(&lcd);
          Lcd_string(&lcd, "FP:GenChar2 OK");
          break;

        default:
          Lcd_clear(&lcd);
          Lcd_string(&lcd, "FP:GenChar2 Err");
          break;
      }
    }

    Lcd_cursor(&lcd, 1, 0);
    Lcd_string(&lcd, "Ready?");
    input_key = KeyPad_WaitForKeyGetChar(0);
    if (!(input_key >= '0' && input_key <= '9')) {
      Lcd_clear(&lcd);
      activeMode = NORMAL;
      return;
    }
  }

  answer = r308_regmodel();
  switch (answer) {
    case FINGERPRINT_OK:
      Lcd_clear(&lcd);
      Lcd_string(&lcd, "FP:RegModel OK");
      break;

    default:
      Lcd_clear(&lcd);
      Lcd_string(&lcd, "FP:RegModel Err");
      Lcd_cursor(&lcd, 1, 0);
      Lcd_string(&lcd, "Ready?");
      return;
  }

  answer = r308_store(userLastId);
  switch (answer) {
    case FINGERPRINT_OK:
      Lcd_clear(&lcd);
      char s[16] = {0};
      sprintf(s, "ID: %d", userLastId);
      Lcd_string(&lcd, s);
      break;

    default:
      Lcd_string(&lcd, "FP: onSave Err");
      Lcd_cursor(&lcd, 1, 0);
      Lcd_string(&lcd, "Ready?");
      return;
  }

  if (answer == FINGERPRINT_OK) {
    userLastId++;
    osDelay(3000);
    activeMode = NORMAL;
  }
}

void readUser() {
  activeMode = READ_USER;
  Lcd_clear(&lcd);
  Lcd_string(&lcd, "Read User");
  Lcd_cursor(&lcd, 1, 0);
  Lcd_string(&lcd, "Ready?");

  char input_key = -1, answer = -1;

  input_key = KeyPad_WaitForKeyGetChar(0);
  if (!(input_key >= '0' && input_key <= '9')) {
    Lcd_clear(&lcd);
    activeMode = NORMAL;
    return;
  }

  Lcd_clear(&lcd);
  Lcd_string(&lcd, "Get Finger");
  answer = r308_getimage();
  switch (answer) {
    case FINGERPRINT_OK:
      break;

    default:
      Lcd_clear(&lcd);
      Lcd_string(&lcd, "FP: Try again!");
      osDelay(3000); // to show message
      return;
  }

  answer = r308_genchar(0x01);
  switch (answer) {
    case FINGERPRINT_OK:
      break;

    default:
      Lcd_clear(&lcd);
      Lcd_string(&lcd, "FP:GenChar Err");
      osDelay(3000);
      break;
  }

  uint16_t search_answer = r308_search();
  switch (search_answer) {
    case FINGERPRINT_PACKETRECIEVEERR:
      Lcd_clear(&lcd);
      Lcd_string(&lcd, "PF: Rec Err");
      break;

    case FINGERPRINT_NOTFOUND:
      Lcd_clear(&lcd);
      Lcd_string(&lcd, "FP: Not Found");
      osDelay(relayDelay * 1000);
      break;

    default:
      Lcd_clear(&lcd);
      char buffer[16];
      sprintf(buffer, "%s %d", welcomeMessage, search_answer);
      Lcd_string(&lcd, buffer);
      openLock();
      break;
  }

  activeMode = NORMAL;
}

void updateUser() {
  // TODO
}

void deleteUser() {
  // TODO
}

/* USER CODE END FunctionPrototypes */

void StartCounterTask(void *argument);
void StartKeypadTask(void *argument);
void StartGsmTask(void *argument);
void StartSettingsTask(void *argument);

void MX_FREERTOS_Init(void); /* (MISRA C 2004 rule 8.1) */

/**
 * @brief  FreeRTOS initialization
 * @param  None
 * @retval None
 */
void MX_FREERTOS_Init(void) {
  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* USER CODE BEGIN RTOS_MUTEX */
  /* add mutexes, ... */
  /* USER CODE END RTOS_MUTEX */

  /* USER CODE BEGIN RTOS_SEMAPHORES */
  /* add semaphores, ... */
  /* USER CODE END RTOS_SEMAPHORES */

  /* USER CODE BEGIN RTOS_TIMERS */
  /* start timers, add new ones, ... */
  /* USER CODE END RTOS_TIMERS */

  /* USER CODE BEGIN RTOS_QUEUES */
  /* add queues, ... */
  /* USER CODE END RTOS_QUEUES */

  /* Create the thread(s) */
  /* creation of counterTask */
  counterTaskHandle = osThreadNew(StartCounterTask, NULL, &counterTask_attributes);

  /* creation of keypadTask */
  keypadTaskHandle = osThreadNew(StartKeypadTask, NULL, &keypadTask_attributes);

  /* creation of gsmTask */
  gsmTaskHandle = osThreadNew(StartGsmTask, NULL, &gsmTask_attributes);

  /* creation of settingsTask */
  settingsTaskHandle = osThreadNew(StartSettingsTask, NULL, &settingsTask_attributes);

  /* USER CODE BEGIN RTOS_THREADS */
  /* add threads, ... */
  /* USER CODE END RTOS_THREADS */

  /* USER CODE BEGIN RTOS_EVENTS */
  /* add events, ... */
  /* USER CODE END RTOS_EVENTS */
}

/* USER CODE BEGIN Header_StartCounterTask */
/**
 * @brief  Function implementing the counterTask thread.
 * @param  argument: Not used
 * @retval None
 */
/* USER CODE END Header_StartCounterTask */
void StartCounterTask(void *argument) {
  /* USER CODE BEGIN StartCounterTask */
  DS1307_Init(&hi2c2);
  setDateTime();
  LCD_BK_ON;
  Lcd_PortType ports[] = {D4_GPIO_Port, D5_GPIO_Port, D6_GPIO_Port, D7_GPIO_Port};
  Lcd_PinType  pins[]  = {D4_Pin, D5_Pin, D6_Pin, D7_Pin};
  lcd = Lcd_create(ports, pins, RS_GPIO_Port, RS_Pin, EN_GPIO_Port, EN_Pin, LCD_4_BIT_MODE);

  /* Infinite loop */
  uint16_t i = 0;
  for (;;) {
    switch (activeMode) {
      case NORMAL:
        // show time in lcd
        Lcd_cursor(&lcd, 0, 0);

        char t[16] = {0};
        getDateTime(t);
        Lcd_string(&lcd, t);
        Lcd_cursor(&lcd, 1, passwordIndex);
        break;

      case LOCK:
        Lcd_cursor(&lcd, 0, 0);
        Lcd_string(&lcd, "DISABLE MODE");
        break;

      default:
        break;
    }

    if (i < USHRT_MAX)
      i++;
    else
      i = 0;

    osDelay(1000);
  }
  /* USER CODE END StartCounterTask */
}

/* USER CODE BEGIN Header_StartKeypadTask */
/**
 * @brief Function implementing the keypadTask thread.
 * @param argument: Not used
 * @retval None
 */
/* USER CODE END Header_StartKeypadTask */
void StartKeypadTask(void *argument) {
  /* USER CODE BEGIN StartKeypadTask */
  KeyPad_Init();

  // wait for lcd initialisation done
  while (!lcd.en_pin)
    osDelay(500);

  FINGERPRINT_ON;
  char ans = -1;
  for (uint8_t i = 0; i < 5; i++) {
    ans = r308_verifypassword();
    switch (ans) {
      case FINGERPRINT_OK:
        break;
      case FINGERPRINT_PACKETRECIEVEERR:
        Lcd_string(&lcd, "FP Error!");
        break;
      case FINGERPRINT_WRONGPASSWORD:
        Lcd_string(&lcd, "FP: Wrong PW!");
        break;

      default:
        break;
    }

    if (ans == FINGERPRINT_OK)
      break;
  }

  /* Infinite loop */
  for (;;) {
    char input_key;
    switch (activeMode) {
      case NORMAL:
        input_key = KeyPad_WaitForKeyGetChar(0);

        if (input_key >= '0' && input_key <= '9') {
          // get a password
          char key_buffer[2];
          sprintf(key_buffer, "*");
          Lcd_string(&lcd, key_buffer);
          passwordtemp[passwordIndex] = input_key;

          passwordIndex++;
          if (passwordIndex > 15)
            passwordIndex = 0;
        } // else
          // get a command
        break;

      case LOCK:
        input_key = KeyPad_WaitForKeyGetChar(0);
        break;

      // USER CRUD Operations
      case CREATE_USER:
        createUser();
        continue;

      case READ_USER:
        readUser();
        continue;

      case UPDATE_USER:
        updateUser();
        continue;

      case DELETE_USER:
        deleteUser();
        continue;

      default:
        // dont run below statements
        continue;
    }

    // for NORMAL and LOCK mode
    switch (input_key) {
      case 'A':
        if (activeMode == NORMAL)
          checkPasswordAndOpen();
        break;

      case 'D':
        activeMode = activeMode == NORMAL ? LOCK : NORMAL;
        clearVaribles();
        break;

      case 'B':
        activeMode = WRITE_SETTINGS_TO_EEPROM;
        break;

      case 'C':
        createUser();
        break;

      case '*':
        break;

      case '#':
        readUser();
        break;

      default:
        break;
    }
  }
  /* USER CODE END StartKeypadTask */
}

/* USER CODE BEGIN Header_StartGsmTask */
/**
 * @brief Function implementing the gsmTask thread.
 * @param argument: Not used
 * @retval None
 */
/* USER CODE END Header_StartGsmTask */
void StartGsmTask(void *argument) {
  /* USER CODE BEGIN StartGsmTask */

  // osDelay(300);
  // Gsm_SendSms("zz", "zz");

#if (DEBUG_MODE)
  printf("[GSM] started\n");
#endif

  /* Infinite loop */
  for (;;) {
    // char message[50] = {0};
    // Gsm_WaitForMessage(message);
    // smsCallBack(message);
  }
  /* USER CODE END StartGsmTask */
}

/* USER CODE BEGIN Header_StartSettingsTask */
/**
 * @brief Function implementing the settingsTask thread.
 * @param argument: Not used
 * @retval None
 */
/* USER CODE END Header_StartSettingsTask */
void StartSettingsTask(void *argument) {
  /* USER CODE BEGIN StartSettingsTask */

  if (EE24_Init(&ee24, &hi2c2, EE24_ADDRESS_DEFAULT)) {
    if (EE24_Read(&ee24, 0, ee24_data, EEPROM_SIZE, 1000)) {
      // set settings from eeprom
      cJSON *ee24settings = cJSON_Parse((char *)ee24_data);

      cJSON *wMessage = cJSON_GetObjectItem(ee24settings, "welMes");
      if (cJSON_IsString(wMessage)) {
        char *s = cJSON_GetStringValue(wMessage);
        Lcd_string(&lcd, s);
        sprintf(welcomeMessage, "%s", cJSON_GetStringValue(wMessage));
      }

      cJSON_Delete(ee24settings);
    }
  }

  /* Infinite loop */
  for (;;) {
    if (activeMode == WRITE_SETTINGS_TO_EEPROM) {
      // save settings to eeprom
      cJSON *object = cJSON_CreateObject();
      cJSON_AddStringToObject(object, "welMes", "Hello");

      char *ss = cJSON_PrintUnformatted(object);
      sprintf((char *)ee24_data, "%s", ss);
      EE24_Write(&ee24, 0, ee24_data, EEPROM_SIZE, 1000);
      Lcd_string(&lcd, (char *)ee24_data);
      cJSON_Delete(object);

      activeMode = NORMAL;
    }

    osDelay(100);
  }
  /* USER CODE END StartSettingsTask */
}

/* Private application code --------------------------------------------------*/
/* USER CODE BEGIN Application */

/* USER CODE END Application */
