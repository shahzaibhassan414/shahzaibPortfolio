import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../Widgets/recruiter_intro_widgets.dart';
import '../../resource/appClass.dart';

class IntroTab extends StatelessWidget {
  final AutoScrollController scrollController;

  const IntroTab(this.scrollController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(
        top: AppClass().getMqHeight(context) * 0.1,
        bottom: AppClass().getMqHeight(context) * 0.12,
      ),
      child: RecruiterIntroHero(
        compact: true,
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
