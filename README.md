# Introduction
This Flutter package provides a widget that can be used when the sizes of all items are known. While the standard ListView infers the maximum scroll offset, this package defines it with a consistent value. Additionally, when defining the initialScrollOffset, traditional ListView rebuilds all off-screen items to calculate their heights, but the SizedListView widget prevents or avoids this issue.

> See Also, If you want the [change log](CHANGELOG.md) by version for this package. refer to Change Log for details.

## Usage
The following explains the basic usage of this package.

### When using `SizedListView` widget.
```dart
SizedListView.builder(
    itemCount: items.length,
    sizeBuilder: ...,
    itemBuilder: ...
),
```

### When using `GridView` widget.
```dart
GridView(
    gridDelegate: SizedGridDelegate(...),
)
```