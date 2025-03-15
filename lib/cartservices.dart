import 'package:burtsbites/models/cartDataModel.dart';

class Cartservices {
  var idCounter = 1;
  
  final List<CartDataModel> CartDataList = List.generate(
      1,
      (index) => CartDataModel(
          id: index, productID: 1, productName: 'ITEM 1', productPrice: 11.99, productQty: 1));

  void greetUser(String name) {
    print("Hello, $name!");
  }


  void addItemToCart(int prodid, String prodname, double prodprice, int prodqty) {

    idCounter = idCounter++;
    CartDataList.add(CartDataModel(
        id: 1,
        productID: prodid,
        productName: prodname,
        productPrice: prodprice,
        productQty: prodqty));

  }  

    void displayCart() {

      CartDataList.forEach((CartDataList) {
        print('${CartDataList.productID}, ${CartDataList.productName}, ${CartDataList.productPrice} ');
      });

  }  
}


