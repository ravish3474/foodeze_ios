// To parse this JSON data, do
//
//     final UpdateModal = UpdateModalFromMap(jsonString);

import 'dart:convert';


class ApiResponseNew {
  ApiResponseNew({
     this.status,
  });

  String? status;


  factory ApiResponseNew.fromMap(Map<String, dynamic> json) => ApiResponseNew(
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "status": status,
  };
}



