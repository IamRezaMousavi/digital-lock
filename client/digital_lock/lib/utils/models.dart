class Message {
  int? id;
  String? address;
  String? text;
  int? date;

  Message({
    this.id,
    this.address,
    this.text,
    this.date,
  });

  factory Message.fromMap(Map<String, dynamic> json) => Message(
        id: json['id'],
        address: json['address'],
        text: json['text'],
        date: json['date'],
      );

  Map<String, dynamic> toMap() => {
      'id': id,
      'address': address,
      'text': text,
      'date': date,
    };
}

class MessageText {
  String name;
  int code;

  MessageText({required this.name, required this.code});

  factory MessageText.fromMap(Map<String, dynamic> json) => MessageText(
        name: json['name'],
        code: json['code'],
      );

  Map<String, dynamic> toMap() => {
      'name': name,
      'code': code,
    };
}

class User {
  int? id;
  String name;
  int? date;

  User({
    this.id,
    required this.name,
    this.date,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        name: json['name'],
        date: json['date'],
      );

  Map<String, dynamic> toMap() => {
      'id': id,
      'name': name,
      'date': date,
    };
}
