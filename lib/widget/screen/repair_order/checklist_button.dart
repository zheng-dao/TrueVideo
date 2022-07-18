import 'dart:developer';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/model/repair_order_detail.dart';
import 'package:truvideo_enterprise/service/checklist/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/mixin/connectivity.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/index.dart';
import 'package:truvideo_enterprise/widget/screen/checklist/dialog.dart';

class ChecklistButton extends StatefulHookConsumerWidget {
  final RepairOrderDetailModel model;

  const ChecklistButton({required this.model, Key? key}) : super(key: key);

  @override
  ConsumerState<ChecklistButton> createState() => _ChecklistButtonState();
}

class _ChecklistButtonState extends ConsumerState<ChecklistButton> with ConnectivityMixin {
  bool _loading = true;
  dynamic _error;
  ChecklistStatus? _status;
  CancelableOperation<ChecklistStatus>? _cancelableOperation;

  ChecklistService get _checklistService => GetIt.I.get();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _cancelableOperation?.cancel();
    super.dispose();
  }

  _init() {
    _fetchData();
  }

  @override
  onConnectivityChange(bool online) {
    _fetchData(forceLoading: true);
  }

  Future<void> _fetchData({bool forceLoading = false}) async {
    _cancelableOperation?.cancel();

    final online = await isOnline;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final jobServiceNumber = widget.model.jobServiceNumber;

      if (!forceLoading) {
        final cachedStatus = await _checklistService.getCachedStatus(jobServiceNumber);
        if (!mounted) return;

        if (cachedStatus != null) {
          setState(() {
            _status = cachedStatus;
            _loading = false;
          });
        } else {
          if (!online) {
            throw CustomException(message: "No internet connection");
          }
        }
      }

      if (!online) return;

      _cancelableOperation = CancelableOperation<ChecklistStatus>.fromFuture(_checklistService.getStatus(jobServiceNumber));
      final status = await _cancelableOperation?.value;
      if (!mounted) return;

      if (status != null) {
        await _checklistService.cacheStatus(jobServiceNumber, status);
      }

      setState(() {
        _loading = false;
        _status = status;
      });
    } catch (error, stack) {
      log("Error fetching reply data", error: error, stackTrace: stack);
      _cancelableOperation?.cancel();
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

  void _onButtonPress() async {
    final args = await Navigator.of(context).pushNamed(
      ScreenChecklist.routeName,
      arguments: ScreenChecklistParams(jobServiceNumber: widget.model.jobServiceNumber),
    );

    if (args != null && args is String) {
      showSuccessMessage();
      _fetchData();
    }
  }

  IconData get _buttonIcon {
    if (_error != null) return Icons.refresh;
    return Icons.checklist;
  }

  String get _buttonLabel {
    if (_error != null) return "Retry";

    final status = _status;
    if (status == null) return "";

    switch (status) {
      case ChecklistStatus.noExisting:
        return "New inspection";
      case ChecklistStatus.existing:
        return "Go to inspection";
      case ChecklistStatus.existingResume:
        return "Resume inspection";
      case ChecklistStatus.existingReturned:
        return "Go to inspection";
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasError = _error != null;
    bool inspectionReturned = _status == ChecklistStatus.existingReturned;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomGradientButton(
          loading: _loading,
          width: double.maxFinite,
          margin: const EdgeInsets.all(16),
          gradient: CustomColorsUtils.gradient,
          onPressed: () async {
            if (hasError) {
              _fetchData(forceLoading: true);
              return;
            }
            _onButtonPress();
          },
          text: _buttonLabel,
          icon: _buttonIcon,
        ),
        CustomAnimatedCollapseVisibility(
          visible: inspectionReturned,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
            child: Text(
              "Inspection returned",
              style: TextStyle(color: CustomColorsUtils.statusCancel, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
