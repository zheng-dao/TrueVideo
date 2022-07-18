import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

Future<bool> showCustomRepairOrderDelete(List<String> uuids) async {
  String title;
  String message;
  if (uuids.length == 1) {
    title = "Delete Repair Order";
    message = "Are you your you want to delete the RO?";
  } else {
    title = "Delete Repair Orders";
    message = "Are you sure you want to delete ${uuids.length} RO's?";
  }
  bool result = false;
  await showCustomDialog(
    title: title,
    message: message,
    buttonsBuilder: (context, controller) => [
      CustomBorderButton.small(
        text: "Cancel",
        onPressed: () async {
          result = false;
          controller.close();
        },
      ),
      CustomGradientButton.small(
        gradient: CustomColorsUtils.deleteGradient,
        text: "Delete",
        onPressed: () async {
          controller.setLoading(true);
          final deleted = await _delete(uuids);
          if (deleted) {
            result = true;
            controller.close();
          } else {
            result = false;
            controller.setLoading(false);
          }
        },
      ),
    ],
  );
  return result;
}

Future<bool> _delete(List<String> uuids) async {
  try {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  } catch (error) {
    return false;
  }
}
