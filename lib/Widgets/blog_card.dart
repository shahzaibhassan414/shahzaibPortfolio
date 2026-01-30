import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.blog.link)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutCubic,
          width: 380,
          decoration: BoxDecoration(
            color: AppColors().cardColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered 
                  ? AppColors().primaryColor.withOpacity(0.5) 
                  : Colors.white.withOpacity(0.05),
              width: 1,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: AppColors().primaryColor.withOpacity(0.1),
                  blurRadius: 30,
                  spreadRadius: 5,
                )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Stack(
                  children: [
                    AnimatedScale(
                      scale: _isHovered ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 600),
                      child: Image.network(
                        widget.blog.imageUrl,
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(_isHovered ? 0.7 : 0.4),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors().primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          widget.blog.date.toUpperCase(),
                          style: TextStyle(
                            color: AppColors().backgroundColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sfmono',
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.blog.title,
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.blog.description,
                      style: GoogleFonts.roboto(
                        color: AppColors().textLight.withOpacity(0.8),
                        fontSize: 15,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text(
                          "EXPLORE ARTICLE",
                          style: TextStyle(
                            color: _isHovered ? AppColors().primaryColor : AppColors().textColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'sfmono',
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedPadding(
                          duration: const Duration(milliseconds: 300),
                          padding: EdgeInsets.only(left: _isHovered ? 8 : 0),
                          child: Icon(
                            Icons.arrow_right_alt_rounded,
                            color: _isHovered ? AppColors().primaryColor : AppColors().textColor,
                            size: 20,
                          ),
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
