#ifndef _KEYPADCONFIG_H
#define _KEYPADCONFIG_H
#include "gpio.h"
#include "main.h"

#define _KEYPAD_DEBOUNCE_TIME_MS 20
#define _KEYPAD_USE_FREERTOS     1

const GPIO_TypeDef *_KEYPAD_COLUMN_GPIO_PORT[]
    = {DATA0_GPIO_Port, DATA1_GPIO_Port, DATA2_GPIO_Port, DATA3_GPIO_Port};

const uint16_t _KEYPAD_COLUMN_GPIO_PIN[] = {DATA0_Pin, DATA1_Pin, DATA2_Pin, DATA3_Pin};

const GPIO_TypeDef *_KEYPAD_ROW_GPIO_PORT[]
    = {DATA4_GPIO_Port, DATA5_GPIO_Port, DATA7_GPIO_Port, DATA6_GPIO_Port};

const uint16_t _KEYPAD_ROW_GPIO_PIN[] = {
    DATA4_Pin,
    DATA5_Pin,
    DATA7_Pin,
    DATA6_Pin,
};

#endif
