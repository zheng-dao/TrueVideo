import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/hook/is_repair_order_type.dart';
import 'package:truvideo_enterprise/hook/video_session.dart';
import 'package:truvideo_enterprise/model/camera/camera_result.dart';
import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/event_bus/event_video_uploaded.dart';
import 'package:truvideo_enterprise/model/video_tag_model.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/model/video_type_model.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/service/connectivity/_interface.dart';
import 'package:truvideo_enterprise/service/event_bus/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/camera/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/container/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order/shimmer.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_new/index.dart';

import 'content.dart';

class ScreenRepairOrderParams {
  final int id;
  final Function()? onUpdate;
  CustomRouteType? routeType;

  ScreenRepairOrderParams({
    required this.id,
    this.onUpdate,
    this.routeType,
  });
}

class ScreenRepairOrder extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenRepairOrder";
  final ScreenRepairOrderParams params;

  const ScreenRepairOrder({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenRepairOrder> createState() => _ScreenRepairOrderState();
}

class _ScreenRepairOrderState extends ConsumerState<ScreenRepairOrder> {
  StreamSubscription? _streamSubscriptionVideoUploaded;

  bool _loading = true;
  dynamic _error;
  RepairOrderDetailModel? _data;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _streamSubscriptionVideoUploaded?.cancel();
    super.dispose();
  }

  _init() async {
    final RepairOrderService repairOrderService = GetIt.I.get();
    final cached = await repairOrderService.getCachedDetail(widget.params.id);

    if (cached != null) {
      setState(() {
        _loading = false;
        _data = cached;
      });
    }

    setState(() => _isInit = true);
    _refresh(loading: cached == null);

    // Listen video uploaded event to refresh the screen
    final EventBusService eventBusService = GetIt.I.get();
    _streamSubscriptionVideoUploaded = eventBusService.streamEvents<EventVideoUploadedModel>().listen((event) {
      if (widget.params.id != event.orderID) return;
      _refresh(loading: false);
    });
  }

  _refresh({bool loading = true}) async {
    final RepairOrderService repairOrderService = GetIt.I.get();
    final ConnectivityService connectivityService = GetIt.I.get();

    try {
      setState(() {
        _error = null;
        _loading = loading;
      });

      RepairOrderDetailModel? model;
      if (await connectivityService.isOnline()) {
        model = await repairOrderService.getDetail(widget.params.id);
      } else {
        model = await repairOrderService.getCachedDetail(widget.params.id);
      }

      if (model == null) {
        throw CustomException(message: "Entity not found");
      }

      widget.params.onUpdate?.call();

      setState(() {
        _loading = false;
        _data = model;
      });
    } catch (error, stack) {
      log("Error fetching RO", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() {
        _error = error;
        _loading = false;
      });
    }
  }

  _onButtonEditPressed() async {
    final edited = await Navigator.of(context).pushNamed(
      ScreenRepairOrderNew.routeName,
      arguments: ScreenRepairOrderNewParams(
        id: _data?.id ?? 0,
      ),
    );

    if (edited == true) {
      _refresh();
    }
  }

  _resumeVideo(VideoSessionModel model) async {
    final result = await showCustomCameraVideo(videoSessionUID: model.uid);
    if (result == null) return;
    _addVideoUploadRequest(result);
  }

  _onCameraPressed() async {
    final result = await showCustomCameraVideo(
      videoSessionTag: _data?.id.toString() ?? "",
      orderID: widget.params.id,
    );
    if (result == null) return;

    _addVideoUploadRequest(result);
  }

  _addVideoUploadRequest(CameraResultModel cameraResultModel) async {
    final data = _data;
    if (data == null) return;

    VideoTagModel? tag;
    VideoTypeModel? type;

    final userSettings = ref.read(userSettingsPod);
    // Preload video tag
    if (userSettings.isVideoTagEnabled && data.isRepairOrder) {
      tag = userSettings.videoTags.firstWhereOrNull((e) => e.key == "1");
    }

    // Preload video type
    if (data.isSalesOrder) {
      type = userSettings.videoTypes.firstWhereOrNull((e) => e.id == "INTERNET_INQUIRY");
    }

    // Create request
    final RepairOrderService repairOrderService = GetIt.I.get();
    await repairOrderService.addVideoUploadRequest(
      orderID: widget.params.id,
      orderType: data.type,
      cameraResult: cameraResultModel,
      tagId: tag?.key ?? "",
      typeId: type?.id ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    final appBarIconColor = Theme.of(context).appBarTheme.backgroundColor?.contrast(context);
    final isAppTypeRepairOrder = useIsAppTypeRepairOrder(ref);
    final videoSessionSnapshot = useVideoSession(ref, _data?.id.toString() ?? "");
    bool fabVisible = !_loading && _error == null;
    if (videoSessionSnapshot.connectionState == ConnectionState.waiting || videoSessionSnapshot.data != null) {
      fabVisible = false;
    }

    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      appbar: CustomAppBar(
        title: isAppTypeRepairOrder ? "Order detail" : "Prospect detail",
        leading: CustomButtonIcon(
          icon: Icons.arrow_back_ios,
          onPressed: () => Navigator.of(context).pop(),
          backgroundColor: Colors.transparent,
          iconColor: appBarIconColor,
        ),
        actionButtons: [
          CustomButtonIcon(
            enabled: !_loading,
            icon: Icons.refresh,
            backgroundColor: Colors.transparent,
            iconColor: appBarIconColor,
            onPressed: () => _refresh(loading: true),
          ),
          CustomButtonIcon(
            enabled: !_loading && _data != null,
            icon: Icons.edit,
            backgroundColor: Colors.transparent,
            iconColor: appBarIconColor,
            onPressed: _onButtonEditPressed,
          ),
        ],
      ),
      floatingActionButton: CustomAnimatedFadeVisibility(
        visible: fabVisible,
        child: CustomGradientButton(
          margin: const EdgeInsets.only(right: 5.0),
          borderRadius: 100,
          elevation: 8,
          width: 60,
          height: 60,
          padding: EdgeInsets.zero,
          gradient: CustomColorsUtils.gradient,
          icon: Icons.video_call,
          onPressed: _onCameraPressed,
        ),
      ),
      body: CustomContainer(
        alignment: Alignment.topCenter,
        mode: _loading ? CustomContainerMode.loading : (_error != null ? CustomContainerMode.error : CustomContainerMode.normal),
        errorData: _error,
        loadingBuilder: (context) => _isInit ? const ScreenRepairOrderDetailShimmer() : Container(),
        errorBuilder: (context, error) => CustomListIndicatorError(
          buttonText: "Retry",
          onButtonPressed: _init,
        ),
        builder: (context) => SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomFadingEdgeList(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                color: Colors.transparent,
                alignment: Alignment.topLeft,
                child: ScreenRepairOrderDetailContent(
                  model: _data!,
                  resumeVideo: _resumeVideo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
