#ifndef __MODES_H
#define __MODES_H

typedef enum Mode {
  // Normal mode
  NORMAL = 0,
  // can't open the lock with keypad or fingerprint
  LOCK,
  // when checking for password
  CHECK_PASSWORD,
  // send status message
  SEND_STATUS,

  // CRUD operations for users management
  CREATE_USER,
  READ_USER,
  UPDATE_USER,
  DELETE_USER,
  GET_USERS,
  DELETE_USERS,

  // set new settings with keypad
  GET_SETTINGS_FROM_KEYPAD,

  // set new settings with sms
  GET_SETTINGS_FROM_SMS,

  // for save settings varibles to EEPROM
  WRITE_SETTINGS_TO_EEPROM,

} Mode;

typedef enum Status {
  ON = 0,
  OFF,

} Status;

#endif /* __MODES_H */
