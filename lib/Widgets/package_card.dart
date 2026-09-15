import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/packageModel.dart';
import '../resource/appClass.dart';
import '../resource/colors.dart';

class PackageCard extends StatefulWidget {
  final PackageModel package;

  const PackageCard({super.key, required this.package});

  @override
  State<PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<PackageCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = AppClass().getScreenType(context) == ScreenType.mobile;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(widget.package.pubLink)),
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _hovered ? -5 : 0, 0),
          padding: EdgeInsets.all(isMobile ? 18 : 24),
          decoration: BoxDecoration(
            color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? AppColors().primaryColor.withValues(alpha: 0.4)
                  : AppColors().dividerColor,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: AppColors().primaryColor.withValues(alpha: 0.12),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: isMobile ? 38 : 42,
                    height: isMobile ? 38 : 42,
                    decoration: BoxDecoration(
                      color: AppColors().primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      Icons.data_object_rounded,
                      color: AppColors().primaryColor,
                      size: isMobile ? 19 : 21,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.package.version,
                    style: TextStyle(
                      color: AppColors().mutedTextColor,
                      fontFamily: 'sfmono',
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: AppColors().mutedTextColor,
                    size: 16,
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 14 : 18),
              Text(
                widget.package.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors().textColor,
                  fontSize: isMobile ? 17 : 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: isMobile ? 6 : 8),
              Text(
                widget.package.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontSize: isMobile ? 12.5 : 14,
                  height: 1.45,
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 10,
                runSpacing: 6,
                children: widget.package.techs
                    .map(
                      (tech) => Text(
                        tech,
                        style: TextStyle(
                          color: AppColors().primaryColor,
                          fontFamily: 'sfmono',
                          fontSize: 10,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
