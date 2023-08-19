import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../theme/src/app_colors.dart';
import '../theme/src/app_text_styles.dart';

class AppMarkdown extends StatefulWidget {
  const AppMarkdown({
    required this.text,
    this.bottomPadding = true,
    this.hasReadMore = false,
    this.lineHeight,
    Key? key,
  }) : super(key: key);

  final String text;
  final bool bottomPadding;
  final bool hasReadMore;
  final double? lineHeight;

  @override
  AppMarkdownState createState() => AppMarkdownState();
}

class AppMarkdownState extends State<AppMarkdown> {
  bool showFullText = false;

  String get displayedText => widget.hasReadMore && !showFullText && widget.text.length > 500
      ? '${widget.text.substring(0, 500)}...'
      : widget.text;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Markdown(
            data:
                '${displayedText.replaceAll(RegExp(r'\n{2,}'), '\n').trim()} ${widget.hasReadMore ? !showFullText ? '[Read more](more)' : '[Read less](more)' : ''}',
            shrinkWrap: true,
            softLineBreak: true,
            selectable: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            onTapLink: (text, href, title) => href != null ? launchUrlString(href) : {},
            styleSheet: MarkdownStyleSheet(
              blockquote: AppTextStyles.black60Medium13,
              checkbox: AppTextStyles.primaryBold18,
              p: AppTextStyles.grayMedium16.copyWith(height: widget.lineHeight ?? 1.3),
              a: AppTextStyles.primarySemiBold16.copyWith(color: AppColors.secondary),
              strong: AppTextStyles.grayBold16.copyWith(
                height: widget.lineHeight ?? 1.3,
                color: Colors.black.withOpacity(0.8),
              ),
              h1: AppTextStyles.blackExtraBold22,
              h2: AppTextStyles.blackExtraBold20,
              pPadding: EdgeInsets.only(bottom: widget.bottomPadding ? 8 : 0),
              blockquoteDecoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primary),
              ),
              tableCellsPadding: EdgeInsets.zero,
              codeblockPadding: EdgeInsets.zero,
              listBulletPadding: EdgeInsets.zero,
              h2Padding: const EdgeInsets.only(top: 12),
              h3Padding: const EdgeInsets.only(top: 8),
              blockquotePadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              blockSpacing: 5,
            ),
            imageBuilder: (uri, title, alt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: uri.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  if (alt != null)
                    Container(
                      padding: const EdgeInsets.all(4),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.white,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          // Container(
                          //   padding: const EdgeInsets.all(8),
                          //   decoration: const BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: AppColors.primary,
                          //   ),
                          //   child: AppIcons.icon(AppIcons.camera, size: 12),
                          // ),
                          const SizedBox(width: 8),
                          Text(alt, style: AppTextStyles.blackRegular12),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (widget.hasReadMore) const SizedBox(height: 5),
        ],
      ),
    );
  }
}
