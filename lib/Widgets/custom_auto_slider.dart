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
  bool _isHovered = false;
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
      if (_isHovered) return;

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
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black,
                Colors.black,
                Colors.black.withOpacity(0.1),
                Colors.transparent,
              ],
              stops: const [0.0, 0.05, 0.2, 0.8, 0.95, 1.0],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            child: Row(
              children: [
                ...skills,
                ...skills,
                ...skills, // Added more for smoother loop
              ].asMap().entries.map((entry) {
                final index = entry.key;
                final skill = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
      ),
    );
  }
}
