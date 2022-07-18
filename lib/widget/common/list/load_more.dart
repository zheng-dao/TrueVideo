import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/animated_switcher/index.dart';
import 'package:truvideo_enterprise/widget/common/list/shimmer_list.dart';

class CustomListLoadMore extends StatelessWidget {
  final dynamic error;
  final Function()? onRetryPressed;
  final Widget Function(BuildContext context, int index)? shimmerItemBuilder;

  const CustomListLoadMore({Key? key, this.error, this.onRetryPressed, this.shimmerItemBuilder}) : super(key: key);

  Widget get _loading {
    return Container(
      key: const ValueKey("loading"),
      child: CustomShimmerList(
        length: 3,
        itemBuilder: shimmerItemBuilder,
        shrinkWrap: true,
      ),
    );
  }

  Widget get _message {
    return const SizedBox(
      height: 40.0,
      key: ValueKey("message"),
      child: Center(
        child: Center(
          child: Text(
            "Error loading more items",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (error != null) {
          onRetryPressed?.call();
        }
      },
      child: CustomAnimatedSwitcher(
        alignment: Alignment.topCenter,
        child: error != null ? _message : _loading,
      ),
    );
  }
}
