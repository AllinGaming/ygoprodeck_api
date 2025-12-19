/// Image URLs for a card artwork.
class CardImage {
  CardImage({
    required this.id,
    required this.imageUrl,
    required this.imageUrlSmall,
    this.imageUrlCropped,
  });

  /// Card ID for this image entry.
  final int id;

  /// Full-size image URL.
  final String imageUrl;

  /// Small thumbnail URL.
  final String imageUrlSmall;

  /// Cropped artwork URL.
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
