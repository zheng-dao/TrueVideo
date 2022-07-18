import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/core/router/router.dart';
import 'package:truvideo_enterprise/model/phone_number_country.dart';
import 'package:truvideo_enterprise/service/phone_number/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/data.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';

class ScreenCountryPickerParams {
  CustomRouteType? routeType;

  ScreenCountryPickerParams({this.routeType});
}

class ScreenCountryPicker extends StatefulHookConsumerWidget {
  final ScreenCountryPickerParams params;

  const ScreenCountryPicker({Key? key, required this.params}) : super(key: key);

  @override
  ConsumerState<ScreenCountryPicker> createState() => _ScreenCountryPickerState();
}

class _ScreenCountryPickerState extends ConsumerState<ScreenCountryPicker> {
  var _data = <PhoneNumberCountryModel>[];
  final _filterController = TextEditingController();
  final _filter = ValueNotifier("");

  @override
  void initState() {
    final PhoneNumberService service = GetIt.I.get();
    _filterController.addListener(() {
      _filter.value = _filterController.text;
    });
    _data = service.getAllCountries();
    super.initState();
  }

  @override
  void dispose() {
    _filterController.dispose();
    super.dispose();
  }

  _close() {
    Navigator.of(context).pop();
  }

  _onItemPressed(PhoneNumberCountryModel model) {
    Navigator.of(context).pop(model);
  }

  @override
  Widget build(BuildContext context) {
    final filter = useValueListenable(_filter);
    final filteredItems = useMemoized(
      () {
        return _data.where((e) => e.name.toUpperCase().contains(filter.trim().toUpperCase())).toList();
      },
      [_data, filter],
    );

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
        title: "Pick a country",
        backgroundColor: appBarFillColor,
        titleColor: appBarIconColor,
        leading: !isRouteTypeCupertinoVertical ? buttonClose : null,
        actionButtons: isRouteTypeCupertinoVertical ? [buttonClose] : [],
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: _filterController,
            margin: const EdgeInsets.all(16.0),
            hintText: "Search",
            prefix: const CustomTextFieldIconButton(icon: Icons.search),
            suffixBuilder: (c, value) => CustomAnimatedFadeVisibility(
              visible: value.isNotEmpty,
              child: CustomTextFieldIconButton(
                icon: Icons.clear,
                onPressed: () {
                  _filterController.text = "";
                  CustomKeyboardUtils.hide();
                },
              ),
            ),
          ),
          Expanded(
            child: CustomFadingEdgeList(
              child: CustomList<PhoneNumberCountryModel>.separated(
                controller: ModalScrollController.of(context),
                data: filteredItems,
                areItemsTheSame: (a, b) => a.isoCode == b.isoCode,
                padding: EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0 + MediaQuery.of(context).viewPadding.bottom,
                ),
                itemBuilder: (context, item) => CustomListTile(
                  key: ValueKey(item.isoCode),
                  titleText: item.name,
                  onPressed: () => _onItemPressed(item),
                  leading: CustomListTileImage(
                    circle: false,
                    color: Colors.transparent,
                    source: CustomImageDataSource.asset(
                      "assets/images/flags/${(item.isoCode).toLowerCase()}_flag.png",
                      fit: BoxFit.cover,
                      color: Colors.transparent,
                    ),
                  ),
                  trailingText: item.countryCode,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
