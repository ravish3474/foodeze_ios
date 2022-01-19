// To parse this JSON data, do
//
//     final UpdateModal = UpdateModalFromMap(jsonString);

import 'dart:convert';

UpdateModal UpdateModalFromMap(String str) => UpdateModal.fromMap(json.decode(str));

String UpdateModalToMap(UpdateModal data) => json.encode(data.toMap());

class UpdateModal {
  UpdateModal({
    required this.status,
     this.msg,
  });

  String status;
  String? msg;
 

  factory UpdateModal.fromMap(Map<String, dynamic> json) => UpdateModal(
    status: json["status"],
    msg: json["msg"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "msg": msg,
  };
}



