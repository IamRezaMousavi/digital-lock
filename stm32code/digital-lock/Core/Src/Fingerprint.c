#include "Fingerprint.h"

#include "usart.h"

#define BUFFER_SIZE 14

uint8_t buffer[BUFFER_SIZE] = {0};

#define ANSWER buffer[10]

void empty_buf(void) {
  for (uint8_t count = 0; count < BUFFER_SIZE; count++)
    buffer[count] = 0;
}

char r308_verifypassword(void) {
  empty_buf();

  char varpass[] = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x07, 0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x1B};

  HAL_UART_Transmit(&huart2, (uint8_t *)varpass, 16, 100);
  HAL_UART_Receive(&huart2, buffer, 12, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return FINGERPRINT_OK;
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_WRONGPASSWORD:
      return FINGERPRINT_WRONGPASSWORD;
    default:
      return -1;
  }
}

char r308_getimage(void) {
  empty_buf();

  char getimg[] = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x03, 0x01, 0x00, 0x05};

  HAL_UART_Transmit(&huart2, (uint8_t *)getimg, 12, 100);
  HAL_UART_Receive(&huart2, buffer, 12, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return FINGERPRINT_OK;
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_NOFINGER:
      return FINGERPRINT_NOFINGER;
    case FINGERPRINT_IMAGEFAIL:
      return FINGERPRINT_IMAGEFAIL;
    default:
      return -1;
  }
}

char r308_genchar(char id) {
  empty_buf();

  char genchar[] = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x04, 0x02, id, 0x00, id + 0x07};

  HAL_UART_Transmit(&huart2, (uint8_t *)genchar, 13, 100);
  HAL_UART_Receive(&huart2, buffer, 12, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return FINGERPRINT_OK;
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_IMAGEMESS:
      return FINGERPRINT_IMAGEMESS;
    case FINGERPRINT_FEATUREFAIL:
      return FINGERPRINT_FEATUREFAIL;
    default:
      return -1;
  }
}

char r308_regmodel(void) {
  empty_buf();

  char rgmdl[] = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x03, 0x05, 0x00, 0x09};

  HAL_UART_Transmit(&huart2, (uint8_t *)rgmdl, 12, 100);
  HAL_UART_Receive(&huart2, buffer, 12, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return FINGERPRINT_OK;
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_ENROLLMISMATCH:
      return FINGERPRINT_ENROLLMISMATCH;
    default:
      return -1;
  }
}

char r308_store(char id) {
  empty_buf();

  uint8_t stor[] = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x06, 0x06, id, 0x00, id, 0x00, 0x0D + id + id};

  HAL_UART_Transmit(&huart2, (uint8_t *)stor, 15, 100);
  HAL_UART_Receive(&huart2, buffer, 12, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return FINGERPRINT_OK;
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_BADLOCATION:
      return FINGERPRINT_BADLOCATION;
    case FINGERPRINT_FLASHERR:
      return FINGERPRINT_FLASHERR;
    default:
      return -1;
  }
}

uint16_t r308_search(void) {
  empty_buf();

  char serch1[]
      = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x08, 0x04, 0x01, 0x00, 0x01, 0x00, 0x80, 0x00, 0x8F};

  // if (r308_varyfypassword() != 0)
  //   return -3;
  // if (r308_getimage() != 0)
  //   return -3;
  // if (r308_img2tz(0x01) != 0)
  //   return -3;

  HAL_UART_Transmit(&huart2, (uint8_t *)serch1, 17, 500);
  HAL_UART_Receive(&huart2, buffer, 16, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return buffer[10] + buffer[11];
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_NOTFOUND:
      return FINGERPRINT_NOTFOUND;
    default:
      return -1;
  }
}

char r308_deletechar(int id) {
  empty_buf();

  uint8_t  del_fing[] = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x07, 0x0c, 0, 0, 0x00, 0x01, 0, 0};
  uint16_t s          = 0x15 + id;
  del_fing[10]        = (uint8_t)(id >> 8);
  del_fing[11]        = (uint8_t)(id & 0xff);
  s                   = 0x15 + del_fing[10] + del_fing[11];
  del_fing[14]        = (uint8_t)(s >> 8);
  del_fing[15]        = (uint8_t)(s & 0xff);

  HAL_UART_Transmit(&huart2, (uint8_t *)del_fing, 16, 100);
  HAL_UART_Receive(&huart2, buffer, 12, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return FINGERPRINT_OK;
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_DELETEFAIL:
      return FINGERPRINT_DELETEFAIL;
    default:
      return -1;
  }
}

char r308_empty(void) {
  empty_buf();

  char clearall[] = {0xEF, 0x01, 0xFF, 0xFF, 0xFF, 0xFF, 0x01, 0x00, 0x03, 0x0d, 0x00, 0x11};

  HAL_UART_Transmit(&huart2, (uint8_t *)clearall, 12, 100);
  HAL_UART_Receive(&huart2, buffer, 12, 1000);

  switch (ANSWER) {
    case FINGERPRINT_OK:
      return FINGERPRINT_OK;
    case FINGERPRINT_PACKETRECIEVEERR:
      return FINGERPRINT_PACKETRECIEVEERR;
    case FINGERPRINT_DBCLEARFAIL:
      return FINGERPRINT_DBCLEARFAIL;
    default:
      return -1;
  }
}
