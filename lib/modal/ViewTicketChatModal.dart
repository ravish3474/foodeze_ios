



class ViewTicketChatModal {
    ViewTicketChatModal({
        this.status,
        this.data,
    });

    String? status;
    List<ChatDatum>? data;

    factory ViewTicketChatModal.fromMap(Map<String, dynamic> json) => ViewTicketChatModal(
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
        this.ticketId,
        this.customerId,
        this.fromCustomer,
        this.message,
        this.readStatus,
        this.chatTime,
    });

    String? chatId;
    String? ticketId;
    String? customerId;
    String? fromCustomer;
    String? message;
    String? readStatus;
    String? chatTime;

    factory ChatDatum.fromMap(Map<String, dynamic> json) => ChatDatum(
        chatId: json["chat_id"],
        ticketId: json["ticket_id"],
        customerId: json["customer_id"],
        fromCustomer: json["from_customer"],
        message: json["message"],
        readStatus: json["read_status"],
        chatTime: json["chatTime"],
    );

    Map<String, dynamic> toMap() => {
        "chat_id": chatId,
        "ticket_id": ticketId,
        "customer_id": customerId,
        "from_customer": fromCustomer,
        "message": message,
        "read_status": readStatus,
        "chat_time": chatTime,
    };
}
