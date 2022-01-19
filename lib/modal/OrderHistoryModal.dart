
import 'dart:convert';

OrderHistoryModal orderHistoryModalFromMap(String str) => OrderHistoryModal.fromMap(json.decode(str));

String orderHistoryModalToMap(OrderHistoryModal data) => json.encode(data.toMap());

class OrderHistoryModal {
    OrderHistoryModal({
        this.status,
        this.data,
    });

    String? status;
    List<Datum>? data;

    factory OrderHistoryModal.fromMap(Map<String, dynamic> json) => OrderHistoryModal(
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
        this.riderSearchStatus,
        this.riderInstructions,
        this.riderUserId,
        this.assignerUserId,
        this.orderId,
        this.assignDateTime,
        this.acceptRejectStatus,
        this.acceptRejectDateTime,
        this.riderTransactionId,
        this.snap,
        this.customerOrderId,
    });

    dynamic id;
    String? dealId;
    dynamic created;
    String? price;
    String? status;
    String? deliveryFee;
    String? userId;
    String? addressId;
    String? paymentMethodId;
    String? quantity;
    String? delivery;
    String? riderTip;
    String? tax;
    String? subTotal;
    String? restaurantId;
    String? instructions;
    String? acceptedReason;
    String? hotelAccepted;
    String? cod;
    String? notification;
    String? rejectedReason;
    String? restaurantDeliveryFee;
    String? totalDistanceBetweenUserAndRestaurant;
    String? deliveryFeePerKm;
    String? deliveryFreeRange;
    String? discount;
    String? tracking;
    String? stripeCharge;
    String? device;
    String? version;
    String? restaurantTransactionId;
    dynamic deliveryDateTime;
    String? riderSearchStatus;
    dynamic riderInstructions;
    dynamic riderUserId;
    dynamic assignerUserId;
    dynamic orderId;
    dynamic assignDateTime;
    dynamic acceptRejectStatus;
    dynamic acceptRejectDateTime;
    dynamic riderTransactionId;
    dynamic snap;
    String? customerOrderId;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dealId: json["deal_id"],
        created: json["created"],
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
        riderSearchStatus: json["rider_search_status"],
        riderInstructions: json["rider_instructions"],
        riderUserId: json["rider_user_id"],
        assignerUserId: json["assigner_user_id"],
        orderId: json["order_id"],
        assignDateTime: json["assign_date_time"],
        acceptRejectStatus: json["accept_reject_status"],
        acceptRejectDateTime: json["accept_reject_dateTime"],
        riderTransactionId: json["rider_transaction_id"],
        snap: json["snap"],
        customerOrderId: json["customer_order_id"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "deal_id": dealId,
        "created": created,
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
        "rider_search_status": riderSearchStatus,
        "rider_instructions": riderInstructions,
        "rider_user_id": riderUserId,
        "assigner_user_id": assignerUserId,
        "order_id": orderId,
        "assign_date_time": assignDateTime,
        "accept_reject_status": acceptRejectStatus,
        "accept_reject_dateTime": acceptRejectDateTime,
        "rider_transaction_id": riderTransactionId,
        "snap": snap,
        "customer_order_id": customerOrderId,
    };
}
