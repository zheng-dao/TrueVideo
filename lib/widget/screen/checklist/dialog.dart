import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';

Future<void> showSuccessMessage() async {
  await showCustomDialog(
    title: "Success",
    message: "Inspection submitted successfully!",
    buttonsBuilder: (context, controller) => [
      CustomBorderButton.small(
        text: "Close",
        onPressed: () async {
          controller.close();
        },
      ),
    ],
  );
}

Future<bool> showErrorMessage() async {
  bool result = false;
  await showCustomDialog(
    title: "Operation not completed",
    message: "Something went wrong submitting form.",
    buttonsBuilder: (context, controller) => [

      CustomBorderButton.small(
        text: "Cancel",
        onPressed: () async {
          result = false;
          controller.close();
        },
      ),
      CustomGradientButton.small(
        gradient: CustomColorsUtils.gradient,
        text: "Retry",
        onPressed: () async {
          result = true;
          controller.close();
        },
      ),
    ],
  );
  return result;
}

Future<bool> showConfirmationExitDialog() async {
  bool result = false;
  await showCustomDialog(
    title: "Exit?",
    message: "If you exit this screen, all of your progress will be lost.\n\nDo you wish to continue?",
    buttonsBuilder: (context, controller) => [
      CustomBorderButton.small(
        text: "No",
        onPressed: () async {
          result = false;
          controller.close();
        },
      ),
      CustomBorderButton.small(
        text: "Yes",
        onPressed: () async {
          result = true;
          controller.close();
        },
      ),
    ],
  );
  return result;
}
