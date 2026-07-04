class PackageModel {
  final String name;
  final String description;
  final String version;
  final String pubLink;
  final List<String> techs;

  PackageModel({
    required this.name,
    required this.description,
    required this.version,
    required this.pubLink,
    required this.techs,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      version: json['version']?.toString() ?? '',
      pubLink: json['pubLink']?.toString() ?? '',
      techs: _stringList(json['techs']),
    );
  }

  static List<String> _stringList(dynamic value) {
    if (value is! List) return const [];
    return value.map((item) => item.toString()).toList();
  }
}
