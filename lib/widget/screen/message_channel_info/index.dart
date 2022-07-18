import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/model/message_channel.dart';
import 'package:truvideo_enterprise/model/message_member.dart';
import 'package:truvideo_enterprise/riverpod/messaging_authentication_information.dart';
import 'package:truvideo_enterprise/widget/common/animated_collapse_visibility/index.dart';
import 'package:truvideo_enterprise/widget/common/app_bar/index.dart';
import 'package:truvideo_enterprise/widget/common/fading_edge_list/index.dart';
import 'package:truvideo_enterprise/widget/common/button_icon/index.dart';
import 'package:truvideo_enterprise/widget/common/image/index.dart';
import 'package:truvideo_enterprise/widget/common/image/model/placeholder.dart';
import 'package:truvideo_enterprise/widget/common/list/list.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/image.dart';
import 'package:truvideo_enterprise/widget/common/list_tile/index.dart';
import 'package:truvideo_enterprise/widget/common/scaffold/index.dart';

class ScreenMessageChannelInfoParams {
  final MessageChannelModel model;

  ScreenMessageChannelInfoParams({
    required this.model,
  });
}

class ScreenMessageChannelInfo extends StatefulHookConsumerWidget {
  static const String routeName = "/ScreenMessageChannelInfo";

  const ScreenMessageChannelInfo({Key? key}) : super(key: key);

  @override
  ConsumerState<ScreenMessageChannelInfo> createState() => _ScreenMessageChannelInfoState();
}

class _ScreenMessageChannelInfoState extends ConsumerState<ScreenMessageChannelInfo> {
  ScreenMessageChannelInfoParams? _params;

  _close() {
    Navigator.of(context).pop();
  }

  IconData? get _icon {
    if (_params?.model == null) return null;

    if (_isGroup) {
      return Icons.people_outline;
    }

    return Icons.person_outline;
  }

  String get _title {
    final auth = ref.read(messagingAuthenticationInformationPod);
    return _params?.model.getName(
          accountUID: auth?.subAccountMessageableEntity?.uid ?? "",
          subjectUID: auth?.subjectMessageableEntity?.uid ?? "",
        ) ??
        "";
  }

  bool get _isGroup {
    if (_params?.model == null) return false;
    return _params!.model.type == "GROUP";
  }

  bool get _isByAccount {
    final auth = ref.read(messagingAuthenticationInformationPod);
    if (auth == null || _params?.model == null) return false;

    final members = _params!.model.members;
    return !members.any((e) => e.uid == auth.subjectMessageableEntity?.uid);
  }

  bool _isYourself(MessageMemberModel member) {
    final auth = ref.read(messagingAuthenticationInformationPod);

    if (_isByAccount) {
      return member.uid == auth?.subAccountMessageableEntity?.uid;
    } else {
      return member.uid == auth?.subjectMessageableEntity?.uid;
    }
  }

  @override
  Widget build(BuildContext context) {
    _params = ModalRoute.of(context)?.settings.arguments as ScreenMessageChannelInfoParams?;
    final appBarIconColor = Theme.of(context).colorScheme.secondary;

    final members = useMemoized(
      () {
        final r = List<MessageMemberModel>.from(_params?.model.members ?? <MessageMemberModel>[]);
        r.sort((a, b) => a.displayName.trim().toUpperCase().compareTo(b.displayName.trim().toUpperCase()));
        return r;
      },
      [_params?.model.members],
    );

    return CustomScaffold(
      appbar: CustomAppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        leading: CustomButtonIcon(
          icon: Icons.arrow_back_ios,
          iconColor: appBarIconColor,
          onPressed: _close,
          elevation: 0,
          focusedElevation: 0,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: CustomFadingEdgeList(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 128,
                    height: 128,
                    child: CustomImage(
                      placeholder: CustomImagePlaceholder(
                        color: Theme.of(context).dividerColor,
                        icon: _icon,
                        iconColor: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                        iconSize: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                CustomAnimatedCollapseVisibility(
                  visible: _title.trim().isNotEmpty,
                  child: Center(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _title,
                        key: ValueKey(_title),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ),
                if (_params?.model != null && _isGroup)
                  Text(
                    "Group - ${_params?.model.members.length ?? 0} participants",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.secondary),
                  ),
                const SizedBox(height: 32.0),
                if (_isGroup)
                  CustomList<MessageMemberModel>.separated(
                    areItemsTheSame: (a, b) => a.uid == b.uid,
                    shrinkWrap: true,
                    scrollPhysics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, item) => CustomListTile(
                      titleText: item.displayName,
                      subtitleText: _isYourself(item) ? "Yourself" : "",
                      leading: const CustomListTileImage(
                        icon: Icons.person_outline,
                      ),
                    ),
                    data: members,
                  ),
                SizedBox(height: MediaQuery.of(context).padding.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
