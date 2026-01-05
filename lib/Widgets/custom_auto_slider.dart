import 'dart:async';
import 'package:flutter/material.dart';
import '../resource/appClass.dart';
import 'custom_skill_image_card.dart';

class SkillsAutoSlider extends StatefulWidget {
  const SkillsAutoSlider({super.key});

  @override
  State<SkillsAutoSlider> createState() => _SkillsAutoSliderState();
}

class _SkillsAutoSliderState extends State<SkillsAutoSlider> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  // bool _isHovered = false;
  double _scrollPosition = 0.0;
  final double _speed = 0.6;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    _startMarquee();
  }

  void _startMarquee() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      // if (_isHovered) return;

      if (_scrollController.hasClients) {
        _scrollPosition += _speed;

        if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(_scrollPosition);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skills = AppClass().skillsImages;

    return MouseRegion(
      // onEnter: (_) => setState(() => _isHovered = true),
      // onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        height: 170,
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              ...skills,
              ...skills,
            ].asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = null),
                  child: CustomSkillImageCard(
                    skill: skill,
                    isHovered: _hoveredIndex == index,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
