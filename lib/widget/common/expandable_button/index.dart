import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/expandable_button/screen.dart';

class CustomExpandableButton extends StatefulWidget {
  final Widget Function(BuildContext context, bool isOpen, Function() open) buttonBuilder;
  final List<Widget> Function(BuildContext context, Future<void> Function() close) buttonsBuilder;
  final Widget Function(BuildContext context, int index)? labelBuilder;
  final Color? backgroundColor;

  const CustomExpandableButton({
    Key? key,
    required this.buttonBuilder,
    required this.buttonsBuilder,
    this.backgroundColor, this.labelBuilder,
  }) : super(key: key);

  @override
  State<CustomExpandableButton> createState() => _CustomExpandableButtonState();
}

class _CustomExpandableButtonState extends State<CustomExpandableButton> {
  final _key = GlobalKey();
  bool _opened = false;

  _open() async {
    setState(() {
      _opened = true;
    });

    final screenKey = GlobalKey<CustomExpandableButtonScreenState>();
    final rb = _key.currentContext!.findRenderObject() as RenderBox;
    await Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) => CustomExpandableButtonScreen(
          key: screenKey,
          position: rb.localToGlobal(Offset.zero),
          size: rb.size,
          buttonBuilder: widget.buttonBuilder,
          buttonsBuilder: widget.buttonsBuilder,
          backgroundColor: widget.backgroundColor,
          labelBuilder: widget.labelBuilder,
        ),
        opaque: false,
        settings: const RouteSettings(
          name: "ExpandableButton",
        ),
      ),
    );

    setState(() {
      _opened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      child: Opacity(
        opacity: !_opened ? 1.0 : 0.0,
        child: widget.buttonBuilder.call(context, false, _open),
      ),
    );
  }
}
