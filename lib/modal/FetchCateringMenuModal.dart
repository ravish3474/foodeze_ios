
import 'dart:convert';

FetchCateringMenuModal fetchCateringMenuModalFromJson(String str) => FetchCateringMenuModal.fromJson(json.decode(str));

String fetchCateringMenuModalToJson(FetchCateringMenuModal data) => json.encode(data.toJson());

class FetchCateringMenuModal {
    FetchCateringMenuModal({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory FetchCateringMenuModal.fromJson(Map<String, dynamic> json) => FetchCateringMenuModal(
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
        this.catering,
        this.currency,
        this.tax,
        this.cateringMenu,
        this.restaurant,
    });

    Catering? catering;
    Currency? currency;
    Tax? tax;
    List<CateringMenu>? cateringMenu;
    Restaurant? restaurant;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        catering: Catering.fromJson(json["Catering"]),
        currency: Currency.fromJson(json["Currency"]),
        tax: Tax.fromJson(json["Tax"]),
        cateringMenu: List<CateringMenu>.from(json["CateringMenu"].map((x) => CateringMenu.fromJson(x))),
        restaurant: Restaurant.fromJson(json["Restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "Catering": catering?.toJson(),
        "Currency": currency?.toJson(),
        "Tax": tax?.toJson(),
        "CateringMenu": List<dynamic>.from(cateringMenu!.map((x) => x.toJson())),
        "Restaurant": restaurant?.toJson(),
    };
}

class Catering {
    Catering({
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

    factory Catering.fromJson(Map<String, dynamic> json) => Catering(
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
    };
}

class CateringMenu {
    CateringMenu({
        this.id,
        this.name,
        this.description,
        this.created,
        this.restaurantId,
        this.image,
        this.active,
        this.hasMenuItem,
        this.index,
        this.cateringMenuItem,
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
    List<CateringMenuItem>? cateringMenuItem;

    factory CateringMenu.fromJson(Map<String, dynamic> json) => CateringMenu(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        created: DateTime.parse(json["created"]),
        restaurantId: json["restaurant_id"],
        image: json["image"],
        active: json["active"],
        hasMenuItem: json["has_menu_item"],
        index: json["index"],
        cateringMenuItem: List<CateringMenuItem>.from(json["CateringMenuItem"].map((x) => CateringMenuItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "created": created?.toIso8601String(),
        "restaurant_id": restaurantId,
        "image": image,
        "active": active,
        "has_menu_item": hasMenuItem,
        "index": index,
        "CateringMenuItem": List<dynamic>.from(cateringMenuItem!.map((x) => x.toJson())),
    };
}

class CateringMenuItem {
    CateringMenuItem({
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
        this.cateringMenuExtraSection,
    });

    String? id;
    String? name;
    String? description;
    String? category;
    String? price;
    dynamic quantity;
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
    dynamic restId;
    List<CateringMenuExtraSection>? cateringMenuExtraSection;

    factory CateringMenuItem.fromJson(Map<String, dynamic> json) => CateringMenuItem(
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
        cateringMenuExtraSection: List<CateringMenuExtraSection>.from(json["CateringMenuExtraSection"].map((x) => CateringMenuExtraSection.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
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
        "CateringMenuExtraSection": List<dynamic>.from(cateringMenuExtraSection!.map((x) => x.toJson())),
    };
}

class CateringMenuExtraSection {
    CateringMenuExtraSection({
        this.id,
        this.name,
        this.restaurantId,
        this.active,
        this.restaurantMenuItemId,
        this.required,
        this.cateringMenuExtraItem,
    });

    String? id;
    String? name;
    String? restaurantId;
    String? active;
    String? restaurantMenuItemId;
    String? required;
    List<CateringMenuExtraItem>? cateringMenuExtraItem;

    factory CateringMenuExtraSection.fromJson(Map<String, dynamic> json) => CateringMenuExtraSection(
        id: json["id"],
        name: json["name"],
        restaurantId: json["restaurant_id"],
        active: json["active"],
        restaurantMenuItemId: json["restaurant_menu_item_id"],
        required: json["required"],
        cateringMenuExtraItem: List<CateringMenuExtraItem>.from(json["CateringMenuExtraItem"].map((x) => CateringMenuExtraItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "restaurant_id": restaurantId,
        "active": active,
        "restaurant_menu_item_id": restaurantMenuItemId,
        "required": required,
        "CateringMenuExtraItem": List<dynamic>.from(cateringMenuExtraItem!.map((x) => x.toJson())),
    };
}

class CateringMenuExtraItem {
    CateringMenuExtraItem({
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

    factory CateringMenuExtraItem.fromJson(Map<String, dynamic> json) => CateringMenuExtraItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        created: DateTime.parse(json["created"]),
        active: json["active"],
        restaurantMenuExtraSectionId: json["restaurant_menu_extra_section_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "created": created?.toIso8601String(),
        "active": active,
        "restaurant_menu_extra_section_id": restaurantMenuExtraSectionId,
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

class Restaurant {
    Restaurant({
        this.open,
    });

    String? open;

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        open: json["open"],
    );

    Map<String, dynamic> toJson() => {
        "open": open,
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

    String? id;
    String? city;
    String? state;
    String? country;
    String? tax;
    String? deliveryFeePerKm;
    String? countryCode;
    String? deliveryTime;

    factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
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
        "city": city,
        "state": state,
        "country": country,
        "tax": tax,
        "delivery_fee_per_km": deliveryFeePerKm,
        "country_code": countryCode,
        "delivery_time": deliveryTime,
    };
}
