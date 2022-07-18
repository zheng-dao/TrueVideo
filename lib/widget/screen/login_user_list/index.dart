import 'dart:developer';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/core/keyboard.dart';
import 'package:truvideo_enterprise/model/dealer_info.dart';
import 'package:truvideo_enterprise/model/user_login.dart';
import 'package:truvideo_enterprise/service/auth/_interface.dart';
import 'package:truvideo_enterprise/widget/common/animated_fade_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/dialog/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/list/divider.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_empty.dart';
import 'package:truvideo_enterprise/widget/common/list/indicator_error.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/popup/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';
import 'package:truvideo_enterprise/widget/common/text_field/icon.dart';
import 'package:truvideo_enterprise/widget/common/text_field/index.dart';
import 'package:truvideo_enterprise/widget/mixin/back_button_exit.dart';
import 'package:truvideo_enterprise/widget/screen/login/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_pin/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_list/list_item.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_new/index.dart';
import 'package:truvideo_enterprise/widget/screen/login_user_new/model/result.dart';

import 'shimmer_list.dart';

class ScreenLoginUserList extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenLoginUserList";

  const ScreenLoginUserList({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenLoginUserList> createState() => _ScreenLoginUserListState();
}

class _ScreenLoginUserListState extends ConsumerState<ScreenLoginUserList> with BackButtonExitMixin {
  AuthService get _authService => GetIt.I.get();

  CancelableOperation? _cancelableOperation;
  DealerInfoModel? _dealer;
  var _usersRecent = <UserLoginModel>[];
  var _usersRest = <UserLoginModel>[];
  bool _loading = true;
  dynamic _error;

  final _textSearch = TextEditingController();
  final _filter = ValueNotifier("");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _init());

    _textSearch.addListener(() {
      _filter.value = _textSearch.text;
    });
  }

  @override
  void dispose() {
    _cancelableOperation?.cancel();
    _textSearch.dispose();
    super.dispose();
  }

  String get _storedDealerCode {
    final AuthService service = GetIt.I.get();
    return service.getStoredDealerCode();
  }

  Future<bool> _init() async {
    _cancelableOperation?.cancel();

    if (_storedDealerCode.trim().isEmpty) {
      _goToLogin();
      return false;
    }

    try {
      setState(() {
        _loading = true;
        _error = null;
      });

      _cancelableOperation = CancelableOperation.fromFuture(_authService.getDealerInfo(_storedDealerCode));
      DealerInfoModel? dealer = await _cancelableOperation!.value;
      if (!mounted) return false;

      if (dealer == null) {
        await showCustomDialogRetry(
          title: "Error",
          message: "Dealer not found",
          cancelButtonVisible: false,
          retryButtonText: "Accept",
        );
        _goToLogin();
        return false;
      }

      _cancelableOperation = CancelableOperation.fromFuture(_authService.getUsersForDealerCode(_storedDealerCode));
      final List<UserLoginModel> users = await _cancelableOperation!.value;
      if (!mounted) return false;

      final recent = <UserLoginModel>[];
      final rest = <UserLoginModel>[];

      for (var user in users) {
        final date = _authService.getLastAccessDate(user.publicUserUuid);
        if (date != null) {
          recent.add(user);
        }

        rest.add(user);
      }

      setState(() {
        _loading = false;
        _dealer = dealer;
        _usersRecent = recent;
        _usersRest = rest;
      });

      return true;
    } catch (error, stack) {
      log("Error", error: error, stackTrace: stack);
      if (!mounted) return false;

      _cancelableOperation?.cancel();

      setState(() {
        _error = error;
        _loading = false;
      });
      return false;
    }
  }

  _onUserPressed(UserLoginModel model) {
    Navigator.of(context).pushNamed(
      ScreenLoginUserPin.routeName,
      arguments: ScreenLoginUserPinParams(
        userUuid: model.publicUserUuid,
        displayName: model.completeName,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (_loading) return false;
    return onButtonBackPressed();
  }

  _goToCreateUser() async {
    final result = await Navigator.of(context).pushNamed(
      ScreenLoginUserNew.routeName,
      arguments: ScreenLoginUserNewParams(),
    );

    if (result == null || result is! CreateUserResult) return;

    final successRetry = await _init();
    if (!successRetry) return;

    if (!mounted) return;
    Navigator.of(context).pushNamed(
      ScreenLoginUserPin.routeName,
      arguments: ScreenLoginUserPinParams(
        userUuid: result.uuid,
        displayName: result.displayName,
        pin: result.pin,
      ),
    );
  }

  _goToLogin() {
    Navigator.of(context).pushReplacementNamed(ScreenLogin.routeName);
  }

  _onMenuPressed() {
    showCustomPopup(
      right: 0,
      top: 0,
      builder: (context, controller) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomListTile(
            titleText: "Refresh",
            dense: true,
            onPressed: () async {
              await controller.close();
              _init();
            },
          ),
          const CustomDivider(),
          CustomListTile(
            titleText: "Change dealer",
            dense: true,
            onPressed: () async {
              await controller.close();
              _goToLogin();
            },
          ),
          const CustomDivider(),
          CustomListTile(
            titleText: "Create user",
            dense: true,
            onPressed: () async {
              await controller.close();
              _goToCreateUser();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = useValueListenable(_filter);
    final filteredRecent = useMemoized(
      () {
        return _usersRecent.where((element) {
          final f = filter.trim().toUpperCase();
          final name = element.completeName.toUpperCase().trim();
          return name.contains(f);
        }).toList();
      },
      [_usersRecent, filter],
    );

    final filteredRest = useMemoized(
      () {
        return _usersRest.where((element) {
          final f = filter.trim().toUpperCase();
          final name = element.completeName.toUpperCase().trim();
          return name.contains(f);
        }).toList();
      },
      [_usersRest, filter],
    );

    var items = useMemoized<List<UserLoginModel>>(
      () {
        final result = <UserLoginModel>[];
        if (filteredRecent.isNotEmpty && filteredRest.isNotEmpty) {
          result.add(const UserLoginModel(publicUserUuid: "title_recent_users"));
        }

        if (filteredRecent.isNotEmpty) {
          result.addAll(filteredRecent);
        }

        if (filteredRecent.isNotEmpty && filteredRest.isNotEmpty) {
          result.add(const UserLoginModel(publicUserUuid: "title_all_users"));
        }

        if (filteredRest.isNotEmpty) {
          result.addAll(filteredRest);
        }

        return result;
      },
      [filteredRecent, filteredRest],
    );

    return CustomScaffold(
      onWillPop: _onWillPop,
      appbar: CustomAppBar(
        title: _dealer?.name ?? "",
        actionButtons: [
          CustomButtonIcon(
            icon: Icons.refresh,
            onPressed: _init,
            enabled: !_loading,
            backgroundColor: Colors.transparent,
            iconColor: Theme.of(context).appBarTheme.backgroundColor!.contrast(context),
          ),
          CustomButtonIcon(
            enabled: !_loading,
            icon: Icons.more_vert_outlined,
            backgroundColor: Colors.transparent,
            iconColor: Theme.of(context).appBarTheme.backgroundColor!.contrast(context),
            onPressed: _onMenuPressed,
          ),
        ],
      ),
      body: CustomList<UserLoginModel>.separated(
        areItemsTheSame: (a, b) => a.publicUserUuid == b.publicUserUuid,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        loading: _loading,
        loadingBuilder: (context) => const ScreenLoginUserListShimmerList(),
        headerVisibility: (status) {
          switch (status) {
            case CustomListStatus.loading:
              return false;
            case CustomListStatus.error:
              return false;
            case CustomListStatus.empty:
              return filter.trim().isNotEmpty;
            case CustomListStatus.data:
              return true;
          }
        },
        data: items,
        error: _error,
        listWrapper: (context, child) => CustomFadingEdgeList(child: child),
        itemBuilder: (context, item) {
          if (item.publicUserUuid == "title_recent_users") {
            return const CustomListTile(titleText: "Recent users");
          }

          if (item.publicUserUuid == "title_all_users") {
            return const CustomListTile(titleText: "All users");
          }

          return ScreenLoginUserListItem(
            model: item,
            showLastDate: true,
            onPressed: _onUserPressed,
            dealerUuid: _dealer?.publicDealerUuid ?? "",
          );
        },
        emptyBuilder: (context) => CustomListIndicatorEmpty(
          title: "NO USERS FOUND",
          message: filter.trim().isNotEmpty ? "Try another filter" : "",
        ),
        errorBuilder: (context, error) => CustomListIndicatorError(onButtonPressed: _init),
        header: CustomTextField(
          enabled: !_loading,
          margin: const EdgeInsets.all(16.0),
          controller: _textSearch,
          hintText: "Search...",
          prefix: const CustomTextFieldIconButton(icon: Icons.search),
          textInputAction: TextInputAction.search,
          suffixBuilder: (c, value) => CustomAnimatedFadeVisibility(
            visible: value.isNotEmpty,
            child: CustomTextFieldIconButton(
              icon: Icons.clear,
              onPressed: () {
                _textSearch.text = "";
                CustomKeyboardUtils.hide();
              },
            ),
          ),
        ),
      ),
    );
  }
}
