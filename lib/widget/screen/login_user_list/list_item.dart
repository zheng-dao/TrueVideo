import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:truvideo_enterprise/model/user_login.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';

class ScreenLoginUserListItem extends HookConsumerWidget {
  final UserLoginModel model;
  final String dealerUuid;
  final bool showLastDate;
  final Function(UserLoginModel model)? onPressed;
  final EdgeInsets? padding;

  const ScreenLoginUserListItem({
    Key? key,
    required this.dealerUuid,
    this.padding,
    required this.model,
    this.showLastDate = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = useMemoized(
      () {
        final AuthService service = GetIt.I.get();
        return service.getLastAccessDate(model.publicUserUuid);
      },
      [model],
    );

    return CustomListTile(
      titleText: model.completeName,
      leading: const CustomListTileImage(icon: Icons.person_outline),
      trailingText: showLastDate && date != null ? timeago.format(date) : "",
      onPressed: onPressed == null ? null : () => onPressed?.call(model),
    );
  }
}
