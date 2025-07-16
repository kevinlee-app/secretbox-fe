class Audio {
  final String name;
  final String fileUrl;

  Audio({
    required this.name,
    required this.fileUrl,
  });

  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      name: json['name'],
      fileUrl: json['file_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'file_url': fileUrl,
    };
  }
}