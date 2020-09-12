class Cart {
  String id;
  String name;
  String imageUrl;
  String productId;
  double price;
  int quantity;
  String restaurantId;

  Cart(
      {this.id,
      this.name,
      this.imageUrl,
      this.productId,
      this.price,
      this.quantity,
      this.restaurantId});

  Cart.fromMap(Map<String, dynamic> tojson) {
    id = tojson["id"];
    name = tojson["name"];
    imageUrl = tojson["imageUrl"];
    productId = tojson["productId"];
    price = tojson["price"];
    quantity = tojson["quantity"];
    restaurantId = tojson["restaurantId"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["imageUrl"] = this.imageUrl;
    data["productId"] = this.productId;
    data["price"] = this.price;
    data["quantity"] = this.quantity;
    data[restaurantId] = this.restaurantId;

    return data;
  }
}
