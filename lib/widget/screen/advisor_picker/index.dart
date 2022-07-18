import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/widget.dart';
import 'package:truvideo_enterprise/model/tce_user.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/screen/advisor_picker/shimmer.dart';

class ScreenAdvisorPickerParams {
  CustomRouteType? routeType;

  ScreenAdvisorPickerParams({
    this.routeType,
  });
}

class ScreenAdvisorPicker extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenAdvisorPicker";

  final ScreenAdvisorPickerParams params;

  const ScreenAdvisorPicker({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenAdvisorPicker> createState() => _ScreenAdvisorPickerState();
}

class _ScreenAdvisorPickerState extends ConsumerState<ScreenAdvisorPicker> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _loading = true;
  dynamic _error;
  var _data = <TCEUserModel>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  _init() async {
    try {
      setState(() {
        _error = null;
        _loading = true;
      });

      final RepairOrderService repairOrderService = GetIt.I.get();
      final data = await repairOrderService.getAdvisors();
      if (!mounted) return;

      setState(() {
        _loading = false;
        _data = data;
      });

      await CustomWidgetUtils.wait();
    } catch (error, stack) {
      log("Error init dialog advisor", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

  _close({dynamic result}) {
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final filter = useValueListenable(_controller);
    final filteredData = useMemoized(
      () {
        return _data.where((element) {
          return element.displayName.trim().toLowerCase().contains(filter.text.trim().toLowerCase());
        }).toList();
      },
      [_data, filter.text],
    );

    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    Color appBarFillColor;
    Color appBarIconColor;
    if (isRouteTypeCupertinoVertical) {
      appBarFillColor = Theme.of(context).scaffoldBackgroundColor;
    } else {
      appBarFillColor = Theme.of(context).colorScheme.secondary;
    }
    appBarIconColor = appBarFillColor.contrast(context);

    final buttonClose = CustomButtonIcon(
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      iconColor: appBarIconColor,
      backgroundColor: Colors.transparent,
      onPressed: _close,
    );

    return CustomScaffold(
      appbar: CustomAppBar(
        backgroundColor: appBarFillColor,
        title: "Advisor",
        titleColor: appBarIconColor,
        leading: !isRouteTypeCupertinoVertical ? buttonClose : null,
        actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
      ),
      body: CustomList<TCEUserModel>.separated(
        controller: ModalScrollController.of(context),
        padding: EdgeInsets.only(
          bottom: 16.0 + MediaQuery.of(context).padding.bottom,
          top: 16.0,
        ),
        listWrapper: (context, child) => CustomFadingEdgeList(child: child),
        data: filteredData,
        loading: _loading,
        error: _error,
        loadingBuilder: (context) => const ScreenAdvisorPickerShimmerList(),
        errorBuilder: (context, error) => CustomListIndicatorError(
          error: error,
          buttonText: "RETRY",
          onButtonPressed: _init,
        ),
        areItemsTheSame: (a, b) => a.id == b.id,
        header: CustomTextField(
          enabled: !_loading,
          focusNode: _focusNode,
          controller: _controller,
          margin: const EdgeInsets.all(16.0),
          hintText: "Search",
          prefix: const CustomTextFieldIconButton(icon: Icons.search),
          suffixBuilder: (context, text) => CustomAnimatedCollapseVisibility(
            visible: text.trim().isNotEmpty,
            child: CustomTextFieldIconButton(
              icon: Icons.clear,
              onPressed: () => _controller.clear(),
            ),
          ),
        ),
        headerVisibility: (status) {
          switch (status) {
            case CustomListStatus.loading:
              return false;
            case CustomListStatus.error:
              return false;
            case CustomListStatus.empty:
              return filter.text.trim().isNotEmpty;
            case CustomListStatus.data:
              return true;
          }
        },
        itemBuilder: (context, item) => CustomListTile(
          titleText: item.displayName,
          subtitleText: item.emailAddress,
          onPressed: () => _close(result: item),
        ),
      ),
    );
  }
}
