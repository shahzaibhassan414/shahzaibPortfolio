import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/packageModel.dart';
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
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(widget.package.pubLink)),
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _hovered ? AppColors().elevatedColor : AppColors().cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: _hovered
                  ? AppColors().primaryColor.withValues(alpha: 0.4)
                  : AppColors().dividerColor,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors().primaryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      Icons.data_object_rounded,
                      color: AppColors().primaryColor,
                      size: 21,
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
                  const SizedBox(width: 10),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: AppColors().mutedTextColor,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                widget.package.name,
                style: TextStyle(
                  color: AppColors().textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.package.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 12,
                runSpacing: 8,
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
