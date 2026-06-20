import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../Widgets/recruiter_intro_widgets.dart';
import '../../resource/appClass.dart';

class IntroWeb extends StatelessWidget {
  final AutoScrollController scrollController;

  const IntroWeb(this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: AppClass().getMqHeight(context) - 80,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(
        vertical: AppClass().getMqHeight(context) * 0.09,
      ),
      alignment: Alignment.center,
      child: RecruiterIntroHero(
        onViewWork: () => _scrollTo(5),
        onContact: () => _scrollTo(7),
      ),
    );
  }

  void _scrollTo(int index) {
    scrollController.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );
  }
}
