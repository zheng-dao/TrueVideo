import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/model/message_call_participant.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/service/date/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/screen/active_call/participant.dart';

class ActiveCall extends ConsumerWidget {
  final String to;
  final String status;
  final DateTime? createdAt;
  final String error;
  final Function()? onButtonRetryPressed;
  final List<MessageCallParticipantModel> participants;
  final Function(MessageCallParticipantModel model)? onParticipantPressed;

  const ActiveCall({
    Key? key,
    this.onParticipantPressed,
    this.to = "",
    this.status = "",
    this.createdAt,
    this.error = "",
    this.onButtonRetryPressed,
    this.participants = const [],
  }) : super(key: key);

  String get _data {
    final parts = <String>[];
    if (status.trim().isNotEmpty) {
      parts.add(status);
    }

    if (createdAt != null) {
      final DateService dateService = GetIt.I.get();
      final d = DateTime.now().difference(createdAt!);
      parts.add(dateService.duration(d));
    }

    if (parts.isEmpty) return "";
    return parts.join(" - ");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagingUser = ref.watch(messagingAuthenticationInformationPod);
    final bool isAlone =
        participants.isEmpty || (participants.length == 1 && participants[0].messageableEntityUID == messagingUser?.subjectMessageableEntity?.uid);

    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomAnimatedCollapseVisibility(
            visible: to.trim().isNotEmpty,
            child: Text(
              to,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white),
            ),
          ),
          CustomAnimatedCollapseVisibility(
            visible: _data.trim().isNotEmpty,
            child: Text(
              _data,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
            ),
          ),
          CustomAnimatedCollapseVisibility(
            visible: error.trim().isNotEmpty,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 32.0),
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.warning,
                    color: CustomColorsUtils.delete,
                    size: 50,
                  ),
                  Text(
                    "Something went wrong",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 16.0),
                  CustomBorderButton(
                    fillColor: Colors.white.withOpacity(0.3),
                    text: "Try again",
                    height: 35,
                    textColor: Colors.white,
                    onPressed: onButtonRetryPressed,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                // Empty
                CustomAnimatedFadeVisibility(
                  visible: isAlone,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Please wait for the others participants",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                // Participants
                CustomAnimatedFadeVisibility(
                  visible: !isAlone,
                  child: Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    child: CustomFadingEdgeList(
                      size: 16.0,
                      color: CustomColorsUtils.callBackground,
                      child: GridView.count(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        crossAxisCount: 2,
                        children: List.generate(
                          participants.length,
                          (index) => CallParticipant(
                            onPressed: () => onParticipantPressed?.call(participants[index]),
                            name: participants[index].messageableEntityDisplayName,
                            selected: participants[index].messageableEntityUID == messagingUser?.subjectMessageableEntity?.uid,
                            status: participants[index].status,
                            muted: participants[index].muted,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
