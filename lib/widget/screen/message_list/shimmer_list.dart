import 'package:flutter/material.dart';
import 'package:truvideo_enterprise/widget/common/list/shimmer_list.dart';


class ScreenMessageListShimmerList extends StatelessWidget {
  const ScreenMessageListShimmerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final meIndexes = [1,2,5,6,8,9];
    
    return CustomShimmerList(
      baseColor: Colors.white,
      highlightColor: Theme.of(context).dividerColor,
      reverse: true,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      length: 10,
      separatorBuilder: (c) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: const Divider(height: 1),
      ),
      itemBuilder: (context, index) {
        bool isMe = meIndexes.contains(index);
        return Container(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 4.0, bottom: 4.0),
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isMe)
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  margin: const EdgeInsets.only(right: 8.0),
                ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    constraints: const BoxConstraints(minWidth: 150),
                    child: Column(
                      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "lkasjdkl asjdlkla sdj",
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: isMe ? TextAlign.right : TextAlign.left,
                        ),
                        // _buildDate(
                        //   context,
                        //   color: color,
                        //   dateService: dateService,
                        //   isMe: isMe,
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
