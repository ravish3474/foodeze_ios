
import 'dart:convert';

KitcheModal kitcheModalFromMap(String str) => KitcheModal.fromMap(json.decode(str));

String kitcheModalToMap(KitcheModal data) => json.encode(data.toMap());

class KitcheModal {
    KitcheModal({
        this.curfew_status,
        this.categories,
        this.virtualKitchen,
        this.sliders,
        this.favouriteRestaurant,
        this.mostPopular,
        this.promoted,
    });

    String? curfew_status;
    List<Category>? categories;
    List<Promoted>? virtualKitchen;
    List<Slider>? sliders;
    List<FavouriteRestaurant>? favouriteRestaurant;
    List<MostPopular>? mostPopular;
    List<Promoted>? promoted;

    factory KitcheModal.fromMap(Map<String, dynamic> json) => KitcheModal(
        curfew_status: json["curfew_status"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
        virtualKitchen: List<Promoted>.from(json["virtual_kitchen"].map((x) => Promoted.fromMap(x))),
        sliders: List<Slider>.from(json["sliders"].map((x) => Slider.fromMap(x))),
        favouriteRestaurant: List<FavouriteRestaurant>.from(json["favourite_restaurant"].map((x) => FavouriteRestaurant.fromMap(x))),
        mostPopular: List<MostPopular>.from(json["most_popular"].map((x) => MostPopular.fromMap(x))),
        promoted: List<Promoted>.from(json["promoted"].map((x) => Promoted.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "categories": List<dynamic>.from(categories!.map((x) => x.toMap())),
        "virtual_kitchen": List<dynamic>.from(virtualKitchen!.map((x) => x.toMap())),
        "sliders": List<dynamic>.from(sliders!.map((x) => x.toMap())),
        "favourite_restaurant": List<dynamic>.from(favouriteRestaurant!.map((x) => x.toMap())),
        "most_popular": List<dynamic>.from(mostPopular!.map((x) => x.toMap())),
        "promoted": List<dynamic>.from(promoted!.map((x) => x.toMap())),
        "curfew_status": curfew_status,
    };
}

class Category {
    Category({
        this.id,
        this.rId,
        this.cat,
        this.image,
    });

    String? id;
    dynamic rId;
    String? cat;
    String? image;

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        rId: json["r_id"],
        cat: json["cat"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "r_id": rId,
        "cat": cat,
        "image": image,
    };
}

class FavouriteRestaurant {
    FavouriteRestaurant({
        this.restaurantFavourite,
        this.restaurant,
        this.totalRatings,
    });

    RestaurantFavourite? restaurantFavourite;
    Restaurant? restaurant;
    TotalRatings? totalRatings;

    factory FavouriteRestaurant.fromMap(Map<String, dynamic> json) => FavouriteRestaurant(
        restaurantFavourite: RestaurantFavourite.fromMap(json["RestaurantFavourite"]),
        restaurant: Restaurant.fromMap(json["Restaurant"]),
        totalRatings: json["TotalRatings"] == null ? null : TotalRatings.fromMap(json["TotalRatings"]),
    );

    Map<String, dynamic> toMap() => {
        "RestaurantFavourite": restaurantFavourite?.toMap(),
        "Restaurant": restaurant?.toMap(),
        "TotalRatings": totalRatings == null ? null : totalRatings?.toMap(),
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
        this.favourite,
        this.deliveryFee,
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
    dynamic tax;
    String? favourite;
    String? deliveryFee;

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
        currency: json["Currency"] == null ? null : Currency.fromMap(json["Currency"]),
        tax: json["Tax"],
        favourite: json["favourite"] == null ? null : json["favourite"],
        deliveryFee: json["delivery_fee"] == null ? null : json["delivery_fee"],
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
        "Currency": currency == null ? null : currency?.toMap(),
        "Tax": tax,
        "favourite": favourite == null ? null : favourite,
        "delivery_fee": deliveryFee == null ? null : deliveryFee,
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
    Country? country;
    CurrencyEnum? currency;
    Code? code;
    Symbol? symbol;

    factory Currency.fromMap(Map<String, dynamic> json) => Currency(
        id: json["id"],
        country: countryValues.map[json["country"]],
        currency: currencyEnumValues.map[json["currency"]],
        code: codeValues.map[json["code"]],
        symbol: symbolValues.map[json["symbol"]],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "country": countryValues.reverse[country],
        "currency": currencyEnumValues.reverse[currency],
        "code": codeValues.reverse[code],
        "symbol": symbolValues.reverse[symbol],
    };
}

enum Code { ZAR }

final codeValues = EnumValues({
    "ZAR": Code.ZAR
});

enum Country { SOUTH_AFRICA }

final countryValues = EnumValues({
    "South Africa": Country.SOUTH_AFRICA
});

enum CurrencyEnum { RANDS }

final currencyEnumValues = EnumValues({
    "Rands": CurrencyEnum.RANDS
});

enum Symbol { R }

final symbolValues = EnumValues({
    "R ": Symbol.R
});

class TaxClass {
    TaxClass({
        this.id,
        this.city,
        this.state,
        this.country,
        this.tax,
        this.deliveryFeePerKm,
        this.countryCode,
        this.deliveryTime,
        this.mainTax,
    });

    String? id;
    String? city;
    String? state;
    Country? country;
    String? tax;
    String? deliveryFeePerKm;
    String? countryCode;
    String? deliveryTime;
    String? mainTax;

    factory TaxClass.fromMap(Map<String, dynamic> json) => TaxClass(
        id: json["id"] == null ? null : json["id"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        country: json["country"] == null ? null : countryValues.map[json["country"]],
        tax: json["tax"] == null ? null : json["tax"],
        deliveryFeePerKm: json["delivery_fee_per_km"] == null ? null : json["delivery_fee_per_km"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        deliveryTime: json["delivery_time"] == null ? null : json["delivery_time"],
        mainTax: json["main_tax"] == null ? null : json["main_tax"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "country": country == null ? null : countryValues.reverse[country],
        "tax": tax == null ? null : tax,
        "delivery_fee_per_km": deliveryFeePerKm == null ? null : deliveryFeePerKm,
        "country_code": countryCode == null ? null : countryCode,
        "delivery_time": deliveryTime == null ? null : deliveryTime,
        "main_tax": mainTax == null ? null : mainTax,
    };
}

class RestaurantFavourite {
    RestaurantFavourite({
        this.id,
        this.restaurantId,
        this.userId,
        this.favourite,
    });

    String? id;
    String? restaurantId;
    String? userId;
    String? favourite;

    factory RestaurantFavourite.fromMap(Map<String, dynamic> json) => RestaurantFavourite(
        id: json["id"] == null ? null : json["id"],
        restaurantId: json["restaurant_id"] == null ? null : json["restaurant_id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        favourite: json["favourite"] == null ? null : json["favourite"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "restaurant_id": restaurantId == null ? null : restaurantId,
        "user_id": userId == null ? null : userId,
        "favourite": favourite == null ? null : favourite,
    };
}

class TotalRatings {
    TotalRatings({
        this.avg,
        this.totalRatings,
    });

    String? avg;
    String? totalRatings;

    factory TotalRatings.fromMap(Map<String, dynamic> json) => TotalRatings(
        avg: json["avg"],
        totalRatings: json["totalRatings"],
    );

    Map<String, dynamic> toMap() => {
        "avg": avg,
        "totalRatings": totalRatings,
    };
}

class MostPopular {
    MostPopular({
        this.restoName,
        this.dishName,
        this.restoId,
        this.dishImage,
        this.dishPrice,
    });

    String? restoName;
    String? dishName;
    String? restoId;
    String? dishImage;
    String? dishPrice;

    factory MostPopular.fromMap(Map<String, dynamic> json) => MostPopular(
        restoName: json["resto_name"],
        dishName: json["dish_name"],
        restoId: json["resto_id"],
        dishImage: json["dish_image"],
        dishPrice: json["dish_price"],
    );

    Map<String, dynamic> toMap() => {
        "resto_name": restoName,
        "dish_name": dishName,
        "resto_id": restoId,
        "dish_image": dishImage,
        "dish_price": dishPrice,
    };
}

class Promoted {
    Promoted({
        this.the0,
        this.restaurant,
        this.userInfo,
        this.restaurantLocation,
        this.currency,
        this.tax,
        this.restaurantFavourite,
        this.user,
        this.restaurantTiming,
        this.restaurantRating,
        this.totalRatings,
    });

    The0? the0;
    Restaurant? restaurant;
    UserInfo? userInfo;
    RestaurantLocation? restaurantLocation;
    Currency? currency;
    TaxClass? tax;
    RestaurantFavourite? restaurantFavourite;
    User? user;
    List<RestaurantTiming>? restaurantTiming;
    List<RestaurantRating>? restaurantRating;
    TotalRatings? totalRatings;

    factory Promoted.fromMap(Map<String, dynamic> json) => Promoted(
        the0: The0.fromMap(json["0"]),
        restaurant: Restaurant.fromMap(json["Restaurant"]),
        userInfo: UserInfo.fromMap(json["UserInfo"]),
        restaurantLocation: RestaurantLocation.fromMap(json["RestaurantLocation"]),
        currency: Currency.fromMap(json["Currency"]),
        tax: TaxClass.fromMap(json["Tax"]),
        restaurantFavourite: RestaurantFavourite.fromMap(json["RestaurantFavourite"]),
        user: User.fromMap(json["User"]),
        restaurantTiming: List<RestaurantTiming>.from(json["RestaurantTiming"].map((x) => RestaurantTiming.fromMap(x))),
        restaurantRating: List<RestaurantRating>.from(json["RestaurantRating"].map((x) => RestaurantRating.fromMap(x))),
        totalRatings: json["TotalRatings"] == null ? null : TotalRatings.fromMap(json["TotalRatings"]),
    );

    Map<String, dynamic> toMap() => {
        "0": the0?.toMap(),
        "Restaurant": restaurant?.toMap(),
        "UserInfo": userInfo?.toMap(),
        "RestaurantLocation": restaurantLocation?.toMap(),
        "Currency": currency?.toMap(),
        "Tax": tax?.toMap(),
        "RestaurantFavourite": restaurantFavourite?.toMap(),
        "User": user?.toMap(),
        "RestaurantTiming": List<dynamic>.from(restaurantTiming!.map((x) => x.toMap())),
        "RestaurantRating": List<dynamic>.from(restaurantRating!.map((x) => x.toMap())),
        "TotalRatings": totalRatings == null ? null : totalRatings!.toMap(),
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

class The0 {
    The0({
        this.distance,
    });

    String? distance;

    factory The0.fromMap(Map<String, dynamic> json) => The0(
        distance: json["distance"],
    );

    Map<String, dynamic> toMap() => {
        "distance": distance,
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

class Slider {
    Slider({
        this.id,
        this.image,
    });

    String? id;
    String? image;

    factory Slider.fromMap(Map<String, dynamic> json) => Slider(
        id: json["id"],
        image: json["image"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "image": image,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
