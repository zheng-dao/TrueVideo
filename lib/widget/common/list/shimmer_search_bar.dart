import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerSearchBar extends StatelessWidget {
  const CustomShimmerSearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Shimmer.fromColors(
        highlightColor: Colors.white,
        baseColor: Theme.of(context).dividerColor,
        child: Container(
          height: 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(width: 1, color: Colors.white),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Container(
                width: 150,
                margin: const EdgeInsets.only(left: 16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Text("Search...."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
