import 'package:flutter/material.dart';

import '../../Widgets/main_title_widget.dart';
import '../../resource/appClass.dart';
import '../../resource/colors.dart';
import 'Widgets/project_detail_dialog.dart';
import 'Widgets/work_card.dart';
import 'projectWeb.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  bool _showAll = false;
  int _selectedFilter = 0;
  int _featuredIndex = 0;

  late final List<_ProjectFilter> _filters = [
    _ProjectFilter(
      label: 'All',
      icon: Icons.apps_rounded,
      matcher: (_) => true,
    ),
    _ProjectFilter(
      label: 'Maps',
      icon: Icons.map_outlined,
      matcher: (project) => _matches(project, ['map', 'location', 'tracking']),
    ),
    _ProjectFilter(
      label: 'Payments',
      icon: Icons.payments_outlined,
      matcher: (project) =>
          _matches(project, ['stripe', 'payment', 'commerce']),
    ),
    _ProjectFilter(
      label: 'Realtime',
      icon: Icons.sync_rounded,
      matcher: (project) => _matches(project, ['socket', 'realtime', 'live']),
    ),
    _ProjectFilter(
      label: 'Web3',
      icon: Icons.token_rounded,
      matcher: (project) => _matches(project, ['web3', 'blockchain', 'wallet']),
    ),
    _ProjectFilter(
      label: 'Subscriptions',
      icon: Icons.workspace_premium_outlined,
      matcher: (project) => _matches(project, ['revenuecat', 'subscription']),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenType = AppClass().getScreenType(context);
    final isWeb = screenType == ScreenType.web;
    final isMobile = screenType == ScreenType.mobile;
    final horizontal = screenType == ScreenType.mobile ? 20.0 : 38.0;
    final allProjects = AppClass().projects;
    final filteredProjects =
        allProjects.where(_filters[_selectedFilter].matcher).toList();
    final featuredProjects = allProjects.take(3).toList();
    final visibleProjects = _showAll
        ? filteredProjects
        : filteredProjects.take(isWeb ? 6 : 3).toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        isWeb ? 130 : 56,
        horizontal,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitleWidget(title: 'My Projects', isWeb: isWeb),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 690),
            child: Text(
              'Selected mobile products with practical delivery notes, technical decisions, and outcomes from real Flutter builds.',
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: isWeb ? 17 : 14,
                height: isMobile ? 1.48 : 1.6,
              ),
            ),
          ),
          SizedBox(height: isMobile ? 22 : 30),
          _ProjectOverviewPanel(isMobile: isMobile),
          SizedBox(height: isMobile ? 24 : 36),
          _FeaturedProjectsCarousel(
            projects: featuredProjects,
            index: _featuredIndex,
            isMobile: isMobile,
            onPrevious: () => setState(
              () => _featuredIndex =
                  (_featuredIndex - 1 + featuredProjects.length) %
                      featuredProjects.length,
            ),
            onNext: () => setState(
              () => _featuredIndex =
                  (_featuredIndex + 1) % featuredProjects.length,
            ),
          ),
          SizedBox(height: isMobile ? 24 : 32),
          _ProjectFilterBar(
            filters: _filters,
            selectedIndex: _selectedFilter,
            onSelected: (index) {
              setState(() {
                _selectedFilter = index;
                _showAll = false;
              });
            },
          ),
          SizedBox(height: isMobile ? 18 : 24),
          Row(
            children: [
              Text(
                _filters[_selectedFilter].label == 'All'
                    ? 'ALL PROJECTS'
                    : '${_filters[_selectedFilter].label.toUpperCase()} PROJECTS',
                style: TextStyle(
                  color: AppColors().textColor,
                  fontFamily: 'sfmono',
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: 1,
                  color: AppColors().dividerColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${filteredProjects.length} FOUND',
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontFamily: 'sfmono',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: isMobile ? 16 : 18),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 980
                  ? 3
                  : constraints.maxWidth >= 620
                      ? 2
                      : 1;
              const gap = 18.0;
              final width =
                  (constraints.maxWidth - gap * (columns - 1)) / columns;

              return Wrap(
                spacing: gap,
                runSpacing: gap,
                children: visibleProjects
                    .map(
                      (project) => SizedBox(
                        width: width,
                        child: WorkCard(project: project),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          if (!_showAll &&
              visibleProjects.length < filteredProjects.length) ...[
            const SizedBox(height: 32),
            Center(
              child: OutlinedButton.icon(
                onPressed: () => setState(() => _showAll = true),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(
                  'SHOW ${filteredProjects.length - visibleProjects.length} MORE',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors().primaryColor,
                  side: BorderSide(color: AppColors().dividerColor),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  textStyle: const TextStyle(
                    fontFamily: 'sfmono',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _matches(ProjectModel project, List<String> terms) {
    final searchText = [
      project.name,
      project.description,
      project.role,
      project.timeline,
      project.impact,
      ...?project.techs,
      ...?project.highlights,
    ].whereType<String>().join(' ').toLowerCase();

    return terms.any(searchText.contains);
  }
}

class _ProjectFilter {
  final String label;
  final IconData icon;
  final bool Function(ProjectModel project) matcher;

  const _ProjectFilter({
    required this.label,
    required this.icon,
    required this.matcher,
  });
}

class _FeaturedProjectsCarousel extends StatelessWidget {
  final List<ProjectModel> projects;
  final int index;
  final bool isMobile;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _FeaturedProjectsCarousel({
    required this.projects,
    required this.index,
    required this.isMobile,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) return const SizedBox.shrink();

    final project = projects[index % projects.length];

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          barrierColor: Colors.black.withValues(alpha: 0.78),
          builder: (context) => ProjectDetailDialog(project: project),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors().cardColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors().dividerColor),
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeaturedImage(project: project, height: 190),
                  _FeaturedContent(
                    project: project,
                    index: index,
                    count: projects.length,
                    onPrevious: onPrevious,
                    onNext: onNext,
                    compact: true,
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: _FeaturedImage(project: project, height: 330),
                  ),
                  Expanded(
                    flex: 7,
                    child: _FeaturedContent(
                      project: project,
                      index: index,
                      count: projects.length,
                      onPrevious: onPrevious,
                      onNext: onNext,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  final ProjectModel project;
  final double height;

  const _FeaturedImage({
    required this.project,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            project.image,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
            semanticLabel: '${project.name} featured mobile app preview',
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.transparent, Color(0xAA091117)],
              ),
            ),
          ),
          Positioned(
            left: 18,
            top: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors().backgroundColor.withValues(alpha: 0.78),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors().primaryColor.withValues(alpha: 0.24),
                ),
              ),
              child: Text(
                'FEATURED',
                style: TextStyle(
                  color: AppColors().primaryColor,
                  fontFamily: 'sfmono',
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeaturedContent extends StatelessWidget {
  final ProjectModel project;
  final int index;
  final int count;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final bool compact;

  const _FeaturedContent({
    required this.project,
    required this.index,
    required this.count,
    required this.onPrevious,
    required this.onNext,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(compact ? 18 : 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SELECTED CASE STUDY',
            style: TextStyle(
              color: AppColors().primaryColor,
              fontFamily: 'sfmono',
              fontSize: 10,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            project.name,
            style: TextStyle(
              color: AppColors().textColor,
              fontSize: compact ? 25 : 34,
              height: 1.05,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (project.impact != null) ...[
            const SizedBox(height: 12),
            Text(
              project.impact!,
              style: TextStyle(
                color: AppColors().textColor,
                fontFamily: 'sfmono',
                fontSize: 11,
                height: 1.45,
              ),
            ),
          ],
          if (project.description != null) ...[
            const SizedBox(height: 14),
            Text(
              project.description!,
              maxLines: compact ? 3 : 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors().mutedTextColor,
                fontSize: compact ? 13 : 15,
                height: 1.55,
              ),
            ),
          ],
          if (project.techs?.isNotEmpty ?? false) ...[
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.techs!
                  .take(compact ? 4 : 5)
                  .map((tech) => _FeaturedTechChip(tech))
                  .toList(),
            ),
          ],
          SizedBox(height: compact ? 18 : 24),
          Row(
            children: [
              _CarouselIconButton(
                icon: Icons.chevron_left_rounded,
                onPressed: onPrevious,
              ),
              const SizedBox(width: 8),
              _CarouselIconButton(
                icon: Icons.chevron_right_rounded,
                onPressed: onNext,
              ),
              const SizedBox(width: 14),
              Text(
                '${(index + 1).toString().padLeft(2, '0')} / ${count.toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontFamily: 'sfmono',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_outward_rounded,
                color: AppColors().primaryColor,
                size: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeaturedTechChip extends StatelessWidget {
  final String label;

  const _FeaturedTechChip(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors().backgroundColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(7),
        border: Border.all(color: AppColors().dividerColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors().mutedTextColor,
          fontFamily: 'sfmono',
          fontSize: 9,
        ),
      ),
    );
  }
}

class _CarouselIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CarouselIconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: AppColors().primaryColor,
      style: IconButton.styleFrom(
        backgroundColor: AppColors().backgroundColor.withValues(alpha: 0.65),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors().dividerColor),
        ),
      ),
    );
  }
}

class _ProjectFilterBar extends StatelessWidget {
  final List<_ProjectFilter> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _ProjectFilterBar({
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < filters.length; i++) ...[
            _ProjectFilterChip(
              filter: filters[i],
              selected: i == selectedIndex,
              onTap: () => onSelected(i),
            ),
            if (i != filters.length - 1) const SizedBox(width: 9),
          ],
        ],
      ),
    );
  }
}

class _ProjectFilterChip extends StatelessWidget {
  final _ProjectFilter filter;
  final bool selected;
  final VoidCallback onTap;

  const _ProjectFilterChip({
    required this.filter,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final foreground =
        selected ? AppColors().backgroundColor : AppColors().mutedTextColor;
    final background =
        selected ? AppColors().primaryColor : AppColors().cardColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                selected ? AppColors().primaryColor : AppColors().dividerColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(filter.icon, color: foreground, size: 16),
            const SizedBox(width: 8),
            Text(
              filter.label,
              style: TextStyle(
                color: foreground,
                fontFamily: 'sfmono',
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectOverviewPanel extends StatelessWidget {
  final bool isMobile;

  const _ProjectOverviewPanel({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        icon: Icons.rocket_launch_outlined,
        value: '${AppClass().projects.length}+',
        label: 'shipped apps',
      ),
      (
        icon: Icons.layers_outlined,
        value: '6',
        label: 'product domains',
      ),
      (
        icon: Icons.verified_outlined,
        value: 'iOS + Android',
        label: 'store-ready delivery',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        color: AppColors().cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors().dividerColor),
      ),
      child: isMobile
          ? Column(
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _OverviewItem(
                        icon: item.icon,
                        value: item.value,
                        label: item.label,
                      ),
                    ),
                  )
                  .toList(),
            )
          : Row(
              children: items
                  .map(
                    (item) => Expanded(
                      child: _OverviewItem(
                        icon: item.icon,
                        value: item.value,
                        label: item.label,
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

class _OverviewItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _OverviewItem({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors().backgroundColor.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors().dividerColor),
          ),
          child: Icon(icon, color: AppColors().primaryColor, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors().textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors().mutedTextColor,
                  fontFamily: 'sfmono',
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
