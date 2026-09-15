import 'package:flutter/material.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';

class FloatingQuickDock extends StatelessWidget {
  final VoidCallback onStartProject;

  const FloatingQuickDock({
    super.key,
    required this.onStartProject,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppClass().getScreenType(context) == ScreenType.mobile;

    return Positioned(
      bottom: isMobile ? 16 : 24,
      right: isMobile ? 16 : 28,
      child: RepaintBoundary(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors().cardColor.withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors().primaryColor.withValues(alpha: 0.35),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: AppColors().primaryColor.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // WhatsApp Quick Action
              _DockIconButton(
                icon: Icons.chat_rounded,
                tooltip: 'Quick WhatsApp Chat',
                color: const Color(0xff25D366),
                onTap: () => AppClass().openPhoneNumber(
                  '923160984600',
                  prefilledMessage: 'Hi Shahzaib, I saw your portfolio and would like to chat about a Flutter app project!',
                  context: context,
                ),
              ),
              const SizedBox(width: 6),

              // Email Quick Action
              _DockIconButton(
                icon: Icons.mail_outline_rounded,
                tooltip: 'Email Shahzaib',
                color: AppColors().textColor,
                onTap: () => AppClass().openEmail(AppClass.email, context: context),
              ),
              const SizedBox(width: 6),

              // Resume Quick Action
              _DockIconButton(
                icon: Icons.description_outlined,
                tooltip: 'Download Resume',
                color: AppColors().textColor,
                onTap: () => AppClass().downloadResume(context),
              ),
              const SizedBox(width: 8),

              // Start Project Button
              FilledButton.icon(
                onPressed: onStartProject,
                icon: const Icon(Icons.rocket_launch_rounded, size: 14),
                label: Text(
                  isMobile ? 'HIRE' : 'START PROJECT',
                  style: const TextStyle(
                    fontFamily: 'sfmono',
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors().primaryColor,
                  foregroundColor: AppColors().backgroundColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DockIconButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  const _DockIconButton({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  @override
  State<_DockIconButton> createState() => _DockIconButtonState();
}

class _DockIconButtonState extends State<_DockIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(100),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.color.withValues(alpha: 0.18)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(widget.icon, color: widget.color, size: 18),
          ),
        ),
      ),
    );
  }
}
