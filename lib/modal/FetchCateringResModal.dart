
import 'dart:convert';

FetchCateringResModal fetchCateringResModalFromJson(String str) => FetchCateringResModal.fromJson(json.decode(str));

String fetchCateringResModalToJson(FetchCateringResModal data) => json.encode(data.toJson());

class FetchCateringResModal {
    FetchCateringResModal({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory FetchCateringResModal.fromJson(Map<String, dynamic> json) => FetchCateringResModal(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.name,
        this.slogan,
        this.about,
        this.speciality,
        this.phone,
        this.timezone,
        this.menuStyle,
        this.promoted,
        this.image,
        this.preparationTime,
        this.minOrderPrice,
        this.deliveryFreeRange,
        this.currencyId,
        this.taxId,
        this.taxFree,
        this.coverImage,
        this.notes,
        this.userId,
        this.defaultPortion,
        this.addedBy,
        this.created,
        this.updated,
        this.googleAnalytics,
        this.block,
        this.singleRestaurant,
        this.adminCommission,
        this.type,
        this.readNotification,
        this.city,
        this.state,
        this.country,
        this.tax,
        this.deliveryFeePerKm,
        this.countryCode,
        this.deliveryTime,
    });

    String? id;
    String? name;
    String? slogan;
    String? about;
    String? speciality;
    String? phone;
    String? timezone;
    String? menuStyle;
    String? promoted;
    String? image;
    String? preparationTime;
    String? minOrderPrice;
    String? deliveryFreeRange;
    String? currencyId;
    String? taxId;
    String? taxFree;
    String? coverImage;
    String? notes;
    String? userId;
    String? defaultPortion;
    String? addedBy;
    DateTime? created;
    DateTime? updated;
    String? googleAnalytics;
    String? block;
    String? singleRestaurant;
    String? adminCommission;
    String? type;
    String? readNotification;
    String? city;
    String? state;
    String? country;
    String? tax;
    String? deliveryFeePerKm;
    String? countryCode;
    String? deliveryTime;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        slogan: json["slogan"],
        about: json["about"],
        speciality: json["speciality"],
        phone: json["phone"],
        timezone: json["timezone"],
        menuStyle: json["menu_style"],
        promoted: json["promoted"],
        image: json["image"],
        preparationTime: json["preparation_time"],
        minOrderPrice: json["min_order_price"],
        deliveryFreeRange: json["delivery_free_range"],
        currencyId: json["currency_id"],
        taxId: json["tax_id"],
        taxFree: json["tax_free"],
        coverImage: json["cover_image"],
        notes: json["notes"],
        userId: json["user_id"],
        defaultPortion: json["default_portion"],
        addedBy: json["added_by"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        googleAnalytics: json["google_analytics"],
        block: json["block"],
        singleRestaurant: json["single_restaurant"],
        adminCommission: json["admin_commission"],
        type: json["type"],
        readNotification: json["read_notification"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        tax: json["tax"],
        deliveryFeePerKm: json["delivery_fee_per_km"],
        countryCode: json["country_code"],
        deliveryTime: json["delivery_time"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slogan": slogan,
        "about": about,
        "speciality": speciality,
        "phone": phone,
        "timezone": timezone,
        "menu_style": menuStyle,
        "promoted": promoted,
        "image": image,
        "preparation_time": preparationTime,
        "min_order_price": minOrderPrice,
        "delivery_free_range": deliveryFreeRange,
        "currency_id": currencyId,
        "tax_id": taxId,
        "tax_free": taxFree,
        "cover_image": coverImage,
        "notes": notes,
        "user_id": userId,
        "default_portion": defaultPortion,
        "added_by": addedBy,
        "created": created?.toIso8601String(),
        "updated": updated?.toIso8601String(),
        "google_analytics": googleAnalytics,
        "block": block,
        "single_restaurant": singleRestaurant,
        "admin_commission": adminCommission,
        "type": type,
        "read_notification": readNotification,
        "city": city,
        "state": state,
        "country": country,
        "tax": tax,
        "delivery_fee_per_km": deliveryFeePerKm,
        "country_code": countryCode,
        "delivery_time": deliveryTime,
    };
}
