import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';

class CallButtons extends StatelessWidget {
  final bool micMuteVisible;
  final bool micMutedEnabled;
  final bool micMuted;
  final Function()? onMicMutePressed;

  final bool speakerVisible;
  final bool speakerEnabled;
  final bool speaker;
  final Function()? onSpeakerPressed;

  final bool callDisconnected;
  final Function()? onClosePressed;
  final bool closeEnabled;

  const CallButtons({
    Key? key,
    this.micMuted = false,
    this.micMutedEnabled = true,
    this.speakerEnabled = true,
    this.speaker = false,
    this.onMicMutePressed,
    this.onSpeakerPressed,
    this.onClosePressed,
    this.micMuteVisible = true,
    this.speakerVisible = true,
    this.callDisconnected = false,
    this.closeEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAnimatedCollapseVisibility(
          visible: micMuteVisible,
          axis: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CustomButtonIcon(
              enabled: micMutedEnabled,
              icon: micMuted ? Icons.mic_off_outlined : Icons.mic_outlined,
              onPressed: onMicMutePressed,
              size: 56,
              iconSize: 25,
              backgroundColor: micMuted ? Colors.white : CustomColorsUtils.callParticipantColor,
              iconColor: micMuted ? Colors.black : CustomColorsUtils.callParticipantColor.contrast(context),
              elevation: 0,
              focusedElevation: 0,
            ),
          ),
        ),
        CustomAnimatedCollapseVisibility(
          visible: speakerVisible,
          axis: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CustomButtonIcon(
              enabled: speakerEnabled,
              size: 56,
              iconSize: 25,
              icon: speaker ? Icons.volume_up : Icons.volume_off,
              onPressed: onSpeakerPressed,
              backgroundColor: speaker ? Colors.white : CustomColorsUtils.callParticipantColor,
              iconColor: speaker ? Colors.black : CustomColorsUtils.callParticipantColor.contrast(context),
              elevation: 0,
              focusedElevation: 0,
            ),
          ),
        ),
        CustomButtonIcon(
          enabled: closeEnabled,
          icon: callDisconnected ? Icons.clear : MdiIcons.phoneHangup,
          size: 56,
          iconSize: 25,
          backgroundColor: CustomColorsUtils.delete,
          onPressed: onClosePressed,
        ),
      ],
    );
  }
}
