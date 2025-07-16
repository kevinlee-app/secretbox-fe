class Company {
  final int id;
  final String name;
  final String brandImageUrl;

  Company({required this.id, required this.name, required this.brandImageUrl});

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
      brandImageUrl: json['brand_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand_image': brandImageUrl,
    };
  }
}
