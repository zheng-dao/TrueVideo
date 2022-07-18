import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/navigation_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/home/controller.dart';

import 'tabs/not_implemented/index.dart';
import 'tabs/repair_orders/index.dart';

class ScreenHome extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenHome";

  const ScreenHome({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends ConsumerState<ScreenHome> {
  final _controller = ScreenHomeController();
  CustomNavigationBarTab _currentTab = CustomNavigationBarTab.repairOrders;

  @override
  void initState() {
    _controller.addListener(() async {
      await CustomWidgetUtils.wait();
      setState(() {});
    });

    super.initState();
  }

  Widget _buildContent() {
    switch (_currentTab) {
      case CustomNavigationBarTab.repairOrders:
        return ScreenHomeTabRepairOrders(controller: _controller);
      case CustomNavigationBarTab.messages:
        return ScreenHomeTabNotImplemented(
          controller: _controller,
          title: "Messages",
        );
      case CustomNavigationBarTab.gallery:
        return ScreenHomeTabNotImplemented(
          controller: _controller,
          title: "Gallery",
        );
      case CustomNavigationBarTab.customers:
        return ScreenHomeTabNotImplemented(
          controller: _controller,
          title: "Customers",
        );
    }
  }

  _onTapPressed(CustomNavigationBarTab tab) {
    if (_currentTab == tab) return;

    _controller.clear();

    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onWillPop: _controller.onWillPop,
      appbar: CustomAppBar(
        title: _controller.appBarTitle,
        actionButtons: _controller.appBarActions,
        actionButtonsKey: ValueKey(_currentTab),
      ),
      body: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) => FadeThroughTransition(
          animation: animation,
          fillColor: Colors.transparent,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: Container(
          key: ValueKey(_currentTab),
          child: _buildContent(),
        ),
      ),
      floatingActionButtonKey: ValueKey(_currentTab),
      floatingActionButton: _controller.fab,
      navigationBar: CustomNavigationBar(
        currentTab: _currentTab,
        onPressed: _onTapPressed,
      ),
    );
  }
}
