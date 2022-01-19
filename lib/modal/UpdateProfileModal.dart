//
//     final updateProfileModal = updateProfileModalFromMap(jsonString);

import 'dart:convert';

UpdateProfileModal updateProfileModalFromMap(String str) => UpdateProfileModal.fromMap(json.decode(str));

String updateProfileModalToMap(UpdateProfileModal data) => json.encode(data.toMap());

class UpdateProfileModal {
    UpdateProfileModal({
        this.status,
        this.data,
    });

    String? status;
    Data? data;

    factory UpdateProfileModal.fromMap(Map<String, dynamic> json) => UpdateProfileModal(
        status: json["status"],
        data: Data.fromMap(json["data"]),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": data?.toMap(),
    };
}

class Data {
    Data({
        this.userInfo,
        this.user,
    });

    UserInfo? userInfo;
    User? user;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        userInfo: UserInfo.fromMap(json["UserInfo"]),
        user: User.fromMap(json["User"]),
    );

    Map<String, dynamic> toMap() => {
        "UserInfo": userInfo?.toMap(),
        "User": user?.toMap(),
    };
}

class User {
    User({
        this.id,
        this.email,
        this.active,
        this.role,
    });

    String? id;
    dynamic email;
    String? active;
    String? role;

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        active: json["active"],
        role: json["role"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "active": active,
        "role": role,
    };
}

class UserInfo {
    UserInfo({
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

    String? userId;
    String? firstName;
    String? lastName;
    String? marketingMail;
    String? phone;
    String? profileImg;
    dynamic note;
    String? deviceToken;
    String? riderFee;
    String? online;

    factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
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
