import 'dart:developer';
import 'dart:io';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/core/router/sheet_container.dart';
import 'package:truvideo_enterprise/model/phone_number.dart';
import 'package:truvideo_enterprise/model/phone_number_country.dart';
import 'package:truvideo_enterprise/service/phone_number/_interface.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';

import 'country_picker_screen.dart';

class CustomTextFieldPhoneNumber extends StatefulWidget {
  final String initialCountry;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String labelText;
  final bool showFormattedNumberInternationally;
  final bool required;
  final TextInputAction? textInputAction;
  final Function(String value)? onSubmitted;
  final bool enabled;
  final EdgeInsets? margin;
  final int? maxLength;

  const CustomTextFieldPhoneNumber({
    Key? key,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.labelText = "",
    this.showFormattedNumberInternationally = false,
    this.required = false,
    this.textInputAction,
    this.onSubmitted,
    this.margin,
    this.initialCountry = "",
    this.maxLength,
  }) : super(key: key);

  @override
  CustomTextFieldPhoneNumberState createState() => CustomTextFieldPhoneNumberState();
}

class CustomTextFieldPhoneNumberState extends State<CustomTextFieldPhoneNumber> {
  final _key = GlobalKey<FormFieldState>();
  late PhoneNumberCountryModel _country;
  late FocusNode _focusNode;
  late TextEditingController _controller;
  PhoneNumberModel? _phoneNumberModel;
  bool? _valid;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    super.initState();

    final PhoneNumberService service = GetIt.I.get();
    if (widget.initialCountry.trim().isEmpty) {
      _country = service.findCurrentCountry();
    } else {
      try {
        _country = service.findCountryByIsoCode(widget.initialCountry);
      } catch (error) {
        _country = service.findCurrentCountry();
      }
    }
    _validate(_controller.text, validate: false);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  PhoneNumberModel? get phoneNumber => _phoneNumberModel;

  setValue(PhoneNumberModel value, {bool validate = false}) {
    setState(() {
      _country = value.country;
    });
    _validate(value.e164, validate: validate);
  }

  _pickCountry() async {
    CustomKeyboardUtils.hide();

    Route route;
    final isIOS = Platform.isIOS;
    if (isIOS) {
      route = CupertinoModalBottomSheetRoute(
        builder: (context) => ScreenCountryPicker(
          params: ScreenCountryPickerParams(
            routeType: CustomRouteType.cupertinoVertical,
          ),
        ),
        containerBuilder: (context, _, child) => CupertinoBottomSheetContainer(child: child),
        expanded: true,
        elevation: 16.0,
        isDismissible: true,
        topRadius: kDefaultTopRadius,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      route = customCupertinoRoute(
        child: ScreenCountryPicker(
          params: ScreenCountryPickerParams(
            routeType: CustomRouteType.cupertino,
          ),
        ),
      );
    }

    final country = await Navigator.of(context).push(route);

    if (country != null) {
      setState(() => _country = country);
      _validate(_controller.text);
    }
  }

  _validate(String value, {bool validate = true}) async {
    final PhoneNumberService service = GetIt.I.get();
    setState(() {
      _valid = null;
      _phoneNumberModel = null;
    });

    if (validate) {
      _key.currentState?.validate();
    }

    if (value.trim().isEmpty) {
      return;
    }

    try {
      final phone = await service.parse(value, isoCode: _country.isoCode);
      if (!mounted) return;

      String text;
      if (widget.showFormattedNumberInternationally) {
        text = phone.formattedInternationalNumber;
      } else {
        text = phone.formattedNationalNumber;
      }

      _controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );

      _country = phone.country;
      setState(() {
        _valid = true;
        _phoneNumberModel = phone;
      });
      if (validate) {
        _key.currentState?.validate();
      }
    } catch (error) {
      if (!mounted) return;
      log("Error", error: error);

      setState(() {
        _valid = false;
        _phoneNumberModel = null;
      });

      if (validate) {
        _key.currentState?.validate();
      }
    }
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    double buttonPadding = (MediaQuery.of(context).size.width / 3);
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: const Color.fromRGBO(210, 212, 217, 1.0),
      nextFocus: false,
      defaultDoneWidget: Container(
        padding: EdgeInsets.only(left: buttonPadding),
        child: const Text("Next"),
      ),
      actions: [
        KeyboardActionsItem(
            focusNode: _focusNode,
            displayArrows: false,
            displayActionBar: Platform.isIOS,
            onTapAction: () {
              if (widget.onSubmitted != null) {
                Future.delayed(const Duration(milliseconds: 0)).then(
                  (value) => widget.onSubmitted!(_controller.text),
                );
              }
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      disableScroll: true,
      child: CustomTextField(
        margin: widget.margin,
        enabled: widget.enabled,
        formFieldKey: _key,
        controller: _controller,
        focusNode: _focusNode,
        labelText: widget.labelText,
        keyboardType: TextInputType.phone,
        onSubmitted: widget.onSubmitted,
        textInputAction: widget.textInputAction,
        maxLength: widget.maxLength,
        prefix: Stack(
          children: [
            Image.asset(
              "assets/images/flags/${(_country.isoCode).toLowerCase()}_flag.png",
              height: 20.0,
              width: 30.0,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 20.0,
                height: 30.0,
                color: Theme.of(context).dividerColor,
              ),
              fit: BoxFit.fitWidth,
            ),
            Positioned.fill(
              child: RawMaterialButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: _pickCountry,
                child: Container(),
              ),
            ),
          ],
        ),
        onChanged: (value) {
          _valid = null;
          _key.currentState?.validate();
          EasyDebounce.debounce(
            "parse",
            const Duration(milliseconds: 300),
            () => _validate(value),
          );
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            if (widget.required) return "Required";
          } else {
            if (_valid == false) return "Invalid phone number";
            return null;
          }
          return null;
        },
      ),
    );
  }
}
