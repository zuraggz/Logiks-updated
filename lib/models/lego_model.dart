class LegoModel {
  final String? id;
  final String name;
  final int yearOfCreation;
  final int numberOfPieces;
  final double price;

  const LegoModel({
    this.id,
    required this.name,
    required this.yearOfCreation,
    required this.numberOfPieces,
    required this.price,
  });

  //this function returns LegoModel instance from coming JSON
  factory LegoModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    return LegoModel(
      id: json['id'] as String?,
      name: json['name'] as String? ?? 'Unnamed',
      yearOfCreation: (data?['year'] as num?)?.toInt() ?? 0,
      numberOfPieces: (data?['pieces'] as num?)?.toInt() ?? 0,
      price: (data?['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  //converts LegoModel into Map so we can pass it to jsonEncode
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "data": {
        "year": yearOfCreation,
        "pieces": numberOfPieces,
        "price": price,
      },
    };
  }
}
