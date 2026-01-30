import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 350,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors().cardColor.withValues(alpha: 0.8) : AppColors().cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered ? AppColors().primaryColor : AppColors().primaryColor.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: AppColors().primaryColor.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 5,
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors().primaryColor,
                  size: 32,
                ),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse(widget.package.pubLink)),
                  child: Icon(
                    Icons.open_in_new_rounded,
                    color: AppColors().textColor.withValues(alpha: 0.5),
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.package.name,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors().primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.package.version,
                    style: TextStyle(
                      color: AppColors().primaryColor,
                      fontSize: 10,
                      fontFamily: 'sfmono',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.package.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors().textLight,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const Spacer(),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.package.techs.map((tech) {
                return Text(
                  tech,
                  style: TextStyle(
                    color: AppColors().primaryColor.withValues(alpha: 0.7),
                    fontSize: 12,
                    fontFamily: 'sfmono',
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
