import 'package:finvest_task/Utils/colors.dart';
import 'package:finvest_task/Utils/extensions.dart';
import 'package:finvest_task/Widgets/amount_display_widget.dart';
import 'package:flutter/material.dart';

class BalanceDueChart extends StatefulWidget {
  const BalanceDueChart({super.key});

  @override
  BalanceDueChartState createState() => BalanceDueChartState();
}

class BalanceDueChartState extends State<BalanceDueChart> {
  // Sample data for each tab
  final List<List<Offset>> graphData = [
    const [
      Offset(0, 0.0),
      Offset(0.15, 0.4),
      Offset(0.3, 0.3),
      Offset(0.45, 0.0),
      Offset(0.6, 0.5),
      Offset(0.75, 0.35),
      Offset(1.0, 0.1)
    ], // 1W
    const [
      Offset(0, 0.6),
      Offset(0.15, 0.5),
      Offset(0.3, 0.2),
      Offset(0.45, 0.35),
      Offset(0.6, 0.1),
      Offset(0.75, 0.4),
      Offset(1.0, 0.5)
    ], // 1M
    const [
      Offset(0, 0.65),
      Offset(0.15, 0.55),
      Offset(0.3, 0.2),
      Offset(0.45, 0.0),
      Offset(0.6, 0.5),
      Offset(0.75, 0.3),
      Offset(1.0, 0.6)
    ], // 3M
    const [
      Offset(0, 0.7),
      Offset(0.15, 0.4),
      Offset(0.3, 0.0),
      Offset(0.45, 0.3),
      Offset(0.6, 0.5),
      Offset(0.75, 0.35),
      Offset(1.0, 0.6)
    ], // 6M (default)
    const [
      Offset(0, 0.5),
      Offset(0.15, 0.6),
      Offset(0.3, 0.4),
      Offset(0.45, 0.0),
      Offset(0.6, 0.3),
      Offset(0.75, 0.5),
      Offset(1.0, 0.4)
    ], // YTD
    const [
      Offset(0, 0.6),
      Offset(0.15, 0.7),
      Offset(0.3, 0.5),
      Offset(0.45, 0.3),
      Offset(0.6, 0.4),
      Offset(0.75, 0.6),
      Offset(1.0, 0.5)
    ], // 1Y
    const [
      Offset(0, 0.55),
      Offset(0.15, 0.35),
      Offset(0.3, 0.0),
      Offset(0.45, 0.3),
      Offset(0.6, 0.5),
      Offset(0.75, 0.2),
      Offset(1.0, 0.5)
    ], // ALL
  ];

  int selectedIndex = 3; // Initial selected tab index (6M)

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: FinvestColors.secondaryBgColor,
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "BALANCE DUE",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: FinvestColors.secondaryTextColor),
            ),
          ).padding(data: PaddingData(left: 20, right: 0, bottom: 0, top: 0)),
          const Align(
            alignment: Alignment.centerLeft,
            child: AmountDisplayWidget(amount: "\$245,781.00", fontSize: 40),
          ).padding(data: PaddingData(left: 20, right: 0, bottom: 8, top: 12)),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: screenWidth,
                height: 200,
                child: CustomPaint(
                  painter: BalanceDueChartPainter(graphData[selectedIndex]),
                ),
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      graphData.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? FinvestColors.primaryColor
                                : null,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            ["1W", "1M", "3M", "6M", "YTD", "1Y", "ALL"][index],
                            style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BalanceDueChartPainter extends CustomPainter {
  final List<Offset> points;

  BalanceDueChartPainter(List<Offset> relativePoints) : points = relativePoints;

  @override
  void paint(Canvas canvas, Size size) {
    // Scale points to fit full screen width dynamically
    final scaledPoints = points
        .map((p) => Offset(p.dx * size.width, p.dy * size.height))
        .toList();

    // Path for the smooth curve
    final path = Path();
    path.moveTo(scaledPoints[0].dx, scaledPoints[0].dy);

    for (int i = 0; i < scaledPoints.length - 1; i++) {
      var currentPoint = scaledPoints[i];
      var nextPoint = scaledPoints[i + 1];
      var controlPoint1 =
          Offset((currentPoint.dx + nextPoint.dx) / 2, currentPoint.dy);
      var controlPoint2 =
          Offset((currentPoint.dx + nextPoint.dx) / 2, nextPoint.dy);

      path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
          controlPoint2.dy, nextPoint.dx, nextPoint.dy);
    }

    // Create a path for the fill area under the curve
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    // Clip the canvas to fill only under the curve
    canvas.save();
    canvas.clipPath(fillPath);

    // Draw background color under the graph
    final backgroundPaint = Paint()..color = FinvestColors.bgColor;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // Draw gradient vertical lines within the clipped area
    for (double x = 0; x < size.width; x += 3) {
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            FinvestColors.primaryColor.withOpacity(0.8),
            FinvestColors.bgColor
          ],
        ).createShader(Rect.fromLTWH(x, 0, 1, size.height))
        ..strokeWidth = 1.0;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Restore canvas after clipping
    canvas.restore();

    // Draw the main curve
    final curvePaint = Paint()
      ..color = FinvestColors.primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
