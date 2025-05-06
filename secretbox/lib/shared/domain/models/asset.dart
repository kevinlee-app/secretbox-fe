class Asset {
  final String backgroundImageUrl;
  final String boxClosedUrl;
  final String boxOpenedUrl;

  Asset({
    required this.backgroundImageUrl,
    required this.boxClosedUrl,
    required this.boxOpenedUrl,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      backgroundImageUrl: json['background_image_url'] as String,
      boxClosedUrl: json['box_closed_url'] as String,
      boxOpenedUrl: json['box_opened_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'background_image_url': backgroundImageUrl,
      'box_closed_url': boxClosedUrl,
      'box_opened_url': boxOpenedUrl,
    };
  }
}