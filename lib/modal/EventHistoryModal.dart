
import 'dart:convert';

EventHistoryModal customerTicketsModalFromMap(String str) => EventHistoryModal.fromMap(json.decode(str));

String customerTicketsModalToMap(EventHistoryModal msg) => json.encode(msg.toMap());

class EventHistoryModal {
    EventHistoryModal({
        this.status,
        this.msg,
    });

    String? status;
    List<EventDatumMy>? msg;

    factory EventHistoryModal.fromMap(Map<String, dynamic> json) => EventHistoryModal(
        status: json["status"],
        msg: List<EventDatumMy>.from(json["msg"].map((x) => EventDatumMy.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "msg": List<dynamic>.from(msg!.map((x) => x.toMap())),
    };
}

class EventDatumMy {


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
    String? transaction_id;
    String? no_of_person;

    EventDatumMy({
      this.no_of_person,
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
      this.transaction_id,
    });



    factory EventDatumMy.fromMap(Map<String, dynamic> json) => EventDatumMy(
        no_of_person: json["no_of_person"],
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
        transaction_id: json["transaction_id"],
    );

    Map<String, dynamic> toMap() => {
        "no_of_person": no_of_person,
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
        "transaction_id": transaction_id,
    };
}
