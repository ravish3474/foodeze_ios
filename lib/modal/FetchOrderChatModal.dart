

class FetchOrderChatModal {
    FetchOrderChatModal({
        this.status,
        this.data,
    });

    String? status;
    List<ChatDatum>? data;

    factory FetchOrderChatModal.fromMap(Map<String, dynamic> json) => FetchOrderChatModal(
        status: json["status"],
        data: List<ChatDatum>.from(json["data"].map((x) => ChatDatum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class ChatDatum {
    ChatDatum({
        this.chatId,
        this.chatTime,
        this.customerId,
        this.fromCustomer,
        this.message,
        this.orderId,
        this.riderId,
    });



    String? chatId;
    String? chatTime;
    String? customerId;
    String? fromCustomer;
    String? message;
    String? orderId;
    String? riderId;

    factory ChatDatum.fromMap(Map<String, dynamic> json) => ChatDatum(
        chatId: json["chat_id"],
        chatTime: json["chat_time"],
        customerId: json["customer_id"],
        fromCustomer: json["from_customer"],
        message: json["message"],
        orderId: json["order_id"],
        riderId: json["rider_id"],
    );

    Map<String, dynamic> toMap() => {
        "chat_id": chatId,
        "chat_time": chatTime,
        "customer_id": customerId,
        "from_customer": fromCustomer,
        "message": message,
        "order_id": orderId,
        "rider_id": riderId,
    };
}
