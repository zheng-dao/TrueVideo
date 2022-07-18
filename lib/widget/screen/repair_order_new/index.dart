import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/exception.dart';
import 'package:truvideo_enterprise/core/formatter/word_capitalization.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/model/tce_user.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/service/phone_number/_interface.dart';
import 'package:truvideo_enterprise/service/repair_order/_interface.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/button_border/index.dart';
import 'package:truvideo_enterprise/widget/common/button_gradient/index.dart';
import 'package:truvideo_enterprise/widget/common/container/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_loading.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/snackbar/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field_phone_number/index.dart';
import 'package:truvideo_enterprise/widget/screen/advisor_picker/index.dart';
import 'package:truvideo_enterprise/widget/screen/repair_order_new/job_service_number.dart';

class ScreenRepairOrderNewParams {
  final int? id;
  final Function()? onUpdated;
  CustomRouteType? routeType;

  ScreenRepairOrderNewParams({
    this.id,
    this.onUpdated,
    this.routeType,
  });
}

class ScreenRepairOrderNew extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenRepairOrderNew";
  final ScreenRepairOrderNewParams params;

  const ScreenRepairOrderNew({
    Key? key,
    required this.params,
  }) : super(key: key);

  @override
  ConsumerState<ScreenRepairOrderNew> createState() => _ScreenRepairOrderNewState();
}

class _ScreenRepairOrderNewState extends ConsumerState<ScreenRepairOrderNew> {
  bool _loading = true;
  bool _saving = false;
  dynamic _error;

  bool? _isRepairOrder;
  bool _isEdit = false;

  final _keyForm = GlobalKey<FormState>();
  final _keyPhoneNumber = GlobalKey<CustomTextFieldPhoneNumberState>();

  final _controllerRepairOrderNumber = TextEditingController();
  final _focusNodeRepairOrderNumber = FocusNode();

  final _controllerAdvisor = TextEditingController();
  final _focusNodeAdvisor = FocusNode();

  final _controllerFirstName = TextEditingController();
  final _focusNodeFirstName = FocusNode();

  final _controllerLastName = TextEditingController();
  final _focusNodeLastName = FocusNode();

  String _initialCountry = "";
  final _controllerMobile = TextEditingController();
  final _focusNodeMobile = FocusNode();

  final _controllerEmail = TextEditingController();
  final _focusNodeEmail = FocusNode();

  final _controllerStockNo = TextEditingController();
  final _focusNodeStockNo = FocusNode();

  final _controllerVehicleMake = TextEditingController();
  final _focusNodeVehicleMake = FocusNode();

  final _controllerVehicleModel = TextEditingController();
  final _focusNodeVehicleModel = FocusNode();

  final _controllerVehicleYear = TextEditingController();
  final _focusNodeVehicleYear = FocusNode();

  final _controllerVehicleColor = TextEditingController();
  final _focusNodeVehicleColor = FocusNode();

  final _controllerSalesAgent = TextEditingController();
  final _focusNodeSalesAgent = FocusNode();

  int? _advisorId;
  bool _isForReview = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());
  }

  @override
  void dispose() {
    _controllerRepairOrderNumber.dispose();
    _focusNodeRepairOrderNumber.dispose();

    _controllerAdvisor.dispose();
    _focusNodeAdvisor.dispose();

    _controllerFirstName.dispose();
    _focusNodeFirstName.dispose();

    _controllerLastName.dispose();
    _focusNodeLastName.dispose();

    _controllerMobile.dispose();
    _focusNodeMobile.dispose();

    _controllerEmail.dispose();
    _focusNodeEmail.dispose();

    _controllerStockNo.dispose();
    _focusNodeStockNo.dispose();

    _controllerVehicleMake.dispose();
    _focusNodeVehicleMake.dispose();

    _controllerVehicleModel.dispose();
    _focusNodeVehicleModel.dispose();

    _controllerVehicleYear.dispose();
    _focusNodeVehicleYear.dispose();

    _controllerVehicleColor.dispose();
    _focusNodeVehicleColor.dispose();

    _controllerSalesAgent.dispose();
    _focusNodeSalesAgent.dispose();

    super.dispose();
  }

  _init() {
    final isEdit = widget.params.id != null;
    setState(() => _isEdit = isEdit);

    if (isEdit) {
      _fetch();
    } else {
      setState(() {
        _loading = false;
        _isRepairOrder = ref.read(userSettingsPod).isAppTypeRepairOrder;
      });
    }
  }

  _fetch() async {
    try {
      setState(() {
        _loading = true;
      });

      final RepairOrderService orderService = GetIt.I.get();
      final model = await orderService.getDetail(widget.params.id ?? 0);
      if (model == null) {
        throw CustomException(
          message: "Not found",
        );
      }

      if (!mounted) return;

      if (model.isRepairOrder) {
        // Number
        _controllerRepairOrderNumber.text = model.jobServiceNumber;

        // Advisor
        _advisorId = model.owner?.id;
        _controllerAdvisor.text = model.owner?.displayName ?? "";
      }

      // First name
      _controllerFirstName.text = model.customer?.firstName ?? "";

      // Last name
      _controllerLastName.text = model.customer?.lastName ?? "";

      // Phone
      try {
        final PhoneNumberService phoneNumberService = GetIt.I.get();
        final parsedPhone = await phoneNumberService.parse(model.customer?.mobileNumber ?? "");
        setState(() => _initialCountry = parsedPhone.country.isoCode);
        _controllerMobile.text = parsedPhone.number;
      } catch (error) {
        _controllerMobile.text = model.customer?.mobileNumber ?? "";
        setState(() => _initialCountry = "");
      }

      // Email
      _controllerEmail.text = model.customer?.email ?? "";

      if (model.isSalesOrder) {
        // Stock No
        _controllerStockNo.text = model.vehicle?.stockNo ?? "";

        // Vehicle Year
        _controllerVehicleYear.text = model.vehicle?.year ?? "";

        // Vehicle Color
        _controllerVehicleColor.text = model.vehicle?.color ?? "";

        // Vehicle Make
        _controllerVehicleMake.text = model.vehicle?.make ?? "";

        // Vehicle Model
        _controllerVehicleModel.text = model.vehicle?.model ?? "";
      }

      // For review
      if (model.isRepairOrder) {
        _isForReview = model.isForReview;
      }

      setState(() {
        _isRepairOrder = model.isRepairOrder;
        _loading = false;
      });
    } catch (error, stack) {
      log("Error fetching", error: error, stackTrace: stack);
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error;
      });
    }
  }

  _close() {
    if (_saving) return;
    Navigator.of(context).pop();
  }

  _pickAdvisor() async {
    final advisor = await Navigator.of(context).pushNamed(
      ScreenAdvisorPicker.routeName,
      arguments: ScreenAdvisorPickerParams(),
    );

    if (advisor == null || advisor is! TCEUserModel) return;

    _advisorId = advisor.id;
    _controllerAdvisor.text = advisor.displayName;
  }

  _onSendVideoToCustomersPressed() {
    setState(() {
      _isForReview = !_isForReview;
    });
  }

  _onSavePressed() async {
    if (!_keyForm.currentState!.validate()) return;

    try {
      setState(() {
        _saving = true;
      });

      final RepairOrderService repairOrderService = GetIt.I.get();

      int? id;
      if (_isEdit) {
        await repairOrderService.update(
          id: widget.params.id ?? 0,
          jobServiceNumber: _controllerRepairOrderNumber.text,
          advisorId: _advisorId,
          firstName: _controllerFirstName.text,
          lastName: _controllerLastName.text,
          mobileNumber: _keyPhoneNumber.currentState?.phoneNumber?.e164 ?? "",
          email: _controllerEmail.text,
          orderType: _isRepairOrder == true ? "REPAIR_ORDER" : "SALES_ORDER",
          isForReview: _isForReview,
          stockNo: _controllerStockNo.text,
          make: _controllerVehicleMake.text,
          model: _controllerVehicleModel.text,
          year: _controllerVehicleYear.text,
          color: _controllerVehicleColor.text,
        );
      } else {
        id = await repairOrderService.create(
          jobServiceNumber: _controllerRepairOrderNumber.text,
          advisorId: _advisorId,
          firstName: _controllerFirstName.text,
          lastName: _controllerLastName.text,
          mobileNumber: _keyPhoneNumber.currentState?.phoneNumber?.e164 ?? "",
          email: _controllerEmail.text,
          orderType: _isRepairOrder == true ? "REPAIR_ORDER" : "SALES_ORDER",
          isForReview: _isForReview,
          stockNo: _controllerStockNo.text,
          make: _controllerVehicleMake.text,
          model: _controllerVehicleModel.text,
          year: _controllerVehicleYear.text,
          color: _controllerVehicleColor.text,
        );
      }

      widget.params.onUpdated?.call();

      String snackBarMessage;
      if (_isEdit) {
        if (_isRepairOrder == true) {
          snackBarMessage = "Repair Order modified successfully";
        } else {
          snackBarMessage = "Prospect modified successfully";
        }
      } else {
        if (_isRepairOrder == true) {
          snackBarMessage = "Repair Order added successfully";
        } else {
          snackBarMessage = "Prospect added successfully";
        }
      }

      showCustomSnackBarSuccess(title: snackBarMessage);

      if (!mounted) return;

      if (!_isEdit) {
        Navigator.of(context).pop(id);
        return;
      }

      Navigator.of(context).pop(true);
    } catch (error, stack) {
      log("Error saving", error: error, stackTrace: stack);
      if (!mounted) return;

      final retry = await showCustomDialogRetry(error: error);
      if (retry) {
        _onSavePressed();
      } else {
        setState(() {
          _saving = false;
        });
      }
    }
  }

  String get _title {
    if (_isRepairOrder == null) return "";
    if (_isRepairOrder!) {
      if (_isEdit) {
        return "Edit Repair Order";
      } else {
        return "Add Repair Order";
      }
    } else {
      if (_isEdit) {
        return "Edit Prospect";
      } else {
        return "Add Prospect";
      }
    }
  }

  ScrollPhysics get _scrollPhysics {
    if (_saving) return const NeverScrollableScrollPhysics();
    return const BouncingScrollPhysics();
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
      enabled: !_saving,
      icon: isRouteTypeCupertinoVertical ? Icons.clear : Icons.arrow_back_ios,
      iconColor: appBarIconColor,
      backgroundColor: Colors.transparent,
      onPressed: _close,
    );

    return CustomScaffold(
      onWillPop: _saving ? () async => false : null,
      appbar: CustomAppBar(
        backgroundColor: appBarFillColor,
        leading: !isRouteTypeCupertinoVertical ? buttonClose : null,
        actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
        title: _title,
        titleColor: appBarIconColor,
      ),
      body: CustomContainer(
        mode: _loading ? CustomContainerMode.loading : (_error != null ? CustomContainerMode.error : CustomContainerMode.normal),
        errorData: _error,
        loadingBuilder: (context) => const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CustomListIndicatorLoading(),
          ),
        ),
        errorBuilder: (context, error) => const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CustomListIndicatorError(),
          ),
        ),
        builder: (context) => SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CustomFadingEdgeList(
            child: SingleChildScrollView(
              physics: _scrollPhysics,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    if (_isRepairOrder == true)
                      CustomJobServiceNumberTextField(
                        margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                        enabled: !_saving && !_isEdit,
                        focusNode: _focusNodeRepairOrderNumber,
                        controller: _controllerRepairOrderNumber,
                        required: true,
                        onSubmitted: (v) => _focusNodeAdvisor.requestFocus(),
                      ),
                    if (_isRepairOrder == true)
                      CustomTextField(
                        margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                        enabled: !_saving,
                        labelText: "Advisor",
                        onPressed: _pickAdvisor,
                        focusNode: _focusNodeAdvisor,
                        controller: _controllerAdvisor,
                        textInputAction: TextInputAction.next,
                        suffix: const CustomTextFieldIconButton(icon: Icons.chevron_right),
                        validator: MultiValidator([RequiredValidator(errorText: "Required")]),
                        onSubmitted: (v) => _focusNodeFirstName.requestFocus(),
                      ),
                    CustomTextField(
                      margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                      enabled: !_saving,
                      focusNode: _focusNodeFirstName,
                      controller: _controllerFirstName,
                      labelText: "First Name",
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      maxLength: 40,
                      textCapitalization: TextCapitalization.words,
                      validator: MultiValidator(
                        [
                          if (_isRepairOrder == false) RequiredValidator(errorText: "Required"),
                        ],
                      ),
                      inputFormatters: [CustomTextInputFormatterWordsCapitalization()],
                      onSubmitted: (v) => _focusNodeLastName.requestFocus(),
                    ),
                    CustomTextField(
                      margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                      enabled: !_saving,
                      focusNode: _focusNodeLastName,
                      controller: _controllerLastName,
                      labelText: "Last Name",
                      maxLength: 40,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [CustomTextInputFormatterWordsCapitalization()],
                      validator: MultiValidator(
                        [
                          if (_isRepairOrder == false) RequiredValidator(errorText: "Required"),
                        ],
                      ),
                      onSubmitted: (v) => _focusNodeMobile.requestFocus(),
                    ),
                    CustomTextFieldPhoneNumber(
                      key: _keyPhoneNumber,
                      margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                      enabled: !_saving,
                      focusNode: _focusNodeMobile,
                      controller: _controllerMobile,
                      initialCountry: _initialCountry,
                      labelText: "Mobile",
                      required: _isRepairOrder == false,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (v) {
                        _focusNodeEmail.requestFocus();
                      },
                      maxLength: 40,
                    ),
                    CustomTextField(
                      margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                      enabled: !_saving,
                      focusNode: _focusNodeEmail,
                      controller: _controllerEmail,
                      labelText: "E-Mail",
                      maxLength: 60,
                      keyboardType: TextInputType.emailAddress,
                      validator: MultiValidator([EmailValidator(errorText: "Invalid-email")]),
                      textInputAction: TextInputAction.next,
                      onSubmitted: (v) => _isRepairOrder! ? CustomKeyboardUtils.hide() : _focusNodeStockNo.requestFocus(),
                    ),
                    if (_isRepairOrder == false)
                      CustomTextField(
                        margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                        enabled: !_saving,
                        focusNode: _focusNodeStockNo,
                        controller: _controllerStockNo,
                        labelText: "Stock No.",
                        maxLength: 40,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) => _focusNodeVehicleYear.requestFocus(),
                      ),
                    if (_isRepairOrder == false)
                      CustomTextField(
                        margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                        enabled: !_saving,
                        focusNode: _focusNodeVehicleYear,
                        controller: _controllerVehicleYear,
                        labelText: "Year",
                        maxLength: 20,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) => _focusNodeVehicleColor.requestFocus(),
                      ),
                    if (_isRepairOrder == false)
                      CustomTextField(
                        margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                        enabled: !_saving,
                        focusNode: _focusNodeVehicleColor,
                        controller: _controllerVehicleColor,
                        labelText: "Color",
                        maxLength: 40,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) => _focusNodeVehicleMake.requestFocus(),
                      ),
                    if (_isRepairOrder == false)
                      CustomTextField(
                        margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                        enabled: !_saving,
                        focusNode: _focusNodeVehicleMake,
                        controller: _controllerVehicleMake,
                        labelText: "Make",
                        maxLength: 40,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) => _focusNodeVehicleModel.requestFocus(),
                      ),
                    if (_isRepairOrder == false)
                      CustomTextField(
                        margin: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                        enabled: !_saving,
                        focusNode: _focusNodeVehicleModel,
                        controller: _controllerVehicleModel,
                        labelText: "Model",
                        maxLength: 40,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (v) => CustomKeyboardUtils.hide(),
                      ),
                    if (_isRepairOrder == true)
                      CustomListTile(
                        dense: true,
                        enabled: !_saving,
                        onPressed: _onSendVideoToCustomersPressed,
                        leading: CustomListTileImage(
                          icon: !_isForReview ? Icons.check_box : Icons.square_outlined,
                          color: Colors.transparent,
                        ),
                        titleText: "Do not send videos directly to customers",
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      navigationBar: Container(
        padding: const EdgeInsets.all(16.0).copyWith(bottom: 16.0 + MediaQuery.of(context).viewPadding.bottom),
        child: Row(
          children: [
            Expanded(
              child: CustomBorderButton(
                enabled: !_saving && !_loading,
                width: double.infinity,
                text: "Cancel",
                onPressed: _close,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: CustomGradientButton(
                enabled: !_loading,
                loading: _saving,
                width: double.infinity,
                text: _isEdit ? "SAVE CHANGES" : "CREATE",
                gradient: CustomColorsUtils.gradient,
                onPressed: _onSavePressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
