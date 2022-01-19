
import 'dart:convert';

FetchAddressModal fetchAddressModalFromMap(String str) => FetchAddressModal.fromMap(json.decode(str));

String fetchAddressModalToMap(FetchAddressModal data) => json.encode(data.toMap());

class FetchAddressModal {
    FetchAddressModal({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory FetchAddressModal.fromMap(Map<String, dynamic> json) => FetchAddressModal(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Datum {
    Datum({
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
        this.datumDefault,
        this.created,
        this.userId,
    });

    String? id;
    String? street;
    String? apartment;
    String? city;
    String? state;
    String? zip;
    String? country;
    String? lat;
    String? long;
    String? instructions;
    String? datumDefault;
    DateTime? created;
    String? userId;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
        datumDefault: json["default"],
        created: DateTime.parse(json["created"]),
        userId: json["user_id"],
    );

    Map<String, dynamic> toMap() => {
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
        "default": datumDefault,
        "created": created?.toIso8601String(),
        "user_id": userId,
    };
}
