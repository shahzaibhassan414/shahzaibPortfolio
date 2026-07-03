import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Widgets/main_title_widget.dart';
import '../../controller/generalController.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import '../../resource/strings.dart';

class Contact extends ConsumerStatefulWidget {
  const Contact({super.key});

  @override
  ConsumerState<Contact> createState() => _ContactState();
}

class _ContactState extends ConsumerState<Contact> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ref.read(progressProvider.notifier).state = true;
    final success = await AppClass().sendEmail(
      _nameController.text,
      _emailController.text,
      _messageController.text,
    );
    ref.read(progressProvider.notifier).state = false;

    if (!mounted) return;
    if (success) {
      AppClass()
          .successSnackBar('Message sent successfully.', context: context);
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } else {
      AppClass().errorSnackBar(
        'Something went wrong. Please try again.',
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final isMobile = screenType == ScreenType.mobile;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;
    final isSending = ref.watch(progressProvider);

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Have a product that needs to ship?',
          style: TextStyle(
            color: AppColors().textColor,
            fontSize: isWeb ? 42 : 27,
            height: 1.12,
            fontWeight: FontWeight.w700,
            letterSpacing: isMobile ? 0 : -1.2,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 18),
        Text(
          Strings.endTxt,
          style: TextStyle(
            color: AppColors().mutedTextColor,
            fontSize: isWeb ? 16 : 14,
            height: isMobile ? 1.5 : 1.65,
          ),
        ),
        SizedBox(height: isMobile ? 20 : 28),
        _ContactLink(
          icon: Icons.mail_outline_rounded,
          label: 'EMAIL',
          value: AppClass.email,
          onTap: () => AppClass().openEmail(AppClass.email),
        ),
        SizedBox(height: isMobile ? 10 : 12),
        _ContactLink(
          icon: Icons.call_outlined,
          label: 'PHONE',
          value: AppClass.phoneNumber,
          onTap: () => AppClass().openPhoneNumber('923160984600'),
        ),
      ],
    );

    final form = Container(
      padding: EdgeInsets.all(isWeb ? 28 : 18),
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(isMobile ? 14 : 18),
        border: Border.all(color: AppColors().dividerColor),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Field(
              controller: _nameController,
              label: 'Name',
              hint: 'Your name',
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? 'Please enter a name'
                  : null,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            _Field(
              controller: _emailController,
              label: 'Email',
              hint: 'you@company.com',
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty || !email.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: isMobile ? 12 : 16),
            _Field(
              controller: _messageController,
              label: 'Message',
              hint: 'Tell me a little about the product or role',
              maxLines: isMobile ? 4 : 5,
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? 'Please enter a message'
                  : null,
            ),
            SizedBox(height: isMobile ? 16 : 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: isSending ? null : _submit,
                icon: isSending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded, size: 17),
                label: Text(isSending ? 'SENDING...' : 'SEND MESSAGE'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors().primaryColor,
                  foregroundColor: AppColors().backgroundColor,
                  disabledBackgroundColor:
                      AppColors().primaryColor.withValues(alpha: 0.45),
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  textStyle: const TextStyle(
                    fontFamily: 'sfmono',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 130 : 56,
        horizontal,
        isWeb ? 100 : 38,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: "What's Next?", isWeb: isWeb),
          if (isWeb)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: copy),
                const SizedBox(width: 70),
                Expanded(child: form),
              ],
            )
          else ...[
            copy,
            const SizedBox(height: 24),
            form,
          ],
        ],
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppClass().getScreenType(context) == ScreenType.mobile;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: EdgeInsets.all(isMobile ? 13 : 15),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors().elevatedColor
                : AppColors().cardColor.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors().dividerColor),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: AppColors().primaryColor, size: 20),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: AppColors().mutedTextColor,
                        fontFamily: 'sfmono',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: TextStyle(
                        color: AppColors().textColor,
                        fontSize: isMobile ? 12 : 13,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_outward_rounded,
                color: AppColors().mutedTextColor,
                size: 17,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _Field({
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = AppClass().getScreenType(context) == ScreenType.mobile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: AppColors().mutedTextColor,
            fontFamily: 'sfmono',
            fontSize: 9,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(color: AppColors().textColor, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors().mutedTextColor),
            filled: true,
            fillColor: AppColors().backgroundColor.withValues(alpha: 0.65),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: isMobile ? 13 : 15,
            ),
            border: _border(),
            enabledBorder: _border(),
            focusedBorder: _border(AppColors().primaryColor),
            errorBorder: _border(Colors.redAccent),
            focusedErrorBorder: _border(Colors.redAccent),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border([Color? color]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? AppColors().dividerColor),
    );
  }
}
