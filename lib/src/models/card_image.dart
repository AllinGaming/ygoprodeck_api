class CardImage {
  CardImage({
    required this.id,
    required this.imageUrl,
    required this.imageUrlSmall,
    this.imageUrlCropped,
  });

  final int id;
  final String imageUrl;
  final String imageUrlSmall;
  final String? imageUrlCropped;

  factory CardImage.fromJson(Map<String, dynamic> json) {
    return CardImage(
      id: json['id'] as int,
      imageUrl: json['image_url'] as String,
      imageUrlSmall: json['image_url_small'] as String,
      imageUrlCropped: json['image_url_cropped'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imageUrl,
      'image_url_small': imageUrlSmall,
      if (imageUrlCropped != null) 'image_url_cropped': imageUrlCropped,
    };
  }
}
