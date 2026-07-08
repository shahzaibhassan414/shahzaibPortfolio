import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../projectWeb.dart';

class ProjectDetailDialog extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailDialog({super.key, required this.project});

  @override
  State<ProjectDetailDialog> createState() => _ProjectDetailDialogState();
}

class _ProjectDetailDialogState extends State<ProjectDetailDialog> {
  int _selectedScreenshot = 0;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final galleryImages = project.galleryImages;
    final hasGallery = galleryImages.length > 1;
    final selectedImage = galleryImages[_selectedScreenshot];
    final isWeb = AppClass().getScreenType(context) == ScreenType.web;
    final width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
          horizontal: isWeb ? width * 0.25 : 20, vertical: 40),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors().darkColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: AppColors().primaryRedColor.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 30,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header Image
                Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: Image.asset(
                        selectedImage,
                        key: ValueKey(selectedImage),
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                    if (hasGallery) ...[
                      Positioned(
                        left: 15,
                        top: 0,
                        bottom: 0,
                        child: _buildImageNavButton(
                          Icons.chevron_left_rounded,
                          () => _selectScreenshot(
                            (_selectedScreenshot - 1 + galleryImages.length) %
                                galleryImages.length,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 15,
                        top: 0,
                        bottom: 0,
                        child: _buildImageNavButton(
                          Icons.chevron_right_rounded,
                          () => _selectScreenshot(
                            (_selectedScreenshot + 1) % galleryImages.length,
                          ),
                        ),
                      ),
                    ],
                    Positioned(
                      top: 15,
                      right: 15,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors().darkColor,
                              AppColors().darkColor.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (hasGallery)
                      Positioned(
                        left: 18,
                        bottom: 18,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.55),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: AppColors()
                                  .primaryRedColor
                                  .withValues(alpha: 0.35),
                            ),
                          ),
                          child: Text(
                            '${_selectedScreenshot + 1}/${galleryImages.length}',
                            style: GoogleFonts.robotoMono(
                              color: AppColors().textColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: GoogleFonts.roboto(
                          color: AppColors().textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (hasGallery) ...[
                        _buildScreenshotStrip(galleryImages),
                        const SizedBox(height: 22),
                      ],
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          if (project.role != null)
                            _buildFactCard(
                              Icons.person_outline_rounded,
                              'ROLE',
                              project.role!,
                            ),
                          if (project.timeline != null)
                            _buildFactCard(
                              Icons.apps_rounded,
                              'TYPE',
                              project.timeline!,
                            ),
                          if (project.impact != null)
                            _buildFactCard(
                              Icons.bolt_rounded,
                              'OUTCOME',
                              project.impact!,
                            ),
                        ],
                      ),
                      const SizedBox(height: 22),

                      // Tech Stack Chips
                      if (project.techs != null && project.techs!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.techs!
                                .map((tech) => Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors()
                                                .primaryRedColor
                                                .withValues(alpha: 0.3)),
                                        color: AppColors()
                                            .primaryRedColor
                                            .withValues(alpha: 0.1),
                                      ),
                                      child: Text(
                                        tech,
                                        style: GoogleFonts.roboto(
                                          color: AppColors().primaryRedColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),

                      Text(
                        'Project overview',
                        style: GoogleFonts.roboto(
                          color: AppColors().textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        project.description ??
                            'No description available for this project.',
                        style: GoogleFonts.roboto(
                          color: AppColors().textLight,
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),

                      if (project.technicalDecisions?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 28),
                        Text(
                          'Technical Decisions',
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...project.technicalDecisions!.map(_buildDecisionRow),
                      ],

                      if (project.highlights?.isNotEmpty ?? false) ...[
                        const SizedBox(height: 24),
                        Text(
                          'Key Highlights',
                          style: GoogleFonts.roboto(
                            color: AppColors().textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...project.highlights!.map(_buildHighlightRow),
                      ],
                      if (_hasValidStoreLinks(project)) ...[
                        const SizedBox(height: 30),
                        Wrap(
                          spacing: 15,
                          runSpacing: 12,
                          children: [
                            if (_isValidStoreLink(
                              project.androidLink,
                              StoreType.playStore,
                            ))
                              _buildLinkButton(
                                context,
                                'Play Store',
                                Icons.play_arrow_rounded,
                                project.androidLink!,
                              ),
                            if (_isValidStoreLink(
                              project.iosLink,
                              StoreType.appStore,
                            ))
                              _buildLinkButton(
                                context,
                                'App Store',
                                Icons.apple,
                                project.iosLink!,
                              ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectScreenshot(int index) {
    setState(() => _selectedScreenshot = index);
  }

  Widget _buildImageNavButton(IconData icon, VoidCallback onTap) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.48),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors().textColor.withValues(alpha: 0.16),
            ),
          ),
          child: Icon(icon, color: AppColors().textColor, size: 24),
        ),
      ),
    );
  }

  Widget _buildScreenshotStrip(List<String> galleryImages) {
    return SizedBox(
      height: 76,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: galleryImages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final selected = index == _selectedScreenshot;

          return InkWell(
            onTap: () => _selectScreenshot(index),
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 106,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: selected ? 2 : 1,
                  color: selected
                      ? AppColors().primaryRedColor
                      : AppColors().dividerColor,
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    galleryImages[index],
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.medium,
                  ),
                  if (!selected)
                    ColoredBox(
                      color: Colors.black.withValues(alpha: 0.28),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFactCard(IconData icon, String label, String value) {
    return Container(
      width: 168,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors().dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors().primaryRedColor, size: 18),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.robotoMono(
              color: AppColors().mutedTextColor,
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.roboto(
              color: AppColors().textColor,
              fontSize: 13,
              height: 1.35,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecisionRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColors().primaryRedColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.architecture_rounded,
              color: AppColors().primaryRedColor,
              size: 14,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: AppColors().textColor,
                fontSize: 15,
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_rounded,
            color: AppColors().primaryRedColor.withValues(alpha: 0.7),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: AppColors().textLight,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkButton(
      BuildContext context, String title, IconData icon, String link) {
    return InkWell(
      onTap: () async {
        await launchUrl(Uri.parse(link));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: AppColors().primaryRedColor.withValues(alpha: 0.5)),
          color: AppColors().primaryRedColor.withValues(alpha: 0.05),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors().primaryRedColor, size: 20),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.roboto(
                color: AppColors().primaryRedColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasValidStoreLinks(ProjectModel project) {
    return _isValidStoreLink(project.androidLink, StoreType.playStore) ||
        _isValidStoreLink(project.iosLink, StoreType.appStore);
  }

  bool _isValidStoreLink(String? link, StoreType storeType) {
    if (link == null || link.trim().isEmpty) return false;

    final uri = Uri.tryParse(link.trim());
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) return false;

    final host = uri.host.toLowerCase();
    return switch (storeType) {
      StoreType.playStore =>
        host == 'play.google.com' && uri.path.contains('/store/apps/details'),
      StoreType.appStore =>
        host == 'apps.apple.com' && uri.pathSegments.contains('app'),
    };
  }
}

enum StoreType { playStore, appStore }
