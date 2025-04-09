class ProductDTO {
  final int id;
  final String name;

  ProductDTO({required this.id, required this.name});

  factory ProductDTO.fromJson(Map<String, dynamic> json) {
    return ProductDTO(id: json['id'] as int, name: json['name'] as String);
  }
}
