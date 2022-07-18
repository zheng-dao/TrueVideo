import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';

import 'image.dart';

class CustomImageViewerWidget extends StatefulHookConsumerWidget {
  final List<CustomImageDataSource> images;
  final int initialIndex;
  final String Function(int index)? heroTagBuilder;
  final double Function(int index)? aspectRationBuilder;
  final List<Widget> Function(CustomImageDataSource image)? appBarActionBuilder;
  final bool fromBoxFitCover;

  const CustomImageViewerWidget({
    Key? key,
    required this.images,
    this.initialIndex = 0,
    this.heroTagBuilder,
    this.appBarActionBuilder,
    this.aspectRationBuilder,
    this.fromBoxFitCover = false,
  }) : super(key: key);

  @override
  ConsumerState<CustomImageViewerWidget> createState() => _CustomImageViewerState();
}

class _CustomImageViewerState extends ConsumerState<CustomImageViewerWidget> {
  late PageController _pageController;

  int _currentIndex = 0;
  bool _controlsVisible = false;
  Timer? _timerControls;
  bool _scrolling = false;
  bool _imageZoomed = false;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _pageController.addListener(_pageListener);

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _onPageChanged(widget.initialIndex);

      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;

      setState(() {
        _controlsVisible = true;
      });

      _startTimer();
    });
  }

  @override
  void dispose() {
    _timerControls?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  _close() {
    Navigator.of(context).pop();
  }

  _pageListener() {
    final scrolling = _pageController.page!.floorToDouble() != _pageController.page!;
    if (_scrolling != scrolling) {
      setState(() {
        _scrolling = scrolling;
      });
    }
  }

  _startTimer() {
    _timerControls?.cancel();
    _timerControls = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      setState(() {
        _controlsVisible = false;
      });
    });
  }

  _onPageChanged(int index) async {
    setState(() {
      _currentIndex = index;
    });
  }

  _onTap() {
    _timerControls?.cancel();
    setState(() {
      _controlsVisible = !_controlsVisible;
    });

    if (_controlsVisible) {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        if (_controlsVisible || !Platform.isIOS) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        }

        return () {};
      },
      [_controlsVisible],
    );

    return CustomScaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extentBody: true,
      appbar: CustomAppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        leading: CustomAnimatedFadeVisibility(
          visible: _controlsVisible,
          child: CustomButtonIcon(
            icon: Icons.clear,
            iconColor: Colors.white,
            elevation: 0,
            backgroundColor: Colors.black.withOpacity(0.6),
            onPressed: _close,
          ),
        ),
        actionButtons: (widget.appBarActionBuilder?.call(widget.images[_currentIndex]) ?? []),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTap,
              child: PageView(
                physics: _imageZoomed ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
                onPageChanged: _onPageChanged,
                controller: _pageController,
                children: [
                  for (int i = 0; i < widget.images.length; i++)
                    CustomImageViewerImage(
                      enableDrag: !_scrolling,
                      dataSource: widget.images[i],
                      heroTag: widget.heroTagBuilder?.call(i) ?? "",
                      aspectRatio: widget.aspectRationBuilder?.call(i),
                      fromBoxFitCover: widget.fromBoxFitCover,
                      onZoomedChange: (zoomed) {
                        setState(() {
                          _imageZoomed = zoomed;
                        });
                      },
                      close: _close,
                    ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: IgnorePointer(
              ignoring: true,
              child: CustomAnimatedFadeVisibility(
                visible: _controlsVisible,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: MediaQuery.of(context).padding.top,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
