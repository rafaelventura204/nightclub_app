class Nightlife {
  final int id;
  final String name, city, address, description, urlImage;
  final double latitudine, longitutidine;
  final List<String> hour;
  final List<String> categories;

  Nightlife(
      {this.id,
      this.name,
      this.city,
      this.address,
      this.description,
      this.urlImage,
      this.latitudine,
      this.longitutidine,
      this.hour,
      this.categories});
}
