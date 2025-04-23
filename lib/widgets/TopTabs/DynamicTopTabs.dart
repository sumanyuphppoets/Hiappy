import 'package:flutter/material.dart';

class DynamicTopTabs extends StatelessWidget {
  final String title;
  final List<String> tabTitles;
  final List<Widget> tabViews;

  const DynamicTopTabs({
    Key? key,
    required this.title,
    required this.tabTitles,
    required this.tabViews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                isScrollable: false,
                labelColor: const Color(0xFF3B82F6), // Blue
                unselectedLabelColor: Colors.grey,
                labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, fontFamily: 'Poppins'),
                indicator: const GradientTabIndicator(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF10B981)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    
                  ),
                  thickness: 3,
                ),
                tabs: tabTitles.map((t) => Tab(text: t)).toList(),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );
  }
}

/// Custom gradient underline for TabBar
class GradientTabIndicator extends Decoration {
  final LinearGradient gradient;
  final double thickness;

  const GradientTabIndicator({
    required this.gradient,
    this.thickness = 2.0,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _GradientPainter(gradient: gradient, thickness: thickness);
  }
}

class _GradientPainter extends BoxPainter {
  final LinearGradient gradient;
  final double thickness;

  _GradientPainter({required this.gradient, required this.thickness});

 @override
void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
  final double indicatorWidth = cfg.size!.width * 2.5; // 60% of tab width
  final double startX = offset.dx + (cfg.size!.width - indicatorWidth) / 2;
  final double endX = startX + indicatorWidth;

  final paint = Paint()
    ..shader = gradient.createShader(
      Rect.fromLTWH(startX, offset.dy + cfg.size!.height - thickness,
          indicatorWidth, thickness),
    )
    ..strokeWidth = thickness
    ..style = PaintingStyle.stroke;

  final start = Offset(startX, offset.dy + cfg.size!.height - thickness / 2);
  final end = Offset(endX, offset.dy + cfg.size!.height - thickness / 2);
  canvas.drawLine(start, end, paint);
}

}
