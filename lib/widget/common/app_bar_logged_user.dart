import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';

import 'button_icon/index.dart';

class CustomAppBarLoggedUser extends HookConsumerWidget {
  final Function()? onPressed;

  const CustomAppBarLoggedUser({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButtonIcon(
      icon: Icons.person_outline,
      backgroundColor: Colors.transparent,
      onPressed: onPressed,
      elevation: 0,
      focusedElevation: 0,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomImage(
          circle: true,
          source: CustomImageDataSource.network(
            "",
            color: Colors.transparent,
          ),
          placeholder: CustomImagePlaceholder(
            icon: Icons.person_outline,
            iconColor: Colors.white,
            color: Colors.black.withOpacity(0.1),
          ),
        ),
      ),
    );
  }
}
