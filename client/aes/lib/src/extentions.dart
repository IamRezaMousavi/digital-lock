part of aes;

extension Uint8ListExtensions on Uint8List? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension Uint8ListExtension on Uint8List {
  Uint8List addList(Uint8List other) {
    final totalLength = this.length + other.length;
    final newList = Uint8List(totalLength)    
      ..setAll(0, this)
      ..setRange(this.length, totalLength, other);
    return newList;
  }

  bool isNotEqual(Uint8List other) {
    if (identical(this, other)) return false;
    final length = this.length;
    if (length != other.length) return true;
    for (var i = 0; i < length; i++) {
      if (this[i] != other[i]) return true;
    }
    return false;
  }

  // Converts bytes to UTF-16 string
  String toUtf16String() {
    final bytes = this.buffer;
    final uint16 = bytes.asUint16List();
    return String.fromCharCodes(uint16);
  }

  // Converts bytes to UTF-8 string
  String toUtf8String() => String.fromCharCodes(this);

  String toHexString() {
    final str = StringBuffer();
    this.forEach((item) {
      str.write(item.toRadixString(16).toUpperCase().padLeft(2, '0'));
    });
    return str.toString();
  }

  void fillByZero() => this.fillRange(0, this.length, 0);
}

extension StringExtensions on String? {
  // Returns true if string is: null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension StringExtension on String {
  // Converts UTF-16 string to bytes
  Uint16List toUtf16Bytes() => Uint16List.fromList(this.codeUnits);

  // Converts string to UTF-8 bytes
  Uint8List toUtf8Bytes() => utf8.encode(this);
}

extension FileExtension on File {
  bool isReadable() {
    RandomAccessFile f;

    try {
      f = this.openSync(mode: FileMode.read);
    } on FileSystemException {
      return false;
    }

    try {
      f.lockSync(FileLock.shared);
    } on FileSystemException {
      f.closeSync();
      return false;
    }

    f
      ..unlockSync()
      ..closeSync();
    return true;
  }
}
