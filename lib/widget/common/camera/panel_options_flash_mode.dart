import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/camera/panel_options.dart';
import 'package:truvideo_enterprise/widget/common/camera/util/flash_mode_extension.dart';

class CustomCameraPanelOptionsFlashMode extends HookConsumerWidget {
  final bool visible;
  final Function()? close;
  final Function(FlashMode flashMode)? onChange;
  final List<FlashMode> flashModes;
  final FlashMode? flashMode;

  const CustomCameraPanelOptionsFlashMode({
    Key? key,
    this.visible = true,
    this.close,
    this.onChange,
    this.flashModes = const <FlashMode>[],
    this.flashMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomCameraPanelOptions(
      visible: visible,
      close: close,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Flash mode",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 32.0),
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              ...flashModes
                  .map(
                    (e) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomButtonIcon(
                          icon: e.icon,
                          backgroundColor: flashMode == e ? Colors.amber : null,
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
