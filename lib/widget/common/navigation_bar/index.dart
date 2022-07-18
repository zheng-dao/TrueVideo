import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:truvideo_enterprise/core/colors.dart';
import 'package:truvideo_enterprise/riverpod/user_settings.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/ripple/index.dart';

class CustomNavigationBar extends HookConsumerWidget {
  final CustomNavigationBarTab? currentTab;
  final Function(CustomNavigationBarTab value)? onPressed;

  const CustomNavigationBar({
    Key? key,
    this.currentTab,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.read(userSettingsPod);
    final appTypeRO = useMemoized(
      () => (userData.firstWhereOrNull((element) => element.key == "appType")?.value ?? "") == "SERVICE",
      [userData],
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Theme.of(context).dividerColor, width: 2)),
          ),
          child: Row(
            children: [
              ...CustomNavigationBarTab.values
                  .map(
                    (e) => Builder(
                      builder: (context) {
                        final selected = currentTab == e;
                        final accent = Theme.of(context).colorScheme.secondary;
                        return Expanded(
                          child: CustomRipple(
                            onPressed: () => onPressed?.call(e),
                            color: accent.withOpacity(selected ? 1.0 : 0.0),
                            child: CustomAnimatedSwitcher(
                              child: Container(
                                key: ValueKey(selected),
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        e.getIcon(appTypeRO),
                                        size: (Theme.of(context).textTheme.bodySmall?.fontSize ?? 14) * 1.8,
                                        color: selected ? accent.contrast(context) : accent,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        e.getName(appTypeRO),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: selected ? accent.contrast(context) : accent),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ],
    );
  }
}

enum CustomNavigationBarTab {
  messages,
  repairOrders,
  gallery,
  customers,
}

extension on CustomNavigationBarTab {
  String getName(bool appTypeRO) {
    switch (this) {
      case CustomNavigationBarTab.messages:
        return "Messages";
      case CustomNavigationBarTab.repairOrders:
        return !appTypeRO ? "Prospects" : "Orders";
      case CustomNavigationBarTab.gallery:
        return "Gallery";
      case CustomNavigationBarTab.customers:
        return "Customers";
    }
  }

  IconData getIcon(bool appTypeRO) {
    switch (this) {
      case CustomNavigationBarTab.messages:
        return Icons.chat_outlined;
      case CustomNavigationBarTab.repairOrders:
        return Icons.file_copy_outlined;

      case CustomNavigationBarTab.gallery:
        return Icons.photo_library_outlined;

      case CustomNavigationBarTab.customers:
        return Icons.person_outline;
    }
  }
}
