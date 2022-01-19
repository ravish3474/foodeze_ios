//
//     final virtualKitchenModal = virtualKitchenModalFromMap(jsonString);

import 'dart:convert';

VirtualKitchenModal virtualKitchenModalFromMap(String str) => VirtualKitchenModal.fromMap(json.decode(str));

String virtualKitchenModalToMap(VirtualKitchenModal data) => json.encode(data.toMap());

class VirtualKitchenModal {
    VirtualKitchenModal({
         this.status,
         this.data,
         this.rating,
         this.curfew_status,
    });

    String? status;
    List<Datum>? data;
    String? rating;
    String? curfew_status;

    factory VirtualKitchenModal.fromMap(Map<String, dynamic> json) => VirtualKitchenModal(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        rating: json["rating"],
        curfew_status: json["curfew_status"],
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "rating": rating,
        "curfew_status": curfew_status,
    };
}

class Datum {
    Datum({
        this.restaurant,
        this.currency,
        this.tax,
        this.restaurantMenu,
        this.mainData,
    });

    Restaurant? restaurant;
    Currency? currency;
    Tax? tax;
    List<RestaurantMenu>? restaurantMenu;
    MainData? mainData;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        restaurant: Restaurant.fromMap(json["Restaurant"]),
        currency: Currency.fromMap(json["Currency"]),
        tax: Tax.fromMap(json["Tax"]),
        restaurantMenu: List<RestaurantMenu>.from(json["RestaurantMenu"].map((x) => RestaurantMenu.fromMap(x))),
        mainData: MainData.fromMap(json["main_data"]),
    );

    Map<String, dynamic> toMap() => {
        "Restaurant": restaurant?.toMap(),
        "Currency": currency?.toMap(),
        "Tax": tax?.toMap(),
        "RestaurantMenu": List<dynamic>.from(restaurantMenu!.map((x) => x.toMap())),
        "main_data": mainData?.toMap(),
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

    factory Currency.fromMap(Map<String, dynamic> json) => Currency(
        id: json["id"],
        country: json["country"],
        currency: json["currency"],
        code: json["code"],
        symbol: json["symbol"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "country": country,
        "currency": currency,
        "code": code,
        "symbol": symbol,
    };
}

class MainData {
    MainData({
        this.restaurant,
        this.user,
        this.userInfo,
        this.currency,
        this.tax,
        this.restaurantLocation,
        this.restaurantTiming,
        this.restaurantRating,
    });

    Restaurant? restaurant;
    User? user;
    UserInfo? userInfo;
    Currency? currency;
    Tax? tax;
    RestaurantLocation? restaurantLocation;
    List<RestaurantTiming>? restaurantTiming;
    List<RestaurantRating>? restaurantRating;

    factory MainData.fromMap(Map<String, dynamic> json) => MainData(
        restaurant: Restaurant.fromMap(json["Restaurant"]),
        user: User.fromMap(json["User"]),
        userInfo: UserInfo.fromMap(json["UserInfo"]),
        currency: Currency.fromMap(json["Currency"]),
        tax: Tax.fromMap(json["Tax"]),
        restaurantLocation: RestaurantLocation.fromMap(json["RestaurantLocation"]),
        restaurantTiming: List<RestaurantTiming>.from(json["RestaurantTiming"].map((x) => RestaurantTiming.fromMap(x))),
        restaurantRating: List<RestaurantRating>.from(json["RestaurantRating"].map((x) => RestaurantRating.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "Restaurant": restaurant?.toMap(),
        "User": user?.toMap(),
        "UserInfo": userInfo?.toMap(),
        "Currency": currency?.toMap(),
        "Tax": tax?.toMap(),
        "RestaurantLocation": restaurantLocation?.toMap(),
        "RestaurantTiming": List<dynamic>.from(restaurantTiming!.map((x) => x.toMap())),
        "RestaurantRating": List<dynamic>.from(restaurantRating!.map((x) => x.toMap())),
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
        this.open,
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
    String? open;

    factory Restaurant.fromMap(Map<String, dynamic> json) => Restaurant(
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
        open: json["open"] == null ? null : json["open"],
    );

    Map<String, dynamic> toMap() => {
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
        "open": open == null ? null : open,
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

    factory RestaurantLocation.fromMap(Map<String, dynamic> json) => RestaurantLocation(
        restaurantId: json["restaurant_id"],
        lat: json["lat"],
        long: json["long"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        street: json["street"],
        zip: json["zip"],
    );

    Map<String, dynamic> toMap() => {
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

class RestaurantRating {
    RestaurantRating({
        this.id,
        this.star,
        this.comment,
        this.created,
        this.userId,
        this.restaurantId,
    });

    String? id;
    String? star;
    String? comment;
    DateTime? created;
    String? userId;
    String? restaurantId;

    factory RestaurantRating.fromMap(Map<String, dynamic> json) => RestaurantRating(
        id: json["id"],
        star: json["star"],
        comment: json["comment"],
        created: DateTime.parse(json["created"]),
        userId: json["user_id"],
        restaurantId: json["restaurant_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "star": star,
        "comment": comment,
        "created": created?.toIso8601String(),
        "user_id": userId,
        "restaurant_id": restaurantId,
    };
}

class RestaurantTiming {
    RestaurantTiming({
        this.id,
        this.day,
        this.openingTime,
        this.closingTime,
        this.restaurantId,
    });

    String? id;
    String? day;
    String? openingTime;
    String? closingTime;
    String? restaurantId;

    factory RestaurantTiming.fromMap(Map<String, dynamic> json) => RestaurantTiming(
        id: json["id"],
        day: json["day"],
        openingTime: json["opening_time"],
        closingTime: json["closing_time"],
        restaurantId: json["restaurant_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "day": day,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "restaurant_id": restaurantId,
    };
}

class Tax {
    Tax({
        this.id,
        this.city,
        this.state,
        this.country,
        this.tax,
        this.deliveryFeePerKm,
        this.countryCode,
        this.deliveryTime,
    });

    dynamic id;
    dynamic city;
    dynamic state;
    dynamic country;
    dynamic tax;
    dynamic deliveryFeePerKm;
    dynamic countryCode;
    dynamic deliveryTime;

    factory Tax.fromMap(Map<String, dynamic> json) => Tax(
        id: json["id"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        tax: json["tax"],
        deliveryFeePerKm: json["delivery_fee_per_km"],
        countryCode: json["country_code"],
        deliveryTime: json["delivery_time"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "city": city,
        "state": state,
        "country": country,
        "tax": tax,
        "delivery_fee_per_km": deliveryFeePerKm,
        "country_code": countryCode,
        "delivery_time": deliveryTime,
    };
}

class User {
    User({
        this.id,
        this.email,
        this.active,
    });

    String? id;
    String? email;
    String? active;

    factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        active: json["active"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "active": active,
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
    dynamic marketingMail;
    String? phone;
    dynamic profileImg;
    dynamic note;
    dynamic deviceToken;
    dynamic riderFee;
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

class RestaurantMenu {
    RestaurantMenu({
        this.id,
        this.name,
        this.description,
        this.created,
        this.restaurantId,
        this.image,
        this.active,
        this.hasMenuItem,
        this.index,
        this.restaurantMenuItem,
    });

    String? id;
    String? name;
    String? description;
    DateTime? created;
    String? restaurantId;
    String? image;
    String? active;
    String? hasMenuItem;
    String? index;
    List<RestaurantMenuItem>? restaurantMenuItem;

    factory RestaurantMenu.fromMap(Map<String, dynamic> json) => RestaurantMenu(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        created: DateTime.parse(json["created"]),
        restaurantId: json["restaurant_id"],
        image: json["image"],
        active: json["active"],
        hasMenuItem: json["has_menu_item"],
        index: json["index"],
        restaurantMenuItem: List<RestaurantMenuItem>.from(json["RestaurantMenuItem"].map((x) => RestaurantMenuItem.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "created": created?.toIso8601String(),
        "restaurant_id": restaurantId,
        "image": image,
        "active": active,
        "has_menu_item": hasMenuItem,
        "index": index,
        "RestaurantMenuItem": List<dynamic>.from(restaurantMenuItem!.map((x) => x.toMap())),
    };
}

class RestaurantMenuItem {
    RestaurantMenuItem({
        this.id,
        this.name,
        this.description,
        this.category,
        this.price,
        this.quantity,
        this.image,
        this.created,
        this.active,
        this.restaurantMenuId,
        this.outOfOrder,
        this.sunOpen,
        this.sunClose,
        this.monOpen,
        this.monClose,
        this.tueOpen,
        this.tueClose,
        this.wedOpen,
        this.wedClose,
        this.thuOpen,
        this.thuClose,
        this.friOpen,
        this.friClose,
        this.satOpen,
        this.satClose,
        this.tempmeal,
        this.restId,
        this.restaurantMenuExtraSection,
    });

    String? id;
    String? name;
    String? description;
    String? category;
    String? price;
    String? quantity;
    String? image;
    DateTime? created;
    String? active;
    String? restaurantMenuId;
    String? outOfOrder;
    dynamic sunOpen;
    dynamic sunClose;
    dynamic monOpen;
    dynamic monClose;
    dynamic tueOpen;
    dynamic tueClose;
    dynamic wedOpen;
    dynamic wedClose;
    dynamic thuOpen;
    dynamic thuClose;
    dynamic friOpen;
    dynamic friClose;
    dynamic satOpen;
    dynamic satClose;
    dynamic tempmeal;
    String? restId;
    List<RestaurantMenuExtraSection>? restaurantMenuExtraSection;

    factory RestaurantMenuItem.fromMap(Map<String, dynamic> json) => RestaurantMenuItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        price: json["price"],
        quantity: json["quantity"],
        image: json["image"],
        created: DateTime.parse(json["created"]),
        active: json["active"],
        restaurantMenuId: json["restaurant_menu_id"],
        outOfOrder: json["out_of_order"],
        sunOpen: json["sun_open"],
        sunClose: json["sun_close"],
        monOpen: json["mon_open"],
        monClose: json["mon_close"],
        tueOpen: json["tue_open"],
        tueClose: json["tue_close"],
        wedOpen: json["wed_open"],
        wedClose: json["wed_close"],
        thuOpen: json["thu_open"],
        thuClose: json["thu_close"],
        friOpen: json["fri_open"],
        friClose: json["fri_close"],
        satOpen: json["sat_open"],
        satClose: json["sat_close"],
        tempmeal: json["tempmeal"],
        restId: json["rest_id"],
        restaurantMenuExtraSection: List<RestaurantMenuExtraSection>.from(json["RestaurantMenuExtraSection"].map((x) => RestaurantMenuExtraSection.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "category": category,
        "price": price,
        "quantity": quantity,
        "image": image,
        "created": created?.toIso8601String(),
        "active": active,
        "restaurant_menu_id": restaurantMenuId,
        "out_of_order": outOfOrder,
        "sun_open": sunOpen,
        "sun_close": sunClose,
        "mon_open": monOpen,
        "mon_close": monClose,
        "tue_open": tueOpen,
        "tue_close": tueClose,
        "wed_open": wedOpen,
        "wed_close": wedClose,
        "thu_open": thuOpen,
        "thu_close": thuClose,
        "fri_open": friOpen,
        "fri_close": friClose,
        "sat_open": satOpen,
        "sat_close": satClose,
        "tempmeal": tempmeal,
        "rest_id": restId,
        "RestaurantMenuExtraSection": List<dynamic>.from(restaurantMenuExtraSection!.map((x) => x.toMap())),
    };
}

class RestaurantMenuExtraSection {
    RestaurantMenuExtraSection({
        this.id,
        this.name,
        this.restaurantId,
        this.active,
        this.restaurantMenuItemId,
        this.required,
        this.restaurantMenuExtraItem,
    });

    String? id;
    String? name;
    String? restaurantId;
    String? active;
    String? restaurantMenuItemId;
    String? required;
    List<RestaurantMenuExtraItem>? restaurantMenuExtraItem;

    factory RestaurantMenuExtraSection.fromMap(Map<String, dynamic> json) => RestaurantMenuExtraSection(
        id: json["id"],
        name: json["name"],
        restaurantId: json["restaurant_id"],
        active: json["active"],
        restaurantMenuItemId: json["restaurant_menu_item_id"],
        required: json["required"],
        restaurantMenuExtraItem: List<RestaurantMenuExtraItem>.from(json["RestaurantMenuExtraItem"].map((x) => RestaurantMenuExtraItem.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "restaurant_id": restaurantId,
        "active": active,
        "restaurant_menu_item_id": restaurantMenuItemId,
        "required": required,
        "RestaurantMenuExtraItem": List<dynamic>.from(restaurantMenuExtraItem!.map((x) => x.toMap())),
    };
}

class RestaurantMenuExtraItem {
    RestaurantMenuExtraItem({
        this.id,
        this.name,
        this.price,
        this.created,
        this.active,
        this.restaurantMenuExtraSectionId,
    });

    String? id;
    String? name;
    String? price;
    DateTime? created;
    String? active;
    String? restaurantMenuExtraSectionId;

    factory RestaurantMenuExtraItem.fromMap(Map<String, dynamic> json) => RestaurantMenuExtraItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        created: DateTime.parse(json["created"]),
        active: json["active"],
        restaurantMenuExtraSectionId: json["restaurant_menu_extra_section_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
        "created": created?.toIso8601String(),
        "active": active,
        "restaurant_menu_extra_section_id": restaurantMenuExtraSectionId,
    };
}
