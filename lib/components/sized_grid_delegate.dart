import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sized_list_view/flutter_sized_list_view.dart';

class SizedGridDelegate extends SliverGridDelegate {
  SizedGridDelegate({
    required this.sizeBuilder,
    required this.itemCount,
    this.alwaysRelayout = false,
  });

  final IndexedSizeBuilder sizeBuilder;
  final int itemCount;

  /// Whether the [GridView] or [SizedListView] will always
  /// go through the layout phase when the state updates.
  final bool alwaysRelayout;

  /// The instance that defines cached sizes of all items.
  List<Size>? _cachedSizes;

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    _cachedSizes ??= List.generate(itemCount, (index) => sizeBuilder(constraints, index));
    return SizedGridLayout(sizes: _cachedSizes!);
  }

  @override
  bool shouldRelayout(SizedGridDelegate oldDelegate) {
    if (alwaysRelayout
     || itemCount != oldDelegate.itemCount
     || _cachedSizes != oldDelegate._cachedSizes) {
      _cachedSizes = null;
      return true;
    }

    return false;
  }
}