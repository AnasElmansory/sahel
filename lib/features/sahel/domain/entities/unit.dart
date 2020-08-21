class Unit {
  final String name;
  final String description;
  final int price;
  final List<dynamic> images;
  final double longitude;
  final double latitude;

  const Unit(
      {this.longitude,
      this.latitude,
      this.name,
      this.description,
      this.price,
      this.images});
}
