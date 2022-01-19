
import 'dart:convert';

AvailableLocModal availableLocModalFromMap(String str) => AvailableLocModal.fromMap(json.decode(str));

String availableLocModalToMap(AvailableLocModal data) => json.encode(data.toMap());

class AvailableLocModal {
    AvailableLocModal({
        this.status,
        this.data,
    });

    String? status;
    Data? data;

    factory AvailableLocModal.fromMap(Map<String, dynamic> json) => AvailableLocModal(
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
        this.deliverable,
        this.nonDelivarable,
    });

    List<NonDelivarable>? deliverable;
    List<NonDelivarable>? nonDelivarable;

    factory Data.fromMap(Map<String, dynamic> json) => Data(
        deliverable: List<NonDelivarable>.from(json["deliverable"].map((x) => NonDelivarable.fromMap(x))),
        nonDelivarable: List<NonDelivarable>.from(json["non_delivarable"].map((x) => NonDelivarable.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "deliverable": List<dynamic>.from(deliverable!.map((x) => x.toMap())),
        "non_delivarable": List<dynamic>.from(nonDelivarable!.map((x) => x.toMap())),
    };
}

class NonDelivarable {
    NonDelivarable({
        this.id,
        this.available,
        this.street,
        this.apartment,
        this.city,
        this.state,
        this.zip,
        this.country,
        this.lat,
        this.long,
        this.instructions,
        this.nonDelivarableDefault,
        this.created,
        this.userId,
    });

    String? id;
    String? available;
    String? street;
    String? apartment;
    String? city;
    String? state;
    String? zip;
    String? country;
    String? lat;

    @override
  String toString() {
    return 'NonDelivarable{id: $id, available: $available, street: $street, apartment: $apartment, city: $city, state: $state, zip: $zip, country: $country, lat: $lat, long: $long, instructions: $instructions, nonDelivarableDefault: $nonDelivarableDefault, created: $created, userId: $userId}';
  }

  String? long;
    String? instructions;
    String? nonDelivarableDefault;
    DateTime? created;
    String? userId;

    factory NonDelivarable.fromMap(Map<String, dynamic> json) => NonDelivarable(
        id: json["id"],
        available: json["available"],
        street: json["street"],
        apartment: json["apartment"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        country: json["country"],
        lat: json["lat"],
        long: json["long"],
        instructions: json["instructions"],
        nonDelivarableDefault: json["default"],
        created: DateTime.parse(json["created"]),
        userId: json["user_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "available": available,
        "street": street,
        "apartment": apartment,
        "city": city,
        "state": state,
        "zip": zip,
        "country": country,
        "lat": lat,
        "long": long,
        "instructions": instructions,
        "default": nonDelivarableDefault,
        "created": created?.toIso8601String(),
        "user_id": userId,
    };
}
