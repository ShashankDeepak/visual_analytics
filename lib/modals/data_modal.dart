// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:visual_analytics/controller/controller.dart';

class DataModal {
  String orderID;
  String productName;
  DateTime orderDate;
  String? description;
  double price;
  String user;
  int quantity;
  double? rating;
  DataModal({
    required this.orderID,
    required this.productName,
    required this.orderDate,
    this.description,
    required this.price,
    required this.user,
    required this.quantity,
    this.rating,
  });

  static DateTime generateDateTime(String date) {
    DateFormat format = Controller.dateFormat!;
    return format.parse(date);
  }

  static DataModal fromList(List<String> list) {
    return DataModal(
        orderID: list[Controller.dataIndex.orderIDIndex],
        productName:
            list[Controller.dataIndex.productNameIndex].replaceAll("\"", ""),
        orderDate: generateDateTime(list[Controller.dataIndex.orderDateIndex]),
        price: double.tryParse(list[Controller.dataIndex.priceIndex]) ?? 0.0,
        user: list[Controller.dataIndex.userIndex],
        quantity: int.tryParse(list[Controller.dataIndex.quantityIndex]) ??
            double.parse(list[Controller.dataIndex.quantityIndex]).round());
  }

  DataModal copyWith({
    String? orderID,
    String? productName,
    DateTime? orderDate,
    String? description,
    double? price,
    String? user,
    int? quantity,
    double? rating,
  }) {
    return DataModal(
      orderID: orderID ?? this.orderID,
      productName: productName ?? this.productName,
      orderDate: orderDate ?? this.orderDate,
      description: description ?? this.description,
      price: price ?? this.price,
      user: user ?? this.user,
      quantity: quantity ?? this.quantity,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderID': orderID,
      'productName': productName,
      'orderDate': orderDate.millisecondsSinceEpoch,
      'description': description,
      'price': price,
      'user': user,
      'quantity': quantity,
      'rating': rating,
    };
  }

  factory DataModal.fromMap(Map<String, dynamic> map) {
    return DataModal(
      orderID: map['orderID'] as String,
      productName: map['productName'] as String,
      orderDate: DateTime.fromMillisecondsSinceEpoch(map['orderDate'] as int),
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] as double,
      user: map['user'] as String,
      quantity: map['quantity'] as int,
      rating: map['rating'] != null ? map['rating'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataModal.fromJson(String source) =>
      DataModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataModal(orderID: $orderID, productName: $productName, orderDate: $orderDate, description: $description, price: $price, user: $user, quantity: $quantity, rating: $rating)';
  }

  @override
  bool operator ==(covariant DataModal other) {
    if (identical(this, other)) return true;

    return other.orderID == orderID &&
        other.productName == productName &&
        other.orderDate == orderDate &&
        other.description == description &&
        other.price == price &&
        other.user == user &&
        other.quantity == quantity &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return orderID.hashCode ^
        productName.hashCode ^
        orderDate.hashCode ^
        description.hashCode ^
        price.hashCode ^
        user.hashCode ^
        quantity.hashCode ^
        rating.hashCode;
  }
}
