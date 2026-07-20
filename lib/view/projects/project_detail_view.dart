import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/resource/appClass.dart';
import 'package:portfolio/resource/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'projectWeb.dart';

class ProjectDetailView extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailView({super.key, required this.project});

  @override
  State<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOpacity = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double newOpacity = (offset / 300).clamp(0, 1);
      if (newOpacity != _scrollOpacity) {
        setState(() => _scrollOpacity = newOpacity.toDouble());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final isWeb = AppClass().getScreenType(context) == ScreenType.web;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Cinematic Hero
                _buildHero(context, project, isWeb),

                // 2. The Briefing (Context & Stats)
                _buildSectionWrapper(
                  isWeb: isWeb,
                  child: _buildBriefing(project, isWeb),
                ),

                // 3. Integrated Narrative & Design Showcase
                ..._buildCaseStudyFlow(project, isWeb),

                // 4. Technical Architecture
                if (project.technicalDecisions != null || project.techs != null)
                  _buildSectionWrapper(
                    isWeb: isWeb,
                    child: _buildTechnicalDeepDive(project),
                  ),

                // 5. Highlights & Outcome
                if (project.highlights != null)
                  _buildSectionWrapper(
                    isWeb: isWeb,
                    child: _buildImpactSection(project),
                  ),

                // 6. Footer / CTA
                _buildFooterCTA(project, isWeb),
              ],
            ),
          ),

          // Floating Navigation Bar
          _buildFloatingNavbar(context, project.name),
        ],
      ),
    );
  }

  Widget _buildSectionWrapper({required Widget child, required bool isWeb, double verticalPadding = 80}) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isWeb ? width * 0.18 : 24,
        vertical: verticalPadding,
      ),
      child: child,
    );
  }

  Widget _buildFloatingNavbar(BuildContext context, String title) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors().backgroundColor.withValues(alpha: _scrollOpacity),
              AppColors().backgroundColor.withValues(alpha: 0),
            ],
          ),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              Opacity(
                opacity: _scrollOpacity,
                child: Text(
                  title.toUpperCase(),
                  style: GoogleFonts.robotoMono(
                    color: AppColors().primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
              const SizedBox(width: 40), // Balance
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context, ProjectModel project, bool isWeb) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(project.image, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors().backgroundColor,
                  AppColors().backgroundColor.withValues(alpha: 0.2),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: isWeb ? MediaQuery.of(context).size.width * 0.18 : 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (project.timeline != null)
                  Text(
                    project.timeline!.toUpperCase(),
                    style: GoogleFonts.robotoMono(
                      color: AppColors().primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                const SizedBox(height: 24),
                Text(
                  project.name,
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white,
                    fontSize: isWeb ? 110 : 56,
                    fontWeight: FontWeight.w900,
                    height: 0.9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBriefing(ProjectModel project, bool isWeb) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                project.description ?? '',
                style: GoogleFonts.roboto(
                  color: AppColors().textColor,
                  fontSize: 22,
                  height: 1.6,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            if (isWeb) const SizedBox(width: 100),
            if (isWeb)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMetaInfo('ROLE', project.role ?? 'Developer'),
                    const SizedBox(height: 40),
                    _buildMetaInfo('IMPACT', project.impact ?? 'N/A'),
                  ],
                ),
              ),
          ],
        ),
        if (!isWeb) ...[
          const SizedBox(height: 40),
          _buildMetaInfo('ROLE', project.role ?? 'Developer'),
          const SizedBox(height: 30),
          _buildMetaInfo('IMPACT', project.impact ?? 'N/A'),
        ]
      ],
    );
  }

  Widget _buildMetaInfo(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.robotoMono(
            color: AppColors().primaryColor,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          value,
          style: GoogleFonts.roboto(
            color: AppColors().mutedTextColor,
            fontSize: 16,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildCaseStudyFlow(ProjectModel project, bool isWeb) {
    List<Widget> flow = [];
    final images = project.galleryImages;
    final steps = project.caseStudy ?? [];

    if (steps.isEmpty) return flow;

    for (int i = 0; i < steps.length; i++) {
      // 1. Text Narrative
      flow.add(_buildSectionWrapper(
        isWeb: isWeb,
        verticalPadding: 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              steps[i].title,
              style: GoogleFonts.playfairDisplay(
                color: AppColors().textColor,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              steps[i].description,
              style: GoogleFonts.roboto(
                color: AppColors().textLight,
                fontSize: 19,
                height: 1.8,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ));

      // 2. Interspersed Visuals (at specific logical breaks)
      int visualIndex = -1;
      if (i == 0) visualIndex = 0; // After Overview
      else if (i == 2) visualIndex = 1; // After Problem
      else if (i == 3) visualIndex = 2; // After What I Built
      else if (i == 6) visualIndex = 3; // After Outcome

      if (visualIndex != -1 && visualIndex < images.length) {
        flow.add(_buildPremiumShowcase(images[visualIndex], isWeb));
      }
    }

    // 3. Residual Images (if any)
    if (images.length > 4) {
      for (int k = 4; k < images.length; k++) {
        flow.add(_buildPremiumShowcase(images[k], isWeb));
      }
    }

    return flow;
  }

  Widget _buildPremiumShowcase(String imagePath, bool isWeb) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 80),
        width: isWeb ? 550 : double.infinity,
        constraints: BoxConstraints(maxWidth: isWeb ? 500 : 380),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(54),
          color: AppColors().cardColor,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1), width: 12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.6),
              blurRadius: 60,
              offset: const Offset(0, 30),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(42),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }

  Widget _buildTechnicalDeepDive(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TECHNICAL ARCHITECTURE',
          style: GoogleFonts.robotoMono(
            color: AppColors().primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 40),
        if (project.techs != null)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: project.techs!.map((tech) => _buildTechTag(tech)).toList(),
          ),
        if (project.technicalDecisions != null) ...[
          const SizedBox(height: 40),
          ...project.technicalDecisions!.map((d) => _buildDetailPoint(d)),
        ],
      ],
    );
  }

  Widget _buildTechTag(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors().dividerColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        tech,
        style: GoogleFonts.robotoMono(color: AppColors().textColor, fontSize: 13),
      ),
    );
  }

  Widget _buildDetailPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 15,
            height: 1,
            color: AppColors().primaryColor,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.roboto(
                color: AppColors().textColor,
                fontSize: 17,
                height: 1.6,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImpactSection(ProjectModel project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OUTCOME & HIGHLIGHTS',
          style: GoogleFonts.robotoMono(
            color: AppColors().primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 40),
        ...project.highlights!.map((h) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle_outline_rounded, color: AppColors().primaryColor, size: 20),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  h,
                  style: GoogleFonts.roboto(color: AppColors().textLight, fontSize: 17, height: 1.5),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildFooterCTA(ProjectModel project, bool isWeb) {
    return Container(
      width: double.infinity,
      color: AppColors().cardColor,
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: isWeb ? MediaQuery.of(context).size.width * 0.18 : 24),
      child: Column(
        children: [
          Text(
            'Enjoyed this project?',
            style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          if (_hasValidStoreLinks(project))
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                if (_isValidStoreLink(project.androidLink, StoreType.playStore))
                  _buildButton('GOOGLE PLAY', Icons.play_arrow, project.androidLink!),
                if (_isValidStoreLink(project.iosLink, StoreType.appStore))
                  _buildButton('APP STORE', Icons.apple, project.iosLink!),
              ],
            ),
          const SizedBox(height: 60),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'CLOSE & RETURN',
              style: GoogleFonts.robotoMono(color: AppColors().primaryColor, letterSpacing: 2, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, String url) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        decoration: BoxDecoration(border: Border.all(color: AppColors().primaryColor), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors().primaryColor, size: 18),
            const SizedBox(width: 12),
            Text(label, style: GoogleFonts.robotoMono(color: AppColors().primaryColor, fontWeight: FontWeight.bold, fontSize: 13)),
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
      StoreType.playStore => host == 'play.google.com' && uri.path.contains('/store/apps/details'),
      StoreType.appStore => host == 'apps.apple.com' && uri.pathSegments.contains('app'),
    };
  }
}

enum StoreType { playStore, appStore }
