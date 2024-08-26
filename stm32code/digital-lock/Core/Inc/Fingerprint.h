#ifndef _FINGERPRINT_H
  #define _FINGERPTINT_H

  #include <stdint.h>

  #define FINGERPRINT_OK               0x00 // Command execution is complete
  #define FINGERPRINT_PACKETRECIEVEERR 0x01 // Error when receiving data package
  #define FINGERPRINT_NOFINGER         0x02 // No finger on the sensor (can't detect finger)
  #define FINGERPRINT_IMAGEFAIL        0x03 // Failed to collect finger
  #define FINGERPRINT_IMAGEMESS        0x06 // Failed to generate character file due to the over-disorderly fingerprint image
  #define FINGERPRINT_FEATUREFAIL \
    0x07 // Failed to generate character file due to lackness of character point or over-smallness
         // of fingerprint image
  #define FINGERPRINT_NOTFOUND       0x09 // Failed to find matching finger
  #define FINGERPRINT_DELETEFAIL     0x10 // Failed to delete the template
  #define FINGERPRINT_DBCLEARFAIL    0x11 // Failed to clear finger library
  #define FINGERPRINT_ENROLLMISMATCH 0x0A // Failed to combine the character files.
  #define FINGERPRINT_BADLOCATION    0x0B // Addressed PageID is beyond the finger library
  #define FINGERPRINT_WRONGPASSWORD  0x13 // Wrong password
  #define FINGERPRINT_FLASHERR       0x18 // Error when writing flash

char     r308_verifypassword(void);
char     r308_getimage(void);
char     r308_genchar(char id);
char     r308_regmodel(void);
char     r308_store(char id);
uint16_t r308_search(void);
char     r308_deletechar(int id);
char     r308_empty(void);

#endif /* _FINGERPRINT_H */
