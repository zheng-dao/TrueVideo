import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';

class CallParticipant extends StatelessWidget {
  final String name;
  final String photoURL;
  final Function()? onPressed;
  final bool muted;
  final bool selected;
  final String status;

  const CallParticipant({
    Key? key,
    this.name = "",
    this.photoURL = "",
    this.onPressed,
    this.muted = false,
    this.selected = false,
    this.status = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      focusElevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
        side: selected
            ? BorderSide(
                color: Theme.of(context).colorScheme.secondary,
                width: 3,
              )
            : BorderSide.none,
      ),
      fillColor: CustomColorsUtils.callParticipantColor,
      onPressed: () {},
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      height: double.infinity,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return CustomImage(
                            source: CustomImageDataSource.network(photoURL),
                            placeholder: CustomImagePlaceholder(
                              color: Colors.white.withOpacity(0.2),
                              icon: Icons.person_outline,
                              iconColor: Colors.white.withOpacity(0.9),
                              iconSize: constraints.smallest.shortestSide * 0.3,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    status,
                    style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 8.0,
            top: 8.0,
            child: CustomAnimatedFadeVisibility(
              visible: muted,
              child: const Icon(
                Icons.mic_off,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
