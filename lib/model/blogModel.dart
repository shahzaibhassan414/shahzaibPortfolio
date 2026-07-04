class BlogModel {
  final String title;
  final String description;
  final String imageUrl;
  final String link;
  final String date;

  BlogModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.date,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      imageUrl: json['imageUrl']?.toString() ?? '',
      link: json['link']?.toString() ?? '',
      date: json['date']?.toString() ?? '',
    );
  }
}
