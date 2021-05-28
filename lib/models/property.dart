class Property {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final String hour;
  final String distance;
  final String address;
  final double latitudine, longitudine;

  Property(
      {this.id,
      this.name,
      this.description,
      this.imagePath,
      this.hour,
      this.distance,
      this.address,
      this.latitudine,
      this.longitudine});
}
