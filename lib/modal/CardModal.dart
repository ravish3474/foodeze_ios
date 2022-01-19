import 'dart:collection';

import 'package:hive/hive.dart';

import 'ExtraMenuItemModal.dart';
import 'package:equatable/equatable.dart';


part 'CardModal.g.dart';


@HiveType(typeId: 3)
class CardModal   {
  @HiveField(0)
  String? rowId;

  @HiveField(1)
  String? cardNumber;

  @HiveField(2)
  String? expiryDate;


  @HiveField(3)
  String? cardHolderName;

  @HiveField(4)
  String? cvvCode;


  Map toJson() => {
    'rowId':rowId,
    'cardNumber':cardNumber,
    'expiryDate':expiryDate,
    'cardHolderName':cardHolderName,
    'cvvCode':cvvCode,
  };


  CardModal({this.rowId, this.cardNumber, this.expiryDate, this.cardHolderName,
      this.cvvCode});




  @override
  String toString() {
    return 'CardModal{rowId: $rowId, cardNumber: $cardNumber, expiryDate: $expiryDate, cardHolderName: $cardHolderName, cvvCode: $cvvCode}';
  }





}





