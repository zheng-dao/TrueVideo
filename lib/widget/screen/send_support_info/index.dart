import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/formatter/word_capitalization.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/model/support_info.dart';
import 'package:truvideo_enterprise/service/support/_interface.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';

class SendSupportInfoScreenParams {
  final SupportInfoModel supportInfo;
  CustomRouteType? routeType;

  SendSupportInfoScreenParams({required this.supportInfo, this.routeType});
}

class SendSupportInfoScreen extends StatefulWidget {
  static const String routeName = "/SendInfoSupport";
  final SendSupportInfoScreenParams params;

  const SendSupportInfoScreen({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  State<SendSupportInfoScreen> createState() => _SendSupportInfoScreenState();
}

class _SendSupportInfoScreenState extends State<SendSupportInfoScreen> {
  SupportInfoModel? _supportInfo;
  bool _sending = false;

  final _formKey = GlobalKey<FormState>();

  final _email = TextEditingController();
  final _focusNodeEmail = FocusNode();

  final _phone = TextEditingController();
  final _focusNodePhone = FocusNode();
  final _comment = TextEditingController();
  final _focusNodeComment = FocusNode();

  final _phonePattern = r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$";

  @override
  void initState() {
    super.initState();
  }

  _sendInfo() async {
    if (!_formKey.currentState!.validate()) return;
    try {
      final SupportService service = GetIt.I.get();
      setState(() {
        _sending = true;
      });

      await service.sendInfo(supportInfo: _supportInfo, email: _email.text, phone: _phone.text, comment: _comment.text);
      if (!mounted) return;

      setState(() {
        _sending = false;
      });
      Navigator.of(context).pop();
      await showCustomDialog(
        title: "",
        message: "Successfully sent application settings to support.",
        buttonsBuilder: (context, controller) => [
          CustomBorderButton.small(
            text: "Ok",
            onPressed: () {
              controller.close();
            },
          ),
        ],
      );
    } catch (error) {
      log("Error trying to send support information");
      if (!mounted) return;

      setState(() {
        _sending = false;
      });

      final retry = await showCustomDialogRetry();
      if (retry) {
        _sendInfo();
      }
    }
  }

  _close() {
    if (_sending) return;
    Navigator.of(context).pop();
  }

  ScrollPhysics get _scrollPhysics {
    if (_sending) return const NeverScrollableScrollPhysics();
    return const BouncingScrollPhysics();
  }

  @override
  Widget build(BuildContext context) {
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    Color appBarFillColor;
    Color appBarIconColor;
    if (isRouteTypeCupertinoVertical) {
      appBarFillColor = CustomColorsUtils.chatBackground;
    } else {
      appBarFillColor = Theme.of(context).colorScheme.secondary;
    }
    appBarIconColor = appBarFillColor.contrast(context);

    final buttonClose = CustomButtonIcon(
      enabled: !_sending,
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      backgroundColor: Colors.transparent,
      iconColor: appBarIconColor,
      onPressed: _close,
    );

    return CustomScaffold(
      loading: false,
      onWillPop: _sending ? () async => false : null,
      appbar: CustomAppBar(
        backgroundColor: appBarFillColor,
        title: "Application Settings",
        titleColor: appBarIconColor,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
      ),
      loadingMinOpacity: 0.0,
      body: SingleChildScrollView(
        physics: _scrollPhysics,
        controller: ModalScrollController.of(context),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomTextField(
                      enabled: true,
                      controller: _email,
                      focusNode: _focusNodeEmail,
                      hintText: "Preferred e-mail",
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "Required"),
                          EmailValidator(errorText: "Invalid e-mail"),
                        ],
                      ),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (v) => _focusNodePhone.requestFocus(),
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      enabled: true,
                      controller: _phone,
                      focusNode: _focusNodePhone,
                      hintText: "Preferred phone",
                      keyboardType: TextInputType.phone,
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: "Required"),
                          PatternValidator(_phonePattern, errorText: "Invalid phone"),
                        ],
                      ),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (v) => _focusNodeComment.requestFocus(),
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      enabled: true,
                      controller: _comment,
                      focusNode: _focusNodeComment,
                      minLines: 3,
                      maxLines: 4,
                      hintText: "Comment",
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [CustomTextInputFormatterWordsCapitalization()],
                      textInputAction: TextInputAction.done,
                      onSubmitted: (v) => CustomKeyboardUtils.hide(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      navigationBar: CustomGradientButton(
        margin: const EdgeInsets.all(16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).viewPadding.bottom),
        gradient: CustomColorsUtils.gradient,
        onPressed: _sendInfo,
        loading: _sending,
        text: "SEND TO SUPPORT",
      ),
    );
  }
}
