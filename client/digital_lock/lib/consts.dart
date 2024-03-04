// ignore_for_file: constant_identifier_names

enum Mode {
  // Normal mode
  NORMAL,
  // disable everythings
  DISABLE,
  // can't open the lock with keypad or fingerprint
  LOCK,
  // send status message
  SEND_STATUS,

  // CRUD operations for users management
  CREATE_USER,
  READ_USER,
  UPDATE_USER,
  DELETE_USER,

  // set new settings with keypad
  GET_SETTINGS_FROM_KEYPAD,

  // set new settings with sms
  GET_SETTINGS_FROM_SMS,
}

/*
enum Mode {
  NORMAL(1),
  DISABLE(2);

  const Mode(this.value);
  final int value;
}
*/
