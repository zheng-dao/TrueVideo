import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/riverpod/auth.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/screen/setting/index.dart';
import 'package:truvideo_enterprise/widget/screen/support/index.dart';
import 'package:truvideo_enterprise/widget/screen/user_logout/index.dart';

class CustomDialogUserProfile extends StatefulHookConsumerWidget {
  final Future<void> Function()? close;

  const CustomDialogUserProfile({
    Key? key,
    this.close,
  }) : super(key: key);

  @override
  ConsumerState<CustomDialogUserProfile> createState() => _CustomDialogUserProfileState();
}

class _CustomDialogUserProfileState extends ConsumerState<CustomDialogUserProfile> {
  _goToSettings(BuildContext context) async {
    await widget.close?.call();

    if (!mounted) return;
    Navigator.of(context).pushNamed(
      ScreenSettings.routeName,
      arguments: ScreenSettingsParams(),
    );
  }

  _goToSupport(BuildContext context) async {
    await widget.close?.call();

    if (!mounted) return;
    Navigator.of(context).pushNamed(
      ScreenSupport.routeName,
      arguments: ScreenSupportParams(),
    );
  }

  _askLogout(BuildContext context) async {
    final logout = await showCustomDialogRetry(
      title: "Log out",
      message: "Are you sure?",
      retryButtonText: "Yes",
      cancelButtonText: "No",
    );
    if (!logout) return;
    await widget.close?.call();

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(ScreenUserLogout.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authPod);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomListTile(
          color: Theme.of(context).dividerColor.withOpacity(0.4),
          titleText: user?.displayName ?? "",
          subtitleText: user?.emailAddress ?? "",
          leading: const CustomListTileImage(
            icon: Icons.person_outline,
            color: Colors.white,
          ),
        ),
        const CustomDivider(),
        CustomListTile(
          dense: true,
          color: Theme.of(context).dividerColor.withOpacity(0.4),
          titleText: "Dealer",
          subtitleText: user?.dealer?.name ?? "",
        ),
        const CustomDivider(),
        const SizedBox(height: 16.0),
        CustomListTile(
          dense: true,
          leading: const CustomListTileImage.small(
            icon: Icons.settings,
            color: Colors.transparent,
          ),
          titleText: "Settings",
          onPressed: () => _goToSettings(context),
        ),
        const CustomDivider(),
        CustomListTile(
          dense: true,
          leading: const CustomListTileImage.small(
            icon: Icons.help_center_outlined,
            color: Colors.transparent,
          ),
          titleText: "Support",
          onPressed: () => _goToSupport(context),
        ),
        const CustomDivider(),
        CustomListTile(
          dense: true,
          leading: const CustomListTileImage.small(
            icon: Icons.exit_to_app,
            color: Colors.transparent,
          ),
          titleText: "Log out",
          onPressed: () => _askLogout(context),
        ),
      ],
    );
  }
}
