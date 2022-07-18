import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/controller.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';

import 'message.dart';
import 'title.dart';

class CustomDialogWidget extends StatefulWidget {
  final String title;
  final String message;
  final EdgeInsets? scrollPadding;
  final EdgeInsets? titlePadding;
  final EdgeInsets? messagePadding;
  final EdgeInsets? childPadding;
  final EdgeInsets? buttonsPadding;
  final bool resizeToAvoidBottomInset;
  final Function({dynamic result})? close;
  final CustomDialogController? controller;
  final Widget Function(BuildContext context, CustomDialogController controller)? builder;
  final List<Widget> Function(BuildContext context, CustomDialogController controller)? buttonsBuilder;
  final bool dismissOnBackgroundPress;
  final Future<bool> Function()? onWillPop;
  final bool loading;

  const CustomDialogWidget({
    Key? key,
    this.loading = false,
    this.title = "",
    this.message = "",
    this.scrollPadding,
    this.resizeToAvoidBottomInset = false,
    this.close,
    this.buttonsBuilder,
    this.builder,
    this.controller,
    this.dismissOnBackgroundPress = true,
    this.onWillPop,
    this.titlePadding,
    this.messagePadding,
    this.childPadding,
    this.buttonsPadding,
  }) : super(key: key);

  @override
  State<CustomDialogWidget> createState() => CustomDialogWidgetState();
}

class CustomDialogWidgetState extends State<CustomDialogWidget> with SingleTickerProviderStateMixin {
  late CustomDialogController _controller;
  late AnimationController _animationController;
  late Animation<double> _animationBackgroundOpacity;
  late Animation<double> _animationPopupScale;

  bool _loading = false;
  bool _closing = false;

  @override
  void initState() {
    _loading = widget.loading;

    _controller = widget.controller ?? CustomDialogController();
    _controller.attach(this);

    _animationController = AnimationController(vsync: this);
    _animationBackgroundOpacity = Tween<double>(begin: 0.0, end: 0.0).animate(_animationController);
    _animationPopupScale = Tween<double>(begin: 0.7, end: 0.7).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
    super.initState();
  }

  @override
  void dispose() {
    _controller.attach(null);
    _animationController.dispose();
    super.dispose();
  }

  _init() async {
    _animate(
      backgroundOpacity: 1.0,
      popupScale: 1.0,
      duration: const Duration(milliseconds: 300),
    );
  }

  _animate({
    double? backgroundOpacity,
    double? popupScale,
    Duration duration = Duration.zero,
  }) async {
    _animationBackgroundOpacity = Tween<double>(
      begin: _animationBackgroundOpacity.value,
      end: backgroundOpacity ?? _animationBackgroundOpacity.value,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationPopupScale = Tween<double>(
      begin: _animationPopupScale.value,
      end: popupScale ?? _animationPopupScale.value,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    if (duration == Duration.zero) {
      _animationController.value = 1.0;
    } else {
      _animationController.reset();
      _animationController.duration = duration;
      await _animationController.forward();
    }
  }

  close({dynamic result}) async {
    if (_closing) return;
    _closing = true;

    await _animate(
      backgroundOpacity: 0.0,
      popupScale: 0.7,
      duration: const Duration(milliseconds: 300),
    );
    widget.close?.call(result: result);
  }

  _onBackgroundPressed() {
    if (!widget.dismissOnBackgroundPress) return;
    close();
  }

  bool get isLoading => _loading;

  void setLoading(bool value) {
    _loading = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final withTitle = widget.title.trim().isNotEmpty;
    final withMessage = widget.message.trim().isNotEmpty;

    return WillPopScope(
      onWillPop: () async {
        final shouldClose = await widget.onWillPop?.call() ?? true;
        if (shouldClose) {
          close();
        }

        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Opacity(
                  opacity: _animationBackgroundOpacity.value.clamp(0.0, 1.0),
                  child: child,
                ),
                child: GestureDetector(
                  onTap: _onBackgroundPressed,
                  child: Container(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).padding.top,
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => Transform.scale(
                    scale: _animationPopupScale.value,
                    child: Opacity(
                      opacity: _animationBackgroundOpacity.value.clamp(0.0, 1.0),
                      child: child,
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(32.0).copyWith(
                      bottom: 32 + MediaQuery.of(context).padding.bottom,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: kElevationToShadow[8],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomAnimatedFadeVisibility(
                          visible: !_loading,
                          child: Material(
                            color: Colors.transparent,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: CustomFadingEdgeList(
                                    child: SingleChildScrollView(
                                      padding: widget.scrollPadding ?? const EdgeInsets.symmetric(vertical: 16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (withTitle)
                                            CustomDialogTitle(
                                              padding: widget.titlePadding ?? const EdgeInsets.only(left: 16.0, right: 16.0),
                                              text: widget.title,
                                            ),
                                          if (withMessage)
                                            CustomDialogMessage(
                                              text: widget.message,
                                              margin: withTitle ? const EdgeInsets.only(top: 8.0) : null,
                                              padding: widget.messagePadding ?? const EdgeInsets.only(left: 16.0, right: 16.0),
                                            ),
                                          if (widget.builder != null)
                                            Container(
                                              margin: EdgeInsets.only(top: withTitle || withMessage ? 16.0 : 0.0),
                                              padding: widget.childPadding ?? const EdgeInsets.only(left: 16.0, right: 16.0),
                                              child: widget.builder!(context, _controller),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if ((widget.buttonsBuilder?.call(context, _controller) ?? []).isNotEmpty)
                                  Container(
                                    margin: widget.buttonsPadding ?? const EdgeInsets.all(16.0),
                                    width: double.infinity,
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.end,
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: [
                                        ...widget.buttonsBuilder?.call(context, _controller) ?? [],
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        CustomAnimatedFadeVisibility(
                          visible: _loading,
                          child: const CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
