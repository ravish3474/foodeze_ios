
import 'dart:convert';

CouponModal couponModalFromMap(String str) => CouponModal.fromMap(json.decode(str));

String couponModalToMap(CouponModal data) => json.encode(data.toMap());

class CouponModal {
    CouponModal({
        this.status,
        this.msg,
    });

    String? status;
    List<Msg>? msg;

    factory CouponModal.fromMap(Map<String, dynamic> json) => CouponModal(
        status: json["status"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "msg": List<dynamic>.from(msg!.map((x) => x.toMap())),
    };
}

class Msg {
    Msg({
        this.id,
        this.restaurantId,
        this.userId,
        this.couponCode,
        this.discount,
        this.expireDate,
        this.type,
        this.limitUsers,
        this.vkAdmin,
    });

    String? id;
    String? restaurantId;
    dynamic userId;
    String? couponCode;
    String? discount;
    DateTime? expireDate;
    dynamic type;
    String? limitUsers;
    String? vkAdmin;

    factory Msg.fromMap(Map<String, dynamic> json) => Msg(
        id: json["id"],
        restaurantId: json["restaurant_id"],
        userId: json["user_id"],
        couponCode: json["coupon_code"],
        discount: json["discount"],
        expireDate: DateTime.parse(json["expire_date"]),
        type: json["type"],
        limitUsers: json["limit_users"],
        vkAdmin: json["vk_admin"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "restaurant_id": restaurantId,
        "user_id": userId,
        "coupon_code": couponCode,
        "discount": discount,
        "expire_date": "${expireDate?.year.toString().padLeft(4, '0')}-${expireDate?.month.toString().padLeft(2, '0')}-${expireDate?.day.toString().padLeft(2, '0')}",
        "type": type,
        "limit_users": limitUsers,
        "vk_admin": vkAdmin,
    };
}
