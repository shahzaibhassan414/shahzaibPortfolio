import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/blogModel.dart';
import '../resource/colors.dart';

class BlogCard extends StatefulWidget {
  final BlogModel blog;

  const BlogCard({super.key, required this.blog});

  @override
  State<BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<BlogCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(widget.blog.link)),
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          clipBehavior: Clip.antiAlias,
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
              AspectRatio(
                aspectRatio: 1.9,
                child: Image.network(
                  widget.blog.imageUrl,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.low,
                  frameBuilder: (context, child, frame, _) {
                    if (frame != null) return child;
                    return ColoredBox(
                      color: AppColors().elevatedColor,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors().primaryColor,
                          ),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => ColoredBox(
                    color: AppColors().elevatedColor,
                    child: Icon(
                      Icons.article_outlined,
                      color: AppColors().mutedTextColor,
                      size: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.blog.date.toUpperCase(),
                      style: TextStyle(
                        color: AppColors().primaryColor,
                        fontFamily: 'sfmono',
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Text(
                      widget.blog.title,
                      style: TextStyle(
                        color: AppColors().textColor,
                        fontSize: 21,
                        height: 1.25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.blog.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors().mutedTextColor,
                        fontSize: 14,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'READ ARTICLE',
                          style: TextStyle(
                            color: _hovered
                                ? AppColors().primaryColor
                                : AppColors().textColor,
                            fontFamily: 'sfmono',
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_outward_rounded,
                          color: _hovered
                              ? AppColors().primaryColor
                              : AppColors().mutedTextColor,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
