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

  String _selectedProjectType = 'New MVP App';
  final Set<String> _selectedModules = {'Subscriptions / IAP'};
  String _selectedTimeline = '1–2 months';

  final List<String> _projectTypes = const [
    'New MVP App',
    'Feature Addition',
    'Bug Fix & Polish',
    'App Redesign',
  ];

  final List<String> _modules = const [
    'Subscriptions / IAP',
    'Google Maps & GPS',
    'Real-time Chat',
    'Auth & KYC',
    'Stripe Checkout',
    'Store Publishing',
  ];

  final List<String> _timelines = const [
    '< 1 month',
    '1–2 months',
    'Flexible',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String _buildScopeSummary() {
    return 'Project Scope: $_selectedProjectType | Modules: ${_selectedModules.join(", ")} | Timeline: $_selectedTimeline';
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    ref.read(progressProvider.notifier).state = true;
    final fullMessage = '${_messageController.text.trim()}\n\n[Scoping Details: ${_buildScopeSummary()}]';

    final success = await AppClass().sendEmail(
      _nameController.text.trim(),
      _emailController.text.trim(),
      fullMessage,
    );
    ref.read(progressProvider.notifier).state = false;

    if (!mounted) return;
    if (success) {
      AppClass().successSnackBar(
        'Inquiry sent successfully! I will reply within 24 hours.',
        context: context,
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    } else {
      AppClass().errorSnackBar(
        'Something went wrong. Please reach out directly on WhatsApp or email.',
        context: context,
      );
    }
  }

  void _chatOnWhatsApp() {
    final name = _nameController.text.trim();
    final greeting = name.isNotEmpty ? 'Hi Shahzaib, my name is $name.' : 'Hi Shahzaib,';
    final userMsg = _messageController.text.trim();
    final customPart = userMsg.isNotEmpty ? ' Note: $userMsg' : '';
    final msg = '$greeting I would like to discuss a Flutter project.\n\n${_buildScopeSummary()}.$customPart';

    AppClass().openPhoneNumber(
      '923160984600',
      prefilledMessage: msg,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final isMobile = screenType == ScreenType.mobile;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;
    final isSending = ref.watch(progressProvider);
    final accent = AppColors().primaryColor;

    final copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(
            "Let's discuss your project.",
            style: TextStyle(
              color: AppColors().textColor,
              fontSize: isWeb ? 36 : 24,
              height: 1.15,
              fontWeight: FontWeight.w700,
              letterSpacing: isMobile ? 0 : -1.0,
            ),
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
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
          icon: Icons.chat_rounded,
          label: 'WhatsApp',
          value: 'Chat on WhatsApp',
          isHighlighted: true,
          onTap: _chatOnWhatsApp,
        ),
        SizedBox(height: isMobile ? 10 : 12),
        _ContactLink(
          icon: Icons.mail_outline_rounded,
          label: 'Email',
          value: AppClass.email,
          onTap: () => AppClass().openEmail(AppClass.email, context: context),
        ),
        SizedBox(height: isMobile ? 10 : 12),
        _ContactLink(
          icon: Icons.call_outlined,
          label: 'Phone',
          value: AppClass.phoneNumber,
          onTap: () => AppClass().openPhoneNumber('923160984600', context: context),
        ),
      ],
    );

    final scopingForm = Container(
      padding: EdgeInsets.all(isWeb ? 28 : 20),
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors().dividerColor),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Type',
              style: TextStyle(
                color: AppColors().textColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _projectTypes
                  .map(
                    (type) => _ChipSelector(
                      label: type,
                      isSelected: _selectedProjectType == type,
                      onTap: () => setState(() => _selectedProjectType = type),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Text Inputs
            _Field(
              controller: _nameController,
              label: 'Your Name',
              hint: 'e.g. Alex Johnson',
              validator: (value) => (value?.trim().isEmpty ?? true)
                  ? 'Please enter your name'
                  : null,
            ),
            SizedBox(height: isMobile ? 12 : 16),
            _Field(
              controller: _emailController,
              label: 'Email Address',
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
              hint: 'Tell me about what you are looking to build...',
              maxLines: isMobile ? 3 : 4,
            ),
            SizedBox(height: isMobile ? 18 : 22),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: isSending ? null : _submit,
                    icon: isSending
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send_rounded, size: 16),
                    label: Text(isSending ? 'Sending...' : 'Send Message'),
                    style: FilledButton.styleFrom(
                      backgroundColor: accent,
                      foregroundColor: AppColors().backgroundColor,
                      disabledBackgroundColor: accent.withValues(alpha: 0.45),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  tooltip: 'Chat on WhatsApp',
                  onPressed: _chatOnWhatsApp,
                  icon: const Icon(Icons.chat_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0xff25D366).withValues(alpha: 0.15),
                    foregroundColor: const Color(0xff25D366),
                    side: BorderSide(color: const Color(0xff25D366).withValues(alpha: 0.4)),
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 120 : 56,
        horizontal,
        isWeb ? 100 : 38,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: "Get in Touch", isWeb: isWeb),
          if (isWeb)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: copy),
                const SizedBox(width: 50),
                Expanded(flex: 7, child: scopingForm),
              ],
            )
          else ...[
            copy,
            const SizedBox(height: 28),
            scopingForm,
          ],
        ],
      ),
    );
  }
}

class _ChipSelector extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChipSelector({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final accent = AppColors().primaryColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? accent : AppColors().backgroundColor.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? accent : AppColors().dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors().backgroundColor : AppColors().textColor,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ContactLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool isHighlighted;

  const _ContactLink({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
    this.isHighlighted = false,
  });

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppClass().getScreenType(context) == ScreenType.mobile;
    final accent = widget.isHighlighted ? const Color(0xff25D366) : AppColors().primaryColor;

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
            border: Border.all(
              color: widget.isHighlighted
                  ? accent.withValues(alpha: 0.5)
                  : AppColors().dividerColor,
            ),
          ),
          child: Row(
            children: [
              Icon(widget.icon, color: accent, size: 20),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: TextStyle(
                        color: AppColors().mutedTextColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.value,
                      style: TextStyle(
                        color: widget.isHighlighted ? accent : AppColors().textColor,
                        fontSize: isMobile ? 12 : 13,
                        fontWeight: widget.isHighlighted ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_outward_rounded,
                color: _hovered ? accent : AppColors().mutedTextColor,
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
          label,
          style: TextStyle(
            color: AppColors().textColor,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(color: AppColors().textColor, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: AppColors().mutedTextColor, fontSize: 12),
            filled: true,
            fillColor: AppColors().backgroundColor.withValues(alpha: 0.65),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
              vertical: isMobile ? 12 : 14,
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
