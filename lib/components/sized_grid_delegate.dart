import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sized_list_view/flutter_sized_list_view.dart';

class SizedGridDelegate extends SliverGridDelegate {
  SizedGridDelegate({
    required this.sizeBuilder,
    required this.itemCount,
    this.alwaysRelayout = true,
  });

  final IndexedSizeBuilder sizeBuilder;
  final int itemCount;

  /// Whether the [GridView] or [SizedListView] will always
  /// go through the layout phase when the state updates.
  final bool alwaysRelayout;

  /// The instance that defines cached sizes of all items.
  SizedGridLayout? _cachedLayout;

  /// The instance that defines a previous constraints in [getLayout].
  SliverConstraints? _oldConstraints;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double newMainAxisExtent = constraints.viewportMainAxisExtent;
    final double oldCrossAxisExtent = _oldConstraints?.crossAxisExtent ?? 0.0;
    final double newCrossAxisExtent = constraints.crossAxisExtent;

    // An unnecessary prevention of calculations.
    if (newMainAxisExtent == 0.0
     || newCrossAxisExtent == 0.0) {
      return SizedGridLayout(sizes: []);
    }

    if (oldCrossAxisExtent != newCrossAxisExtent) {
      _cachedLayout = null;
      _oldConstraints = constraints;
    }

    return _cachedLayout ??= SizedGridLayout(
      sizes: List.generate(itemCount, (index) => sizeBuilder(constraints, index))
    );
  }

  @override
  bool shouldRelayout(SizedGridDelegate oldDelegate) {
    if (alwaysRelayout || itemCount != oldDelegate.itemCount) {
      _cachedLayout = null;
      return true;
    }

    return false;
  }
}