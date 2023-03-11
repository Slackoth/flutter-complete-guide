class CartItem {
  String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    this.id = '', 
    required this.title, 
    required this.quantity, 
    required this.price
  });

  CartItem.fromJson(Map<String, dynamic> json, this.id) : 
    title = json['title'],
    quantity = json['quantity'],
    price = json['price'];

  Map<String, dynamic> toJson() => {
    // 'id': id,
    'title': title,
    'quantity': quantity,
    'price': price
  };
}
