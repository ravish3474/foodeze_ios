
import 'dart:convert';

ViewCateringDetails viewCateringDetailsFromJson(String str) => ViewCateringDetails.fromJson(json.decode(str));

String viewCateringDetailsToJson(ViewCateringDetails data) => json.encode(data.toJson());

class ViewCateringDetails {
    ViewCateringDetails({
        this.code,
        this.msg,
    });

    int? code;
    List<Msg>? msg;

    factory ViewCateringDetails.fromJson(Map<String, dynamic> json) => ViewCateringDetails(
        code: json["code"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "msg": List<dynamic>.from(msg!.map((x) => x.toJson())),
    };
}

class Msg {
    Msg({
        this.cateringOrder,
        this.paymentMethod,
        this.userInfo,
        this.address,
        this.restaurant,
        this.couponUsed,
        this.cateringOrderMenuItem,
    });

    CateringOrder? cateringOrder;
    PaymentMethod? paymentMethod;
    UserInfo? userInfo;
    Address? address;
    Restaurant? restaurant;
    CouponUsed? couponUsed;
    List<CateringOrderMenuItem>? cateringOrderMenuItem;

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        cateringOrder: CateringOrder.fromJson(json["CateringOrder"]),
        paymentMethod: PaymentMethod.fromJson(json["PaymentMethod"]),
        userInfo: UserInfo.fromJson(json["UserInfo"]),
        address: Address.fromJson(json["Address"]),
        restaurant: Restaurant.fromJson(json["Restaurant"]),
        couponUsed: CouponUsed.fromJson(json["CouponUsed"]),
        cateringOrderMenuItem: List<CateringOrderMenuItem>.from(json["CateringOrderMenuItem"].map((x) => CateringOrderMenuItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "CateringOrder": cateringOrder?.toJson(),
        "PaymentMethod": paymentMethod?.toJson(),
        "UserInfo": userInfo?.toJson(),
        "Address": address?.toJson(),
        "Restaurant": restaurant?.toJson(),
        "CouponUsed": couponUsed?.toJson(),
        "CateringOrderMenuItem": List<dynamic>.from(cateringOrderMenuItem!.map((x) => x.toJson())),
    };
}

class Address {
    Address({
        this.id,
        this.street,
        this.apartment,
        this.city,
        this.state,
        this.zip,
        this.country,
        this.lat,
        this.long,
        this.instructions,
        this.addressDefault,
        this.created,
        this.userId,
    });

    dynamic id;
    dynamic street;
    dynamic apartment;
    dynamic city;
    dynamic state;
    dynamic zip;
    dynamic country;
    dynamic lat;
    dynamic long;
    dynamic instructions;
    dynamic addressDefault;
    dynamic created;
    dynamic userId;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        street: json["street"],
        apartment: json["apartment"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        country: json["country"],
        lat: json["lat"],
        long: json["long"],
        instructions: json["instructions"],
        addressDefault: json["default"],
        created: json["created"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "apartment": apartment,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
        "lat": lat,
        "long": long,
        "instructions": instructions,
        "default": addressDefault,
        "created": created,
        "user_id": userId,
    };
}

class CateringOrder {
    CateringOrder({
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
    dynamic deliveryFreeRange;
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

    factory CateringOrder.fromJson(Map<String, dynamic> json) => CateringOrder(
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
    };
}

class CateringOrderMenuItem {
    CateringOrderMenuItem({
        this.id,
        this.orderId,
        this.name,
        this.quantity,
        this.price,
        this.dealDescription,
        this.cateringOrderMenuExtraItem,
    });

    String? id;
    String? orderId;
    String? name;
    String? quantity;
    String? price;
    dynamic dealDescription;
    List<CateringOrderMenuExtraItem>? cateringOrderMenuExtraItem;

    factory CateringOrderMenuItem.fromJson(Map<String, dynamic> json) => CateringOrderMenuItem(
        id: json["id"],
        orderId: json["order_id"],
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        dealDescription: json["deal_description"],
        cateringOrderMenuExtraItem: List<CateringOrderMenuExtraItem>.from(json["CateringOrderMenuExtraItem"].map((x) => CateringOrderMenuExtraItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "name": name,
        "quantity": quantity,
        "price": price,
        "deal_description": dealDescription,
        "CateringOrderMenuExtraItem": List<dynamic>.from(cateringOrderMenuExtraItem!.map((x) => x.toJson())),
    };
}

class CateringOrderMenuExtraItem {
    CateringOrderMenuExtraItem({
        this.id,
        this.orderMenuItemId,
        this.name,
        this.quantity,
        this.price,
    });

    String? id;
    String? orderMenuItemId;
    String? name;
    String? quantity;
    String? price;

    factory CateringOrderMenuExtraItem.fromJson(Map<String, dynamic> json) => CateringOrderMenuExtraItem(
        id: json["id"],
        orderMenuItemId: json["order_menu_item_id"],
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_menu_item_id": orderMenuItemId,
        "name": name,
        "quantity": quantity,
        "price": price,
    };
}

class CouponUsed {
    CouponUsed({
        this.id,
        this.orderId,
        this.couponId,
        this.created,
    });

    dynamic id;
    dynamic orderId;
    dynamic couponId;
    dynamic created;

    factory CouponUsed.fromJson(Map<String, dynamic> json) => CouponUsed(
        id: json["id"],
        orderId: json["order_id"],
        couponId: json["coupon_id"],
        created: json["created"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "coupon_id": couponId,
        "created": created,
    };
}

class PaymentMethod {
    PaymentMethod({
        this.id,
        this.stripe,
        this.paypal,
        this.created,
        this.userId,
        this.paymentMethodDefault,
    });

    dynamic id;
    dynamic stripe;
    dynamic paypal;
    dynamic created;
    dynamic userId;
    dynamic paymentMethodDefault;

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        stripe: json["stripe"],
        paypal: json["paypal"],
        created: json["created"],
        userId: json["user_id"],
        paymentMethodDefault: json["default"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "stripe": stripe,
        "paypal": paypal,
        "created": created,
        "user_id": userId,
        "default": paymentMethodDefault,
    };
}

class Restaurant {
    Restaurant({
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
        this.currency,
        this.tax,
        this.restaurantLocation,
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
    Currency? currency;
    Tax? tax;
    RestaurantLocation? restaurantLocation;

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
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
        currency: Currency.fromJson(json["Currency"]),
        tax: Tax.fromJson(json["Tax"]),
        restaurantLocation: RestaurantLocation.fromJson(json["RestaurantLocation"]),
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
        "Currency": currency?.toJson(),
        "Tax": tax?.toJson(),
        "RestaurantLocation": restaurantLocation?.toJson(),
    };
}

class Currency {
    Currency({
        this.id,
        this.country,
        this.currency,
        this.code,
        this.symbol,
    });

    String? id;
    String? country;
    String? currency;
    String? code;
    String? symbol;

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        country: json["country"],
        currency: json["currency"],
        code: json["code"],
        symbol: json["symbol"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "currency": currency,
        "code": code,
        "symbol": symbol,
    };
}

class RestaurantLocation {
    RestaurantLocation({
        this.restaurantId,
        this.lat,
        this.long,
        this.city,
        this.state,
        this.country,
        this.street,
        this.zip,
    });

    String? restaurantId;
    String? lat;
    String? long;
    String? city;
    String? state;
    String? country;
    String? street;
    String? zip;

    factory RestaurantLocation.fromJson(Map<String, dynamic> json) => RestaurantLocation(
        restaurantId: json["restaurant_id"],
        lat: json["lat"],
        long: json["long"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        street: json["street"],
        zip: json["zip"],
    );

    Map<String, dynamic> toJson() => {
        "restaurant_id": restaurantId,
        "lat": lat,
        "long": long,
        "city": city,
        "state": state,
        "country": country,
        "street": street,
        "zip": zip,
    };
}

class Tax {
    Tax({
        this.test,
    });

    String? test;

    factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        test: json["test"],
    );

    Map<String, dynamic> toJson() => {
        "test": test,
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

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
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

    Map<String, dynamic> toJson() => {
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
