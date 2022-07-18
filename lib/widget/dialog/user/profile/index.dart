import 'package:truvideo_enterprise/widget/common/popup/index.dart';
import 'package:truvideo_enterprise/widget/dialog/user/profile/widget.dart';

Future<void> showCustomDialogUserProfile() async {
  await showCustomPopup(
    right: 0,
    top: 0,
    width: 300,
    builder: (context, controller) => CustomDialogUserProfile(
      close: () async {
        await controller.close();
      },
    ),
  );
}
