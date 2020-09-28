class Cart {
  String id;
  String name;
  String imageUrl;
  String productId;
  String price;
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
    id = tojson["id"] != null ? tojson["id"] : null;
    name = tojson["name"] != null ? tojson["name"] : null;
    imageUrl = tojson["imageUrl"] != null ? tojson["imageUrl"] : null;
    productId = tojson["productId"] != null ? tojson["productId"] : null;
    price = tojson["price"] != null ? tojson["price"] : null;
    quantity = tojson["quantity"] != null ? tojson["quantity"] : 0;
    restaurantId =
        tojson["restaurantId"] != null ? tojson["restaurantId"] : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["imageUrl"] = this.imageUrl;
    data["productId"] = this.productId;
    data["price"] = this.price;
    data["quantity"] = this.quantity;
    data["restaurantId"] = this.restaurantId;

    return data;
  }
}
