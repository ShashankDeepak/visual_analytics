/*
  int orderID;
  int productName;
  int productID;
  int? description;
  double price;
  int user;
  int quantity;
  double? rating;
*/

class DataIndex {
  int orderIDIndex;
  int productNameIndex;
  int orderDateIndex;
  int? descriptionIndex;
  int priceIndex;
  int userIndex;
  int quantityIndex;
  int? ratingIndex;

  DataIndex({
    required this.orderIDIndex,
    required this.productNameIndex,
    required this.orderDateIndex,
    this.descriptionIndex,
    required this.priceIndex,
    required this.userIndex,
    required this.quantityIndex,
    this.ratingIndex,
  });
}
