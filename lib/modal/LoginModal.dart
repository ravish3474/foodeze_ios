// To parse this JSON data, do
//
//     final loginModal = loginModalFromMap(jsonString);

import 'dart:convert';

LoginModal loginModalFromMap(String str) => LoginModal.fromMap(json.decode(str));

String loginModalToMap(LoginModal data) => json.encode(data.toMap());

class LoginModal {
  LoginModal({
    required this.status,
     this.msg,
    required this.otp,
  });

  String status;
  Msg? msg;
  int otp;

  factory LoginModal.fromMap(Map<String, dynamic> json) => LoginModal(
    status: json["status"],
    msg: Msg.fromMap(json["msg"]),
    otp: json["otp"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "msg": msg?.toMap(),
    "otp": otp,
  };
}

class Msg {
  Msg({
    this.id,
    this.email,
    this.password,
    this.salt,
    this.active,
    this.block,
    this.created,
    this.token,
    this.role,
    this.resetLinkToken,
    this.expDate,
    this.userId,
    this.firstName,
    this.lastName,
    this.marketingMail,
    this.phone,
    this.profileImg,
    this.note,
    this.deviceToken,
    this.riderFee,
    this.online,
  });

  String? id;
  dynamic email;
  dynamic password;
  dynamic salt;
  String? active;
  String? block;
  DateTime? created;
  dynamic token;
  String? role;
  dynamic resetLinkToken;
  dynamic expDate;
  String? userId;
  dynamic firstName;
  dynamic lastName;
  dynamic marketingMail;
  String? phone;
  dynamic profileImg;
  dynamic note;
  dynamic deviceToken;
  String? riderFee;
  String? online;

  factory Msg.fromMap(Map<String, dynamic> json) => Msg(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    salt: json["salt"],
    active: json["active"],
    block: json["block"],
    created: DateTime.parse(json["created"]),
    token: json["token"],
    role: json["role"],
    resetLinkToken: json["reset_link_token"],
    expDate: json["exp_date"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    marketingMail: json["marketing_mail"],
    phone: json["phone"],
    profileImg: json["profile_img"],
    note: json["note"],
    deviceToken: json["device_token"],
    riderFee: json["rider_fee"],
    online: json["online"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "password": password,
    "salt": salt,
    "active": active,
    "block": block,
    "created": created?.toIso8601String(),
    "token": token,
    "role": role,
    "reset_link_token": resetLinkToken,
    "exp_date": expDate,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "marketing_mail": marketingMail,
    "phone": phone,
    "profile_img": profileImg,
    "note": note,
    "device_token": deviceToken,
    "rider_fee": riderFee,
    "online": online,
  };
}
