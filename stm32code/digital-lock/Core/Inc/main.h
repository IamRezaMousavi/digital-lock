/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file           : main.h
 * @brief          : Header for main.c file.
 *                   This file contains the common defines of the application.
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

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f0xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define FINGERPRINT_EN_Pin       GPIO_PIN_0
#define FINGERPRINT_EN_GPIO_Port GPIOA
#define RS_Pin                   GPIO_PIN_4
#define RS_GPIO_Port             GPIOA
#define RW_Pin                   GPIO_PIN_5
#define RW_GPIO_Port             GPIOA
#define EN_Pin                   GPIO_PIN_6
#define EN_GPIO_Port             GPIOA
#define D4_Pin                   GPIO_PIN_7
#define D4_GPIO_Port             GPIOA
#define D5_Pin                   GPIO_PIN_0
#define D5_GPIO_Port             GPIOB
#define D6_Pin                   GPIO_PIN_1
#define D6_GPIO_Port             GPIOB
#define D7_Pin                   GPIO_PIN_2
#define D7_GPIO_Port             GPIOB
#define LCDBK_Pin                GPIO_PIN_12
#define LCDBK_GPIO_Port          GPIOB
#define BUZZER_Pin               GPIO_PIN_14
#define BUZZER_GPIO_Port         GPIOB
#define RELAY_Pin                GPIO_PIN_7
#define RELAY_GPIO_Port          GPIOF
#define DATA0_Pin                GPIO_PIN_15
#define DATA0_GPIO_Port          GPIOA
#define DATA1_Pin                GPIO_PIN_3
#define DATA1_GPIO_Port          GPIOB
#define DATA2_Pin                GPIO_PIN_4
#define DATA2_GPIO_Port          GPIOB
#define DATA3_Pin                GPIO_PIN_5
#define DATA3_GPIO_Port          GPIOB
#define DATA4_Pin                GPIO_PIN_6
#define DATA4_GPIO_Port          GPIOB
#define DATA5_Pin                GPIO_PIN_7
#define DATA5_GPIO_Port          GPIOB
#define DATA7_Pin                GPIO_PIN_8
#define DATA7_GPIO_Port          GPIOB
#define DATA6_Pin                GPIO_PIN_9
#define DATA6_GPIO_Port          GPIOB

/* USER CODE BEGIN Private defines */
#define DEBUG_MODE 0

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */
