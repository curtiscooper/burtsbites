class Order {
  final int orderID;
  final int userID;
  final String orderDate;
  final double orderTotal;

  Order(
      {required this.orderID,
      required this.userID,
      required this.orderDate,
      required this.orderTotal});
}
