import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/permission.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class CustomDialogPermissions extends StatefulWidget {
  final List<Permission> permissions;
  final Function()? onGranted;
  final Function()? onDenied;

  const CustomDialogPermissions({Key? key, required this.permissions, this.onGranted, this.onDenied}) : super(key: key);

  @override
  State<CustomDialogPermissions> createState() => _CustomDialogPermissionsState();
}

class _CustomDialogPermissionsState extends State<CustomDialogPermissions> {
  var _status = <Permission, PermissionStatus>{};

  bool get _allGranted {
    for (var element in widget.permissions) {
      final status = _status[element];
      if (status == null || !(status.isGranted)) return false;
    }

    return true;
  }

  bool get _someIsPermanentlyDenied {
    for (var element in widget.permissions) {
      final status = _status[element];
      if (status != null && status.isPermanentlyDenied) return true;
    }

    return false;
  }

  bool get _someIsRestricted {
    for (var element in widget.permissions) {
      final status = _status[element];
      if (status != null && (status.isRestricted || status.isLimited)) return true;
    }

    return false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  _init() async {
    await _fetchStatus();
    _requestPermissions();
  }

  _fetchStatus() async {
    final result = <Permission, PermissionStatus>{};
    for (var p in widget.permissions) {
      final status = await p.status;
      result[p] = status;
    }

    if (!mounted) return;
    setState(() {
      _status = result;
    });

    if (_allGranted) {
      widget.onGranted?.call();
      return;
    }
  }

  _requestPermissions() async {
    final status = await CustomPermissionUtils.askStatus(widget.permissions);
    if (!mounted) return;
    setState(() {
      _status = status;
    });

    if (_allGranted) {
      widget.onGranted?.call();
      return;
    }
  }

  String _permissionName(Permission p) {
    if (p == Permission.camera) return "Camera";
    if (p == Permission.microphone) return "Microphone";
    if (p == Permission.photos) return "Photos and videos";
    return p.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAnimatedCollapseVisibility(
          visible: _someIsRestricted || _someIsPermanentlyDenied,
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.red.shade600,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                if (_someIsRestricted)
                  Text(
                    "Some permissions are restricted or limited by your device. Please check the device app settings to continue",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                if (_someIsPermanentlyDenied)
                  Text(
                    "Some permissions are permanently denied. Please check the device app settings to continue",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                CustomBorderButton.small(
                  width: double.infinity,
                  fillColor: Colors.white.withOpacity(0.3),
                  textColor: Colors.white,
                  text: "Open app settings",
                  margin: const EdgeInsets.only(top: 16),
                  onPressed: () => openAppSettings(),
                ),
              ],
            ),
          ),
        ),
        CustomList<Permission>.separated(
          shrinkWrap: true,
          data: widget.permissions,
          itemBuilder: (context, item) {
            final status = _status[item];
            String statusText = "";
            Color? statusColor;

            if (status == null) {
              statusText = "";
            } else {
              switch (status) {
                case PermissionStatus.denied:
                  statusText = "Denied";
                  break;
                case PermissionStatus.granted:
                  statusText = "Granted";
                  statusColor = Colors.green.shade600;
                  break;
                case PermissionStatus.restricted:
                  statusText = "Restricted";
                  statusColor = Colors.red.shade600;
                  break;
                case PermissionStatus.limited:
                  statusText = "Limited";
                  statusColor = Colors.red.shade600;
                  break;
                case PermissionStatus.permanentlyDenied:
                  statusText = "Permanently denied";
                  statusColor = Colors.red.shade600;
                  break;
              }
            }

            return CustomListTile(
              dense: true,
              titleText: _permissionName(item),
              trailingText: statusText,
              trailingColor: statusColor,
            );
          },
          areItemsTheSame: (a, b) => a == b,
        ),
        CustomGradientButton(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
          gradient: CustomColorsUtils.gradient,
          text: "Grant permissions",
          onPressed: _requestPermissions,
        ),
        CustomBorderButton.small(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8.0, left: 16, right: 16),
          text: "Cancel",
          onPressed: () => widget.onDenied?.call(),
        ),
      ],
    );
  }
}
