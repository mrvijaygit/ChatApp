class Message {
  int? userId;
  String? message;

  Message(this.userId, this.message);

  Message.map(dynamic obj) {
    userId  = obj["id"];
    message = obj["message"];
  }

  int? get id => userId;
  String? get msg => message;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = userId;
    map["message"] = message;
    return map;
  }
}