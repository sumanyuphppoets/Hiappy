import 'package:flutter/material.dart';
import 'package:hiappy/widgets/title_text.dart';

class SessionHistoryItem {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String duration;

  SessionHistoryItem({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.duration,
  });
}

class SearchCardList extends StatelessWidget {
  final List<SessionHistoryItem> items;
  final String? titleText;
  final String? seeMoreText;
  final VoidCallback? onSeeMore;
  final void Function(SessionHistoryItem)? onMoreTap;

  const SearchCardList({
    Key? key,
    required this.items,
    this.titleText,
    this.seeMoreText,
    this.onSeeMore,
    this.onMoreTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Header (optional)
        if (titleText != null || seeMoreText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (titleText != null)
                  Text(
                    titleText!,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                if (seeMoreText != null)
                  GestureDetector(
                    onTap: onSeeMore,
                    child: Text(
                      seeMoreText!,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
              ],
            ),
          ),

        /// Cards
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Row(
                      children: [
                        /// Thumbnail
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: item.imageUrl.startsWith("http")
                                ? Image.network(
                                    item.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    item.imageUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),

                        /// Info
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 32.0, top: 12.0, bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TitleText(text: item.title,
                                  fontSize: 18,
                                  color: Colors.blue,
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 4),
                                TitleText(
                                  text : item.subtitle,
                                    fontSize: 13,
                                    color: Colors.black54,
                                    overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                TitleText(
                                 text: "${item.duration} mins",
                                  fontSize: 12
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    /// 3-dot icon in top-right
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => onMoreTap?.call(item),
                        child: const Icon(Icons.more_vert, size: 22),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
