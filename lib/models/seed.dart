class Seed {
  final String id;
  final String name;
  final String varietyName;
  final String cropName;
  final double price;
  final String image;
  final String description;
  final String growingSeason;
  final String yield;

  const Seed({
    required this.id,
    required this.name,
    required this.varietyName,
    required this.cropName,
    required this.price,
    required this.image,
    required this.description,
    required this.growingSeason,
    required this.yield,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'varietyName': varietyName,
      'cropName': cropName,
      'price': price,
      'image': image,
      'description': description,
      'growingSeason': growingSeason,
      'yield': yield,
    };
  }

  factory Seed.fromJson(Map<String, dynamic> json) {
    return Seed(
      id: json['id'],
      name: json['name'],
      varietyName: json['varietyName'],
      cropName: json['cropName'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
      growingSeason: json['growingSeason'],
      yield: json['yield'],
    );
  }
}
