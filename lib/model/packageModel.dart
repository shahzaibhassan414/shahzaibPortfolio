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
}