class OrdersProducts {
  final int userID;
  final int orderID;
  final String orderDate;
  final double orderTotal;
  final int productID;
  final String productName;

  OrdersProducts(
      {required this.userID,
       required this.orderID,
      required this.orderDate,
      required this.orderTotal,
      required this.productID,
      required this.productName});
}
