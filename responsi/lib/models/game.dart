class Game {
  final int id;
  final String title;
  final String? thumbnail;
  final String shortdescription;
  final String? gameurl;
  final double? rating;
  final List<dynamic> genres;
  final String publisher;
  final String developer;
  final String platform;
  final String description;
  final String releaseDate;
  final List<String> screenshots;

  Game({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.shortdescription,
    required this.gameurl,
    required this.rating,
    required this.genres,
    required this.publisher,
    required this.developer,
    required this.platform,
    required this.description,
    required this.releaseDate,
    required this.screenshots,
  });

    factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      title: json['title'] ?? '-',
      thumbnail: _toHttps(json['thumbnail']),
      shortdescription: json['short_description'] ?? '-',
      gameurl: _toHttps(json['game_url']),
      rating: null,
      genres: json['genre'] != null ? [json['genre']] : [],
      publisher: json['publisher'] ?? '-',
      developer: json['developer'] ?? '-',
      platform: json['platform'] ?? '-',
      description: json['description'] ?? '-',
      releaseDate: json['release_date'] ?? '-',
      screenshots: (json['screenshots'] as List<dynamic>? ?? [])
          .map((s) => s['image'].toString().replaceFirst('http://', 'https://'))
          .toList(),
          
    );
  }
  
  static String? _toHttps(String? url) => url?.replaceFirst('http://', 'https://');
  String get ratingText => rating == null ? '-' : rating.toString();
  String get cleanSummary => shortdescription.isEmpty
      ? 'Tidak ada ringkasan.'
      : shortdescription.replaceAll(RegExp(r'<[^>]*>'), '').trim();
}
