class Prize {
  final int id;
  final String name;
  final String imageUrl;

  Prize({required this.id, required this.name, required this.imageUrl});

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
    };
  }
}
