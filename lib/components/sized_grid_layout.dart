import 'package:flutter/rendering.dart';

class SizedGridLayout extends SliverGridLayout {
  const SizedGridLayout({required this.sizes});

  /// The list that defines the size of all grid items.
  final List<Size> sizes;

  /// Returns the scroll offset for a given scroll index.
  double scrollOffsetOf(int index) {
    return sizes.sublist(0, index).fold(0, (cum, size) => cum + size.height);
  }

  @override
  double computeMaxScrollOffset(int childCount) {
    return sizes.fold(0, (cum, size) => cum + size.height);
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    return SliverGridGeometry(
      scrollOffset: scrollOffsetOf(index),
      crossAxisOffset: 0,
      mainAxisExtent: sizes[index].height,
      crossAxisExtent: sizes[index].width,
    );
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    double accumulatedHeight = 0;
    for (int i = 0; i < sizes.length; i++) {
      accumulatedHeight += sizes[i].height;
      if (accumulatedHeight > scrollOffset) {
        return i;
      }
    }

    // Return the last index if scrollOffset exceeds all items.
    return sizes.length - 1;
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    double accumulatedHeight = 0;
    for (int i = 0; i < sizes.length; i++) {
      accumulatedHeight += sizes[i].height;
      if (accumulatedHeight > scrollOffset) {
        return i;
      }
    }

    // Return the last index if scrollOffset exceeds all items.
    return sizes.length - 1;
  }
}