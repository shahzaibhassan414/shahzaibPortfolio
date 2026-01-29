import 'dart:async';
import 'package:flutter/material.dart';
import '../resource/appClass.dart';
import 'custom_skill_bar.dart';

class StacksTextAutoSlider extends StatefulWidget {
  const StacksTextAutoSlider({super.key});

  @override
  State<StacksTextAutoSlider> createState() => _StacksTextAutoSliderState();
}

class _StacksTextAutoSliderState extends State<StacksTextAutoSlider> {
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  double _scrollPosition = 0.0;
  final double _speed = 0.9;
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollPosition = _scrollController.position.maxScrollExtent;
        _scrollController.jumpTo(_scrollPosition);
      }
      _startMarquee();
    });
  }

  void _startMarquee() {
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_scrollController.hasClients) {
        _scrollPosition -= _speed; // Subtracting speed to scroll backwards

        if (_scrollPosition <= 0) {
          _scrollPosition = _scrollController.position.maxScrollExtent;
          _scrollController.jumpTo(_scrollPosition);
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
    final skills = AppClass().skills;
    bool isWeb = AppClass().getScreenType(context) == ScreenType.web;
    return Container(
      height: isWeb ? 60 : 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.black,
              Colors.black,
              Colors.transparent,
            ],
            stops: [0.0, 0.02, 0.98, 1.0], // Reduced the fade area
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
              ...skills,
            ].asMap().entries.map((entry) {
              final index = entry.key;
              final skill = entry.value;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomSkillBar(
                  skillName: skill['name'],
                  value: skill['value'],
                  isWeb: isWeb,
                  isHovered: _hoveredIndex == index,
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = null),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
