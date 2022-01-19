
import 'dart:convert';

CateringFetchRequest cateringFetchRequestFromJson(String str) => CateringFetchRequest.fromJson(json.decode(str));

String cateringFetchRequestToJson(CateringFetchRequest data) => json.encode(data.toJson());

class CateringFetchRequest {
    CateringFetchRequest({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory CateringFetchRequest.fromJson(Map<String, dynamic> json) => CateringFetchRequest(
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
        this.dealId,
        this.created,
        this.price,
        this.status,
        this.deliveryFee,
        this.userId,
        this.addressId,
        this.paymentMethodId,
        this.quantity,
        this.delivery,
        this.riderTip,
        this.tax,
        this.subTotal,
        this.restaurantId,
        this.instructions,
        this.acceptedReason,
        this.hotelAccepted,
        this.cod,
        this.notification,
        this.rejectedReason,
        this.restaurantDeliveryFee,
        this.totalDistanceBetweenUserAndRestaurant,
        this.deliveryFeePerKm,
        this.deliveryFreeRange,
        this.discount,
        this.tracking,
        this.stripeCharge,
        this.device,
        this.version,
        this.restaurantTransactionId,
        this.deliveryDateTime,
        this.eventTitle,
        this.eventDescription,
        this.duration,
        this.eventLocation,
        this.eventCity,
        this.eventProvince,
        this.comment,
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
        this.currencyId,
        this.taxId,
        this.taxFree,
        this.coverImage,
        this.notes,
        this.defaultPortion,
        this.addedBy,
        this.updated,
        this.googleAnalytics,
        this.block,
        this.singleRestaurant,
        this.adminCommission,
        this.type,
        this.readNotification,
    });

    String? id;
    dynamic dealId;
    DateTime? created;
    String? price;
    String? status;
    dynamic deliveryFee;
    String? userId;
    dynamic addressId;
    dynamic paymentMethodId;
    dynamic quantity;
    String? delivery;
    dynamic riderTip;
    String? tax;
    String? subTotal;
    String? restaurantId;
    String? instructions;
    dynamic acceptedReason;
    String? hotelAccepted;
    dynamic cod;
    dynamic notification;
    dynamic rejectedReason;
    dynamic restaurantDeliveryFee;
    dynamic totalDistanceBetweenUserAndRestaurant;
    dynamic deliveryFeePerKm;
    String? deliveryFreeRange;
    dynamic discount;
    dynamic tracking;
    dynamic stripeCharge;
    String? device;
    String? version;
    dynamic restaurantTransactionId;
    String? deliveryDateTime;
    String? eventTitle;
    String? eventDescription;
    String? duration;
    String? eventLocation;
    String? eventCity;
    String? eventProvince;
    dynamic comment;
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
    String? currencyId;
    String? taxId;
    String? taxFree;
    String? coverImage;
    String? notes;
    String? defaultPortion;
    String? addedBy;
    DateTime? updated;
    String? googleAnalytics;
    String? block;
    String? singleRestaurant;
    String? adminCommission;
    String? type;
    String? readNotification;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dealId: json["deal_id"],
        created: DateTime.parse(json["created"]),
        price: json["price"],
        status: json["status"],
        deliveryFee: json["delivery_fee"],
        userId: json["user_id"],
        addressId: json["address_id"],
        paymentMethodId: json["payment_method_id"],
        quantity: json["quantity"],
        delivery: json["delivery"],
        riderTip: json["rider_tip"],
        tax: json["tax"],
        subTotal: json["sub_total"],
        restaurantId: json["restaurant_id"],
        instructions: json["instructions"],
        acceptedReason: json["accepted_reason"],
        hotelAccepted: json["hotel_accepted"],
        cod: json["cod"],
        notification: json["notification"],
        rejectedReason: json["rejected_reason"],
        restaurantDeliveryFee: json["restaurant_delivery_fee"],
        totalDistanceBetweenUserAndRestaurant: json["total_distance_between_user_and_restaurant"],
        deliveryFeePerKm: json["delivery_fee_per_km"],
        deliveryFreeRange: json["delivery_free_range"],
        discount: json["discount"],
        tracking: json["tracking"],
        stripeCharge: json["stripe_charge"],
        device: json["device"],
        version: json["version"],
        restaurantTransactionId: json["restaurant_transaction_id"],
        deliveryDateTime: json["delivery_date_time"],
        eventTitle: json["event_title"],
        eventDescription: json["event_description"],
        duration: json["duration"],
        eventLocation: json["event_location"],
        eventCity: json["event_city"],
        eventProvince: json["event_province"],
        comment: json["comment"],
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
        currencyId: json["currency_id"],
        taxId: json["tax_id"],
        taxFree: json["tax_free"],
        coverImage: json["cover_image"],
        notes: json["notes"],
        defaultPortion: json["default_portion"],
        addedBy: json["added_by"],
        updated: DateTime.parse(json["updated"]),
        googleAnalytics: json["google_analytics"],
        block: json["block"],
        singleRestaurant: json["single_restaurant"],
        adminCommission: json["admin_commission"],
        type: json["type"],
        readNotification: json["read_notification"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "deal_id": dealId,
        "created": created?.toIso8601String(),
        "price": price,
        "status": status,
        "delivery_fee": deliveryFee,
        "user_id": userId,
        "address_id": addressId,
        "payment_method_id": paymentMethodId,
        "quantity": quantity,
        "delivery": delivery,
        "rider_tip": riderTip,
        "tax": tax,
        "sub_total": subTotal,
        "restaurant_id": restaurantId,
        "instructions": instructions,
        "accepted_reason": acceptedReason,
        "hotel_accepted": hotelAccepted,
        "cod": cod,
        "notification": notification,
        "rejected_reason": rejectedReason,
        "restaurant_delivery_fee": restaurantDeliveryFee,
        "total_distance_between_user_and_restaurant": totalDistanceBetweenUserAndRestaurant,
        "delivery_fee_per_km": deliveryFeePerKm,
        "delivery_free_range": deliveryFreeRange,
        "discount": discount,
        "tracking": tracking,
        "stripe_charge": stripeCharge,
        "device": device,
        "version": version,
        "restaurant_transaction_id": restaurantTransactionId,
        "delivery_date_time": deliveryDateTime,
        "event_title": eventTitle,
        "event_description": eventDescription,
        "duration": duration,
        "event_location": eventLocation,
        "event_city": eventCity,
        "event_province": eventProvince,
        "comment": comment,
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
        "currency_id": currencyId,
        "tax_id": taxId,
        "tax_free": taxFree,
        "cover_image": coverImage,
        "notes": notes,
        "default_portion": defaultPortion,
        "added_by": addedBy,
        "updated": updated?.toIso8601String(),
        "google_analytics": googleAnalytics,
        "block": block,
        "single_restaurant": singleRestaurant,
        "admin_commission": adminCommission,
        "type": type,
        "read_notification": readNotification,
    };
}
