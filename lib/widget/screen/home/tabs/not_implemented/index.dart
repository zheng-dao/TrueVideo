import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_empty.dart';
import 'package:truvideo_enterprise/widget/mixin/back_button_exit.dart';
import 'package:truvideo_enterprise/widget/screen/home/controller.dart';

class ScreenHomeTabNotImplemented extends StatefulHookConsumerWidget {
  final String title;
  final ScreenHomeController controller;

  const ScreenHomeTabNotImplemented({Key? key, required this.controller, this.title = ""}) : super(key: key);

  @override
  ConsumerState<ScreenHomeTabNotImplemented> createState() => _ScreenHomeTabNotImplementedState();
}

class _ScreenHomeTabNotImplementedState extends ConsumerState<ScreenHomeTabNotImplemented> with BackButtonExitMixin {
  Future<bool> _onWillPop() async {
    return onButtonBackPressed();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.appBarTitle = widget.title;
    widget.controller.onWillPop = _onWillPop;
    widget.controller.appBarActions = const [];
    widget.controller.fab = null;

    return const Center(
      child: CustomListIndicatorEmpty(
        title: "WORK IN PROGRESS",
      ),
    );
  }
}
