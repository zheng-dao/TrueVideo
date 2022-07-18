import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/hook/is_repair_order_type.dart';
import 'package:truvideo_enterprise/model/event_bus/event_video_uploaded.dart';
import 'package:truvideo_enterprise/model/pagination.dart';
import 'package:truvideo_enterprise/model/repair_order.dart';
import 'package:truvideo_enterprise/riverpod/connectivity.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/service/event_bus/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar_logged_user.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_empty.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/tabs/container.dart';
import 'package:truvideo_enterprise/widget/dialog/user/profile/index.dart';
import 'package:truvideo_enterprise/widget/mixin/back_button_exit.dart';
import 'package:truvideo_enterprise/widget/mixin/connectivity.dart';
import 'package:truvideo_enterprise/widget/screen/home/controller.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_new/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_search_list/index.dart';
import 'list_item.dart';
import 'shimmer_list.dart';

class ScreenHomeTabRepairOrders extends StatefulHookConsumerWidget {
  final ScreenHomeController controller;

  const ScreenHomeTabRepairOrders({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  ConsumerState<ScreenHomeTabRepairOrders> createState() => _ScreenHomeTabRepairOrdersState();
}

class _ScreenHomeTabRepairOrdersState extends ConsumerState<ScreenHomeTabRepairOrders> with BackButtonExitMixin, ConnectivityMixin {
  RepairOrderService get _repairOrderService => GetIt.I.get();

  StreamSubscription? _streamSubscriptionVideoUploaded;
  RemoveListener? _connectivityListener;
  CancelableOperation<PaginationModel<RepairOrderModel>>? _operation;
  var _data = <String, PaginationModel<RepairOrderModel>>{};
  var _items = <String, List<RepairOrderModel>>{};
  var _loading = <String, bool>{};
  var _error = <String, dynamic>{};
  var _isInit = <String, bool>{};
  final int _initialPage = 1;

  int _tabSelected = 0;
  List<String> _tabs = <String>[];

  @override
  void initState() {
    super.initState();

    _tabs = [
      "ALL",
      "MY",
      "NEW",
      "REJECTED",
    ];
    _tabSelected = 0;

    for (var element in _tabs) {
      _loading = Map<String, bool>.from(_loading)..[element] = true;
      _isInit = Map<String, bool>.from(_isInit)..[element] = false;
      _items = Map<String, List<RepairOrderModel>>.from(_items)..[element] = [];
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    super.dispose();
    _connectivityListener?.call();
    _streamSubscriptionVideoUploaded?.cancel();
    _operation?.cancel();
  }

  _init() async {
    final EventBusService eventBusService = GetIt.I.get();
    _streamSubscriptionVideoUploaded = eventBusService.streamEvents<EventVideoUploadedModel>().listen((event) {
      log("Video uploaded");
      _refreshItem(event.orderID);
    });

    _refresh(forceLoading: false);
    bool firstConnectivityCallback = true;
    _connectivityListener = ref.read(connectivityPod.notifier).addListener((state) {
      if (firstConnectivityCallback) {
        firstConnectivityCallback = false;
        return;
      }

      log("Refresh list because a connectivity change");
      _refresh();
    });
  }

  Future<List<RepairOrderModel>> _getCachedItems() async {
    try {
      final RepairOrderService repairOrderService = GetIt.I.get();
      final cached = await repairOrderService.getCachedList(status: _filterBy);
      return cached;
    } catch (error) {
      log("Error reading cached items", error: error);
      return [];
    }
  }

  _onTabChanged(int i) {
    setState(() {
      _tabSelected = i;
    });

    _refresh(forceLoading: false);
  }

  String get _filterBy {
    switch (_tab) {
      case "ALL":
        return "";

      case "MY":
        return "MY";

      case "NEW":
        return "STATUS_NEW";

      case "REJECTED":
        return "STATUS_REJECTED";
    }

    return "";
  }

  bool get allFilterSelected => _tabs[_tabSelected] == 'ALL';

  _refresh({bool forceLoading = true}) {
    setState(() {
      _data = Map<String, PaginationModel<RepairOrderModel>>.from(_data)..remove(_tab);
    });

    _fetch(
      forceLoading: forceLoading,
    );
  }

  _fetch({bool forceLoading = false}) async {
    _operation?.cancel();

    final connected = await isOnline;

    final data = _data[_tab];
    final page = data == null ? _initialPage : (data.page + 1);
    bool loading;

    // If first page or no active connection, search the cached items
    if (page == _initialPage || !connected) {
      final cached = await _getCachedItems();
      loading = cached.isEmpty;

      setState(() {
        _loading = Map<String, bool>.from(_loading)..[_tab] = loading;
        _items = Map<String, List<RepairOrderModel>>.from(_items)..[_tab] = cached;
        _isInit = Map<String, bool>.from(_isInit)..[_tab] = true;
        if (!connected) {
          _data = Map<String, PaginationModel<RepairOrderModel>>.from(_data)
            ..[_tab] = PaginationModel(
              data: const [],
              hasMore: false,
              page: 0,
              pageSize: cached.length,
              total: cached.length,
            );
        }
      });

      if (!connected) return;
    } else {
      loading = false;
    }

    if (forceLoading) {
      loading = true;
    }

    try {
      setState(() {
        _loading = Map<String, bool>.from(_loading)..[_tab] = loading;
        _error = Map<String, dynamic>.from(_error)..[_tab] = null;
      });

      final userData = ref.watch(userSettingsPod);
      final userType = userData.firstWhere((element) => element.key == "appType");
      final isRepairOrder = userType.value == "SERVICE";

      final future = _repairOrderService.getList(
        page: page,
        type: isRepairOrder ? RepairOrderTypeFilter.repairOrders : RepairOrderTypeFilter.salesOrders,
        filterBy: _filterBy,
      );
      _operation = CancelableOperation<PaginationModel<RepairOrderModel>>.fromFuture(future);
      final data = (await _operation?.value)!;
      if (!mounted) return;

      if (page == _initialPage) {
        await _repairOrderService.setCacheList(
          status: _filterBy,
          items: data.data,
        );
      }

      final newItems = data.data;
      List<RepairOrderModel> currentItems;
      if (page == _initialPage) {
        currentItems = [];
      } else {
        currentItems = _items[_tab] ?? [];
      }

      final items = _appendList(currentItems, newItems);

      setState(() {
        _loading = Map<String, bool>.from(_loading)..[_tab] = false;
        _items = Map<String, List<RepairOrderModel>>.from(_items)..[_tab] = items;
        _data = Map<String, PaginationModel<RepairOrderModel>>.from(_data)..[_tab] = data;
      });
    } catch (error, stack) {
      log("Error fetching orders", error: error, stackTrace: stack);
      if (!mounted) return;

      if (page == _initialPage) {
        await _repairOrderService.setCacheList(
          items: [],
          status: _filterBy,
        );
      }

      setState(() {
        _loading = Map<String, bool>.from(_loading)..[_tab] = false;
        _error = Map<String, dynamic>.from(_error)..[_tab] = error;
      });
    }
  }

  _appendList(List<RepairOrderModel> oldData, List<RepairOrderModel> newData) {
    var result = List<RepairOrderModel>.from(oldData);
    result = result.map((item) {
      final newItem = newData.firstWhereOrNull((newItem) => newItem.id == item.id);
      if (newItem != null) {
        return newItem;
      }
      return item;
    }).toList();

    for (var element in newData) {
      if (result.any((e) => e.id == element.id)) continue;
      result.add(element);
    }

    return result;
  }

  _goToDetail(int id) {
    Navigator.of(context).pushNamed(
      ScreenRepairOrder.routeName,
      arguments: ScreenRepairOrderParams(
        id: id,
        onUpdate: () => _refreshItem(id),
      ),
    );
  }

  _onButtonCreatePressed() async {
    final id = await Navigator.of(context).pushNamed(
      ScreenRepairOrderNew.routeName,
      arguments: ScreenRepairOrderNewParams(
        onUpdated: () => _refresh(forceLoading: true),
      ),
    );

    if (id == null || id is! int) return;
    _goToDetail(id);
  }

  _refreshItem(int id) async {
    try {
      final RepairOrderService repairOrderService = GetIt.I.get();
      final items = await repairOrderService.getList(id: id);
      if (!mounted) return;

      if (items.data.isNotEmpty) {
        final item = items.data.first;
        await repairOrderService.updateCacheList(item);
        if (!mounted) return;

        for (var entry in _items.entries) {
          final newItems = entry.value.map((e) {
            if (e.id == item.id) return item;
            return e;
          }).toList();

          setState(() {
            _items = Map<String, List<RepairOrderModel>>.from(_items)..[entry.key] = newItems;
          });
        }
      }
    } catch (error, stack) {
      log("Error refreshing item", error: error, stackTrace: stack);
    }
  }

  String get _tab {
    if (_tabs.isEmpty) return "";
    return _tabs[_tabSelected];
  }

  bool get _firstPageError {
    final error = _error[_tab];
    final data = _data[_tab];
    return error != null && data == null;
  }

  bool get _loadingFirstPage {
    final loading = _loading[_tab] == true;
    final data = _data[_tab];
    return loading && data == null;
  }

  bool get _noItemsFound {
    final loading = _loading[_tab] == true;
    final error = _error[_tab];
    final items = _items[_tab] ?? [];
    return !loading && error == null && items.isEmpty;
  }

  _goToSearch() async {
    final item = await Navigator.of(context).pushNamed(ScreenRepairOrderSearchList.routeName);
    if (item == null || item is! RepairOrderModel) return;
    _goToDetail(item.id);
  }

  Future<bool> _onWillPop() async {
    return onButtonBackPressed();
  }

  @override
  Widget build(BuildContext context) {
    final appBarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);
    final fabVisible = !_firstPageError && !_loadingFirstPage && !_noItemsFound;
    final appTypeRO = useIsAppTypeRepairOrder(ref);

    // AppBar Title
    if (appTypeRO) {
      widget.controller.appBarTitle = "Orders";
    } else {
      widget.controller.appBarTitle = "Prospects";
    }

    // AppBar actions
    widget.controller.appBarActions = [
      CustomButtonIcon(
        enabled: _loading[_tab] != true,
        icon: Icons.search,
        backgroundColor: Colors.transparent,
        iconColor: appBarIconColor,
        onPressed: () => _goToSearch(),
      ),
      CustomButtonIcon(
        enabled: _loading[_tab] != true,
        icon: Icons.refresh,
        backgroundColor: Colors.transparent,
        iconColor: appBarIconColor,
        onPressed: () => _refresh(forceLoading: true),
      ),
      CustomAppBarLoggedUser(
        onPressed: () => showCustomDialogUserProfile(),
      ),
    ];

    // FAB
    widget.controller.fab = CustomAnimatedFadeVisibility(
      visible: fabVisible,
      child: CustomGradientButton(
        borderRadius: 100,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        gradient: CustomColorsUtils.gradient,
        text: "CREATE",
        onPressed: () => _onButtonCreatePressed(),
        icon: Icons.add,
      ),
    );

    // On Will pop
    widget.controller.onWillPop = _onWillPop;

    final loading = _loading[_tab] ?? true;
    final isInit = _isInit[_tab] ?? false;
    final error = _error[_tab];
    final data = _data[_tab];
    final items = _items[_tab] ?? [];

    return CustomTabContainer(
      mainAxisSize: MainAxisSize.max,
      length: _tabs.length,
      selected: _tabSelected,
      onTabPressed: _onTabChanged,
      textBuilder: (index) => _tabs[index],
      padding: const EdgeInsets.only(left: 10, right: 10, top: 4.0),
      fadingEdgeSize: 10,
      contentBuilder: (BuildContext context) => RefreshIndicator(
        key: ValueKey(_tab),
        onRefresh: () async => _refresh(forceLoading: true),
        child: Column(
          children: [
            const CustomDivider(),
            Expanded(
              child: CustomList<RepairOrderModel>.separated(
                listWrapper: (context, child) => CustomFadingEdgeList(child: child),
                areItemsTheSame: (a, b) => a.id == b.id,
                padding: EdgeInsets.only(bottom: fabVisible ? 80 : 16, top: 16.0),
                loadingBuilder: (c) => isInit ? const ScreenHomeRepairOrdersShimmer() : Container(),
                loading: loading && data == null,
                error: error,
                data: items,
                showLoadMore: data?.hasMore ?? false,
                loadMore: _fetch,
                loadingMoreError: data != null ? error : null,
                itemBuilder: (context, item) => RepairOrderListItem(
                  model: item,
                  onPressed: (m) => _goToDetail(m.id),
                ),
                emptyBuilder: (context) => CustomListIndicatorEmpty(
                  message: appTypeRO ? "Let's create your first order" : "Let's create your first prospect",
                  buttonText: "CREATE",
                  buttonIcon: Icons.add,
                  onButtonPressed: _onButtonCreatePressed,
                ),
                errorBuilder: (context, error) => CustomListIndicatorError(
                  onButtonPressed: () => _refresh(forceLoading: true),
                  error: error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
