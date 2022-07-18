import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/camera/panel_options.dart';

class CustomCameraPanelOptionsNarratorMode extends HookConsumerWidget {
  final bool visible;
  final Function()? close;
  final bool narratorMode;
  final Function(bool narratorMode)? onChange;

  const CustomCameraPanelOptionsNarratorMode({
    Key? key,
    this.visible = true,
    this.close,
    this.onChange,
    this.narratorMode = true,
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
            "Narrator mode",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 32.0),
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              // OFF
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButtonIcon(
                    icon: MdiIcons.microphoneOff,
                    backgroundColor: !narratorMode ? Colors.amber : null,
                    onPressed: () => onChange?.call(false),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "OFF",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ],
              ),

              // ON
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButtonIcon(
                    icon: MdiIcons.microphone,
                    backgroundColor: narratorMode ? Colors.amber : null,
                    onPressed: () => onChange?.call(true),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    "ON",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
