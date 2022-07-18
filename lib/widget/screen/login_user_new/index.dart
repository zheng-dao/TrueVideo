import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/formatter/capitalized.dart';
import 'package:truvideo_enterprise/core/formatter/lowercase.dart';
import 'package:truvideo_enterprise/core/formatter/word_capitalization.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/validator/min_length.dart';
import 'package:truvideo_enterprise/core/validator/repeat_password.dart';
import 'package:truvideo_enterprise/model/dealer_info.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/container/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field_phone_number/index.dart';
import 'package:truvideo_enterprise/widget/screen/login/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_list/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_new/model/result.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_new_pin/index.dart';

class ScreenLoginUserNewParams {
  CustomRouteType? routeType;

  ScreenLoginUserNewParams({this.routeType});
}

class ScreenLoginUserNew extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenLoginUserNew";

  final ScreenLoginUserNewParams params;

  const ScreenLoginUserNew({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenLoginUserNew> createState() => _ScreenLoginUserNewState();
}

class _ScreenLoginUserNewState extends ConsumerState<ScreenLoginUserNew> {
  DealerInfoModel? _dealerInfoModel;
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _nameFocusNode = FocusNode();

  final _lastName = TextEditingController();
  final _lastNameFocusNode = FocusNode();

  final _title = TextEditingController();
  final _titleFocusNode = FocusNode();

  final _email = TextEditingController();
  final _emailFocusNode = FocusNode();

  final _username = TextEditingController();
  final _userNameFocusNode = FocusNode();

  final _password = TextEditingController();
  final _passwordFocusNode = FocusNode();

  final _repeatPassword = TextEditingController();
  final _repeatPasswordFocusNode = FocusNode();

  final _phoneNumber = TextEditingController();
  final _phoneNumberFocusNode = FocusNode();
  final _phoneNumberKey = GlobalKey<CustomTextFieldPhoneNumberState>();

  bool _passwordVisible = false;
  final _insertedPassword = ValueNotifier("");
  bool _loading = true;
  bool _validating = false;

  @override
  void initState() {
    super.initState();

    _password.addListener(() {
      final newPassword = _password.text;
      if (newPassword != _insertedPassword.value) {
        _insertedPassword.value = newPassword;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _name.dispose();
    _nameFocusNode.dispose();

    _lastName.dispose();
    _lastNameFocusNode.dispose();

    _title.dispose();
    _titleFocusNode.dispose();

    _email.dispose();
    _emailFocusNode.dispose();

    _username.dispose();
    _userNameFocusNode.dispose();

    _password.dispose();
    _passwordFocusNode.dispose();

    _repeatPassword.dispose();
    _repeatPasswordFocusNode.dispose();

    _phoneNumber.dispose();
    _phoneNumberFocusNode.dispose();

    super.dispose();
  }

  String get _storedDealerCode {
    final AuthService service = GetIt.I.get();
    return service.getStoredDealerCode();
  }

  bool get _isSalesAgent =>
      _dealerInfoModel != null && (_dealerInfoModel!.dealerCodeType == "SALES_SHARED" || _dealerInfoModel!.dealerCodeType == "SALES");

  _init() async {
    if (_storedDealerCode.trim().isEmpty) {
      _goToLogin();
      return;
    }

    try {
      setState(() => _loading = true);

      final AuthService service = GetIt.I.get();
      final dealer = await service.getDealerInfo(_storedDealerCode);
      if (!mounted) return;

      if (dealer == null) {
        throw CustomException(message: "Dealer not found");
      }

      setState(() {
        _dealerInfoModel = dealer;
        _loading = false;
      });

      _nameFocusNode.requestFocus();
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return;

      final retry = await showCustomDialogRetry(message: "$error");
      if (retry) {
        _init();
      } else {
        _goToLoginUserList();
      }
    }
  }

  _goToLogin() {
    Navigator.of(context).pushReplacementNamed(ScreenLogin.routeName);
  }

  _goToLoginUserList() {
    Navigator.of(context).pushReplacementNamed(ScreenLoginUserList.routeName);
  }

  _close() {
    if (_validating) return;
    Navigator.of(context).pop();
  }

  _onButtonNextPressed() async {
    CustomKeyboardUtils.hide();

    if (!_formKey.currentState!.validate()) return;

    if (_storedDealerCode.trim().isEmpty || _dealerInfoModel == null) {
      _goToLogin();
      return;
    }

    if (_isSalesAgent) {
      if (!(await _validateUsernameEmail())) return;
    }

    _goToPinPage();
  }

  Future<bool> _validateUsernameEmail() async {
    try {
      setState(() {
        _validating = true;
      });
      final AuthService service = GetIt.I.get();
      await service.validateUsernameEmail(email: _email.text, username: _username.text);
      if (!mounted) return false;

      setState(() {
        _validating = false;
      });
      return true;
    } catch (error) {
      if (!mounted) return false;
      setState(() {
        _validating = false;
      });

      await showCustomDialogRetry(
        message: "$error",
        retryButtonText: "Accept",
        cancelButtonVisible: false,
      );

      return false;
    }
  }

  _goToPinPage() async {
    final phoneNumber = _phoneNumberKey.currentState?.phoneNumber;

    final result = await Navigator.of(context).pushNamed(
      ScreenLoginUserNewPin.routeName,
      arguments: ScreenLoginUserNewPinParams(
        name: _name.text,
        lastName: _lastName.text,
        title: _title.text,
        email: _email.text,
        username: _username.text,
        password: _password.text,
        dealerUuid: _dealerInfoModel?.publicDealerUuid ?? "",
        dealerCode: _storedDealerCode,
        phoneNumber: phoneNumber?.e164 ?? "",
      ),
    );
    if (result == null || result is! CreateUserResult) return;
    if (!mounted) return;
    Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final isRouteTypeCupertinoVertical = widget.params.routeType == CustomRouteType.cupertinoVertical;
    Color appBarFillColor;
    Color appBarIconColor;
    if (isRouteTypeCupertinoVertical) {
      appBarFillColor = Theme.of(context).scaffoldBackgroundColor;
    } else {
      appBarFillColor = Theme.of(context).colorScheme.secondary;
    }
    appBarIconColor = appBarFillColor.contrast(context);

    final buttonClose = CustomButtonIcon(
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      iconColor: appBarIconColor,
      backgroundColor: Colors.transparent,
      onPressed: _close,
    );

    return CustomScaffold(
      appbar: CustomAppBar(
        loading: _validating,
        title: "Create user",
        titleColor: appBarIconColor,
        backgroundColor: appBarFillColor,
        leading: isRouteTypeCupertinoVertical ? null : buttonClose,
        actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
      ),
      onWillPop: _validating ? () async => false : null,
      body: CustomContainer(
        mode: _loading ? CustomContainerMode.loading : CustomContainerMode.normal,
        builder: (context) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        enabled: !_validating,
                        labelText: "Name",
                        controller: _name,
                        focusNode: _nameFocusNode,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [CustomTextInputFormatterWordsCapitalization(), FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                        autocorrect: true,
                        validator: MultiValidator([RequiredValidator(errorText: "Required")]),
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) => _lastNameFocusNode.requestFocus(),
                        maxLength: 40,
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        enabled: !_validating,
                        labelText: "Last Name",
                        controller: _lastName,
                        focusNode: _lastNameFocusNode,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        inputFormatters: [CustomTextInputFormatterWordsCapitalization(), FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                        validator: MultiValidator([RequiredValidator(errorText: "Required")]),
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) => _titleFocusNode.requestFocus(),
                        maxLength: 40,
                      ),
                      const SizedBox(height: 16.0),
                      CustomTextField(
                        enabled: !_validating,
                        labelText: "Job title",
                        controller: _title,
                        focusNode: _titleFocusNode,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.sentences,
                        inputFormatters: [CustomTextInputFormatterCapitalized(), FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                        validator: MultiValidator([RequiredValidator(errorText: "Required")]),
                        textInputAction: _isSalesAgent ? TextInputAction.next : TextInputAction.done,
                        onSubmitted: (v) {
                          if (_isSalesAgent) {
                            _emailFocusNode.requestFocus();
                          } else {
                            CustomKeyboardUtils.hide();
                          }
                        },
                        maxLength: 40,
                      ),
                      if (_isSalesAgent)
                        Column(
                          children: [
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              enabled: !_validating,
                              labelText: "Email",
                              controller: _email,
                              focusNode: _emailFocusNode,
                              keyboardType: TextInputType.emailAddress,
                              inputFormatters: [CustomTextInputFormatterLowercase()],
                              validator: MultiValidator(
                                [
                                  RequiredValidator(errorText: "Required"),
                                  EmailValidator(errorText: "Invalid e-mail"),
                                ],
                              ),
                              textInputAction: TextInputAction.next,
                              onSubmitted: (v) => _userNameFocusNode.requestFocus(),
                              maxLength: 40,
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              enabled: !_validating,
                              labelText: "Username",
                              controller: _username,
                              focusNode: _userNameFocusNode,
                              inputFormatters: [CustomTextInputFormatterLowercase(), FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))],
                              validator: MultiValidator(
                                [
                                  CustomMinLengthValidator(
                                    8,
                                    errorText: "Min 8 characters",
                                    required: false,
                                  ),
                                ],
                              ),
                              textInputAction: TextInputAction.next,
                              onSubmitted: (v) => _passwordFocusNode.requestFocus(),
                              maxLength: 40,
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextField(
                              enabled: !_validating,
                              labelText: "Password",
                              controller: _password,
                              focusNode: _passwordFocusNode,
                              obscureText: !_passwordVisible,
                              suffix: CustomTextFieldIconButton(
                                icon: _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                              ),
                              validator: MultiValidator(
                                [
                                  RequiredValidator(errorText: "Required"),
                                  MinLengthValidator(8, errorText: "Min 8 characters"),
                                ],
                              ),
                              textInputAction: TextInputAction.next,
                              onSubmitted: (v) => _repeatPasswordFocusNode.requestFocus(),
                              maxLength: 40,
                            ),
                            const SizedBox(height: 16.0),
                            ValueListenableBuilder(
                              valueListenable: _insertedPassword,
                              builder: (context, value, child) => CustomTextField(
                                enabled: !_validating,
                                labelText: "Repeat password",
                                controller: _repeatPassword,
                                focusNode: _repeatPasswordFocusNode,
                                obscureText: !_passwordVisible,
                                suffix: CustomTextFieldIconButton(
                                  icon: _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                  onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                                ),
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(errorText: "Required"),
                                    MinLengthValidator(8, errorText: "Min 8 characters"),
                                    RepeatPasswordValidator(
                                      errorText: "The passwords do not match",
                                      password: _insertedPassword.value,
                                    ),
                                  ],
                                ),
                                textInputAction: TextInputAction.next,
                                onSubmitted: (v) => _phoneNumberFocusNode.requestFocus(),
                                maxLength: 40,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            CustomTextFieldPhoneNumber(
                              enabled: !_validating,
                              controller: _phoneNumber,
                              focusNode: _phoneNumberFocusNode,
                              labelText: "Phone number",
                              textInputAction: TextInputAction.done,
                              onSubmitted: (v) => CustomKeyboardUtils.hide(),
                              key: _phoneNumberKey,
                              maxLength: 40,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      navigationBar: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16 + MediaQuery.of(context).viewPadding.bottom),
        child: Row(
          children: [
            Expanded(
              child: CustomBorderButton(
                text: "CANCEL",
                onPressed: _close,
                enabled: !_validating && !_loading,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: CustomGradientButton(
                enabled: !_loading,
                loading: _validating,
                text: "CREATE",
                onPressed: _onButtonNextPressed,
                gradient: CustomColorsUtils.gradient,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
