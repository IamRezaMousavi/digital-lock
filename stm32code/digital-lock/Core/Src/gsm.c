#include "gsm.h"

#include <stdio.h>

#include "usart.h"

#if (_GSM_USE_FREERTOS == 1)
#include "cmsis_os.h"
#define _GSM_DELAY(x) osDelay(x)
#else
#define _GSM_DELAY(x) HAL_Delay(x)
#endif

/*************** Local varible definitions ******/

/*************** Static declarations ************/
static void Gsm_SendString(char *str);
static void Gsm_SendData(uint8_t data);

/*************** Public Function definitions ***********/
void gsm_del_all_sms(uint8_t *gsm) {
  Gsm_SendString(DELETE_ALL_SMS);
  Gsm_SendData(Double_Quotation);
  Gsm_SendString(DELETE_ALL_SMS_MODE);
  Gsm_SendData(Double_Quotation);
  Gsm_SendData(Enter);
  Gsm_SendData(13);
}

char gsm_get_char() {
  char ch[1];
  HAL_UART_Receive(&huart1, (uint8_t *)ch, 1, 200000);
  return ch[0];
}

void gsm_wait_to_get(char ch) {
  char rec_ch[1];
  while (ch != rec_ch[0]) HAL_UART_Receive(&huart1, (uint8_t *)rec_ch, 1, 200000);
}

void gsm_read_sms(uint8_t *gsm, char number[13], char *message, int message_size) {
  Gsm_SendString(READ_SMS);
  Gsm_SendData(Enter);
  Gsm_SendData(13);

  gsm_wait_to_get(',');
  gsm_get_char();

  for (uint8_t i = 0; i < 13; i++) number[i] = gsm_get_char(gsm);

  gsm_wait_to_get(Enter);

  for (int i = 0; i < message_size; i++) message[i] = gsm_get_char(gsm);
  message[message_size] = '\0';
}

/*************** Private function definition ****/
void gsm_enable_text_mode(uint8_t *gsm) {
  Gsm_SendString(ENABLE_TEXT_MODE);
  Gsm_SendData(Enter);
  Gsm_SendData(13);
}

/*************** Static function definition *****/
void Gsm_SendString(char *str) {
  while (*str != 0) {
    HAL_UART_Transmit(&huart1, (uint8_t *)str, 1, 20000);
    str++;
  }
}

void Gsm_SendData(uint8_t data) {
  uint8_t d[] = {data};
  HAL_UART_Transmit(&huart1, d, 1, 20000);
}

/***************  template function prototype  ***********/
void Gsm_SendSms(char *phonenumber, char *message) {
  Gsm_SendString("AT\r\n");
  Gsm_SendString("AT+CREG=1\r\n");
  Gsm_SendString("AT+CMGF=1\r\n");
  _GSM_DELAY(1000);

  char ss[30] = {0};
  sprintf(ss, "AT+CMGS=\"%s\"", phonenumber);
  Gsm_SendString(ss);
  _GSM_DELAY(1000);

  Gsm_SendString("Hello from stm32");
  Gsm_SendData(26);
  _GSM_DELAY(1000);
}

void Gsm_WaitForMessage(char *result) {}
