import 'package:flutter/material.dart';

class SegmentedLinearProgressBar extends StatelessWidget {
  const SegmentedLinearProgressBar({
    required this.value,
    required this.sectionsCount,
    this.progressDuration = const Duration(seconds: 1),
    this.curve = Curves.easeInOut,
    this.borderRadius,
    this.width,
    this.height = 10,
    this.constraints,
    this.color,
    this.completedColor,
    this.segmentColor = Colors.white,
    this.segmentDisabledColor,
    this.segmentWidth = 1.5,
    super.key,
  });

  final double value;
  final int sectionsCount;
  final Duration progressDuration;
  final Curve curve;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double height;
  final BoxConstraints? constraints;
  final Color? color;
  final Color? completedColor;
  final Color segmentColor;
  final Color? segmentDisabledColor;
  final double segmentWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      child: TweenAnimationBuilder<double>(
        curve: curve,
        duration: progressDuration,
        tween: Tween<double>(
          begin: 0,
          end: value,
        ),
        builder: (context, value, _) {
          final isCompleted = value == 1;
          final progressColor =
              !isCompleted ? color : (completedColor ?? color);

          return Stack(
            children: [
              if (borderRadius != null)
                ClipRRect(
                  borderRadius: borderRadius,
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: height,
                    color: progressColor,
                  ),
                )
              else
                LinearProgressIndicator(
                  value: value,
                  minHeight: height,
                  color: progressColor,
                ),
              Positioned(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      List.generate(sectionsCount - 1, (index) => index).map(
                    (index) {
                      final isActivated = index + 1 <= value * sectionsCount;
                      return Container(
                        width: segmentWidth,
                        decoration: BoxDecoration(
                          color: isActivated
                              ? segmentColor
                              : (segmentDisabledColor ?? segmentColor),
                          boxShadow: isActivated
                              ? [
                                  BoxShadow(
                                    color: segmentColor,
                                    blurRadius: 3,
                                  ),
                                ]
                              : null,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
