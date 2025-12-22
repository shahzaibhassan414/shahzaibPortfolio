import 'package:flutter/widgets.dart';

class ExperienceModel {
  String? desig;
  String? compName;
  String? duration;
  Widget? points;

  ExperienceModel({this.desig, this.compName, this.duration, this.points});
}

class WorkModel {
  String? projectTitle;
  String? projectContent;
  List<String>? techs;

  WorkModel({
    this.projectTitle,
    this.projectContent,
    this.techs,
  });
}
