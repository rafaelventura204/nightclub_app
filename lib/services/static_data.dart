import 'package:bar_pub/models/property.dart';

class StaticData {
  static final List<Property> properties = [
    Property(
      name: "Santeria Social CLub",
      description: "Luogo bellissimo dove passare un buon momento con amici",
      price: "20£",
      imagePath: "assets/images/profiloProva.png",
    ),
    Property(
      name: "La Fontanella",
      description:
          "Se stai cercando un posto al centro della movida milanese Le Fontanelle è il posto per te",
      price: "20£",
      imagePath: "assets/images/profiloProva.png",
    ),
  ];
}
