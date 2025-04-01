import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sized_list_view/flutter_sized_list_view.dart';

/// Signature for a function that creates a size for a given index.
typedef IndexedSizeBuilder = Size Function(SliverConstraints constraints, int index);

class SizedListView extends StatefulWidget {
  const SizedListView.builder({
    super.key,
    required this.itemBuilder,
    required this.sizeBuilder,
    required this.itemCount,
    this.controller,
    this.findChildIndexCallback,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexOffset,
    this.scrollDirection = Axis.vertical,
    this.restorationId,
    this.padding,
    this.reverse = false,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.cacheExtent,
    this.semanticChildCount,
    this.dragStartBehavior = DragStartBehavior.start,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.clipBehavior = Clip.hardEdge,
    this.alwaysRelayout = false,
  });

  final IndexedWidgetBuilder itemBuilder;
  final IndexedSizeBuilder sizeBuilder;
  final int itemCount;
  final ScrollController? controller;
  final ChildIndexGetter? findChildIndexCallback;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final int? semanticIndexOffset;
  final Axis scrollDirection;
  final String? restorationId;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? cacheExtent;
  final int? semanticChildCount;
  final DragStartBehavior dragStartBehavior;
  final HitTestBehavior hitTestBehavior;
  final Clip clipBehavior;

  /// Whether the widget will always go through the layout phase when the state updates.
  final bool alwaysRelayout;

  @override
  State<SizedListView> createState() => _SizedListViewState();
}

class _SizedListViewState extends State<SizedListView> {
  SliverChildBuilderDelegate get childrenDelegate => SliverChildBuilderDelegate(
    widget.itemBuilder,
    childCount: widget.itemCount,
    findChildIndexCallback: widget.findChildIndexCallback,
    addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
    addRepaintBoundaries: widget.addRepaintBoundaries,
    addSemanticIndexes: widget.addSemanticIndexes,
    semanticIndexOffset: widget.semanticIndexOffset ?? 0
  );

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      controller: widget.controller,
      scrollDirection: widget.scrollDirection,
      restorationId: widget.restorationId,
      padding: widget.padding,
      reverse: widget.reverse,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      cacheExtent: widget.cacheExtent,
      semanticChildCount: widget.semanticChildCount,
      dragStartBehavior: widget.dragStartBehavior,
      hitTestBehavior: widget.hitTestBehavior,
      clipBehavior: widget.clipBehavior,
      gridDelegate: SizedGridDelegate(
        sizeBuilder: widget.sizeBuilder,
        itemCount: widget.itemCount
      ),
      childrenDelegate: childrenDelegate,
    );
  }
}