import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/hook/camera_quality.dart';
import 'package:truvideo_enterprise/service/settings/camera_quality.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/camera/panel_options.dart';

class CustomCameraPanelOptionsQuality extends HookConsumerWidget {
  final bool visible;
  final Function()? close;
  final Function(CameraQuality cameraQuality)? onChange;

  const CustomCameraPanelOptionsQuality({
    Key? key,
    this.visible = true,
    this.close,
    this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cameraQuality = useCameraQuality(ref);

    return CustomCameraPanelOptions(
      visible: visible,
      close: close,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Camera Quality",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 32.0),
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              ...CameraQuality.values
                  .map(
                    (e) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButtonIcon(
                          icon: e.icon,
                          backgroundColor: cameraQuality == e ? Colors.amber : null,
                          onPressed: () => onChange?.call(e),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          e.name,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                  .toList()
            ],
          ),
        ],
      ),
    );
  }
}
