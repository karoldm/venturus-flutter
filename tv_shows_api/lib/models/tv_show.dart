class TvShow {
  final String id;
  final String name;
  final String imageUrl;
  final String webChannel;
  final double rating;
  final String summary;

  TvShow({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.webChannel,
    required this.rating,
    required this.summary,
  });

  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      id: json['id'].toString(),
      name: json['name'] as String,
      imageUrl: json['image'] != null
          ? (json['image']['medium'] as String)
          : 'https://placehold.co/600x400',
      webChannel: json['webChannel'] != null
          ? (json['webChannel']['name'] as String)
          : 'N/A',
      rating: (json['rating']['average'] ?? 0) as double,
      summary: json['summary'] as String? ?? '',
    );
  }
}
