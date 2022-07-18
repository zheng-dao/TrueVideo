import 'package:async/async.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/repair_order.dart';
import 'package:truvideo_enterprise/model/user_settings.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_empty.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list/shimmer_list.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/screen/home/tabs/repair_orders/list_item.dart';

class ScreenRepairOrderSearchList extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenRepairOrderSearchList";

  const ScreenRepairOrderSearchList({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenRepairOrderSearchList> createState() => _ScreenRepairOrderSearchListState();
}

class _ScreenRepairOrderSearchListState extends ConsumerState<ScreenRepairOrderSearchList> {
  final _controller = TextEditingController();
  CancelableOperation? _operation;
  bool _loading = false;
  var _data = <RepairOrderModel>[];
  bool _searched = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    EasyDebounce.cancel("search");
    _operation?.cancel();
    super.dispose();
  }

  _search() async {
    EasyDebounce.cancel("search");
    _operation?.cancel();

    final filter = _controller.text.trim();

    if (filter.isEmpty) {
      setState(() {
        _loading = false;
        _data = [];
        _searched = false;
      });
      return;
    }

    try {
      setState(() {
        _searched = true;
        _loading = true;
      });

      final List<UserSettingsModel>? userData = ref.watch(userSettingsPod);
      final UserSettingsModel? userType = userData?.firstWhere((element) => element.key == "appType");
      final isRepairOrder = userType?.value == "SERVICE";

      final RepairOrderService repairOrderService = GetIt.I.get();
      final data = await repairOrderService.getList(
        page: 1,
        type: isRepairOrder ? RepairOrderTypeFilter.repairOrders : RepairOrderTypeFilter.salesOrders,
        query: filter.trim(),
      );

      setState(() {
        _loading = false;
        _data = data.data;
      });
    } catch (error) {
      setState(() {
        _loading = false;
      });
    }
  }

  _onItemPressed(RepairOrderModel model) {
    Navigator.of(context).pop(model);
  }

  _close() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appbar: CustomAppBar(
        brightness: Brightness.light,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actionButtons: [
          CustomButtonIcon(
            icon: Icons.clear,
            backgroundColor: Colors.transparent,
            onPressed: _close,
          ),
        ],
        child: CustomTextField(
          prefix: const CustomTextFieldIconButton(icon: Icons.search),
          autofocus: true,
          controller: _controller,
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          focusedBorderColor: Colors.transparent,
          hintText: "Search...",
          onChanged: (val) => EasyDebounce.debounce("search", const Duration(milliseconds: 300), () => _search()),
        ),
      ),
      body: Column(
        children: [
          const CustomDivider(),
          Expanded(
            child: CustomList<RepairOrderModel>(
              data: _data,
              loading: _loading,
              areItemsTheSame: (a, b) => a.id == b.id,
              itemBuilder: (context, item) => RepairOrderListItem(
                model: item,
                onPressed: _onItemPressed,
              ),
              loadingBuilder: (context) => const CustomShimmerList(length: 10),
              emptyBuilder: (context) => _searched ? const CustomListIndicatorEmpty() : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
