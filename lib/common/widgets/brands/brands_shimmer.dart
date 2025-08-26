import 'package:flutter/material.dart';
import 'package:flutter_store/common/widgets/shimmer/shimmer.dart';

import '../layouts/grid_layout.dart';

class TBrandsShimmer extends StatelessWidget{
  const TBrandsShimmer({super.key, required this.itemCount});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return TGridLayout(
      itemCount: itemCount,
      mainAxisExtent: 80,
      itemBuilder: (_, index) => const TShimmerEffect(width: 300, height: 80),
    );
  }

}