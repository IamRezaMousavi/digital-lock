#ifndef _GSM_H
#define _GSM_H

/*************** Command register ***************/
#define ENABLE_TEXT_MODE    "AT+CMGF=1"
#define SEND_SMS            "AT+CMGS="
#define READ_SMS            "AT+CMGR=1"
#define DELETE_ALL_SMS      "AT+CMGDA="
#define DELETE_ALL_SMS_MODE "DEL ALL"
#define SMS_REC_NOTIF       "+CMTI"

#define Enter            10
#define Double_Quotation 34
// #define CR               13
// #define SUB              26

/************************************** Helper macros **************************************/
#define _GSM_USE_FREERTOS 1

/***************  template function prototype  ***********/
void Gsm_SendSms(char *phonenumber, char *message);
void Gsm_WaitForMessage(char *result);

#endif
