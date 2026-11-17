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
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    final img = json['image'];
    return Game(
      id: json['id'],
      title: json['name'] ?? '-',
      thumbnail: _toHttps(img?['medium']),
      shortdescription: json['short_description'] ?? '-',
      gameurl: _toHttps(json['game_url']),
      rating: (json['rating']?['average'] as num?)?.toDouble(),
      genres: json['genres'] ?? [],
      publisher: json['publisher'] ?? '-',
      developer: json['developer'] ?? '-',
      platform: json['platform'] ?? '-',
    );
  }
  static String? _toHttps(String? url) => url?.replaceFirst('http://', 'https://');
  String get ratingText => rating == null ? '-' : rating.toString();
  String get cleanSummary => shortdescription.isEmpty
      ? 'Tidak ada ringkasan.'
      : shortdescription.replaceAll(RegExp(r'<[^>]*>'), '').trim();
}
