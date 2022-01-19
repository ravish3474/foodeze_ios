
import 'dart:convert';

EventModal customerTicketsModalFromMap(String str) => EventModal.fromMap(json.decode(str));

String customerTicketsModalToMap(EventModal data) => json.encode(data.toMap());


class EventModal {
    EventModal({
        this.status,
        this.data,
    });

    String? status;
    List<EventDatum>? data;

    factory EventModal.fromMap(Map<String, dynamic> json) => EventModal(
        status: json["status"],
        data: List<EventDatum>.from(json["data"].map((x) => EventDatum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class EventDatum {


    String? address;
    String? city;
    String? desert;
    String? drinks;
    String? event_banner;
    String? event_date;
    String? event_description;
    String? event_starter;
    String? event_time;
    String? event_title;
    String? id;
    String? location;
    String? main_course;
    String? price;
    String? quantity;
    String? restaurent_id;
    String? tax;
  //  String? transaction_id;
    String? province;

    EventDatum({
      this.address,
      this.city,
      this.desert,
      this.drinks,
      this.event_banner,
      this.event_date,
      this.event_description,
      this.event_starter,
      this.event_time,
      this.event_title,
      this.id,
      this.location,
      this.main_course,
      this.price,
      this.quantity,
      this.restaurent_id,
      this.tax,
     // this.transaction_id,
      this.province,
    });



    factory EventDatum.fromMap(Map<String, dynamic> json) => EventDatum(
        address: json["address"],
        city: json["city"],
        desert: json["desert"],
        drinks: json["drinks"],
        event_banner: json["event_banner"],
        event_date: json["event_date"],
        event_description: json["event_description"],
        event_starter: json["event_starter"],
        event_time: json["event_time"],
        event_title: json["event_title"],
        id: json["id"],
        location: json["location"],
        main_course: json["main_course"],
        price: json["price"],
        quantity: json["quantity"],
        restaurent_id: json["restaurent_id"],
        tax: json["tax"],
       // transaction_id: json["transaction_id"],
        province: json["province"],
    );

    Map<String, dynamic> toMap() => {
        "address": address,
        "city": city,
        "desert": desert,
        "drinks": drinks,
        "event_banner": event_banner,
        "event_date": event_date,
        "event_description": event_description,
        "event_starter": event_starter,
        "event_time": event_time,
        "event_title": event_title,
        "id": id,
        "location": location,
        "main_course": main_course,
        "price": price,
        "quantity": quantity,
        "restaurent_id": restaurent_id,
        "tax": tax,
       // "transaction_id": transaction_id,
        "province": province,
    };
}
