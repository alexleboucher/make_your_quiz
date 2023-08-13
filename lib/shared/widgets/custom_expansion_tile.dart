import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({
    required this.title,
    required this.trailingBeforeExpand,
    required this.children,
    this.shape,
    this.tilePadding,
    super.key,
  });

  final Widget title;
  final List<Widget> trailingBeforeExpand;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? tilePadding;
  final List<Widget> children;

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0, end: 0.5);

  late AnimationController _animationController;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: widget.shape,
      tilePadding: widget.tilePadding,
      title: widget.title,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...widget.trailingBeforeExpand,
          RotationTransition(
            turns: _iconTurns,
            child: const Icon(Icons.expand_more),
          ),
        ],
      ),
      onExpansionChanged: (isExpanded) {
        if (isExpanded) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      },
      children: widget.children,
    );
  }
}
