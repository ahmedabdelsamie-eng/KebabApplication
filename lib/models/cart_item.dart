class CartItem {
  final String id;
  final String title;
  final String image;
  final String price;
  final String dadId;
  final String market;
  final Map<String, Map<String, String>> boughtCan;
  CartItem(
      {this.id,
      this.title,
      this.image,
      this.price,
      this.dadId,
      this.market,
      this.boughtCan});
}
