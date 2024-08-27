import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension WidgetStates<T> on WidgetStateProperty<T> {
  T? get normal => resolve({});

  T? get hovered => resolve({WidgetState.hovered});

  T? get focused => resolve({WidgetState.focused});

  T? get pressed => resolve({WidgetState.pressed});

  T? get dragged => resolve({WidgetState.dragged});

  T? get selected => resolve({WidgetState.selected});

  T? get scrolledUnder => resolve({WidgetState.scrolledUnder});

  T? get disabled => resolve({WidgetState.disabled});

  T? get error => resolve({WidgetState.error});
}

extension WidgetStateSet on Set<WidgetState> {
  bool get isNormal => isEmpty;

  bool get isHovered => contains(WidgetState.hovered);

  bool get isFocused => contains(WidgetState.focused);

  bool get isPressed => contains(WidgetState.pressed);

  bool get isDragged => contains(WidgetState.dragged);

  bool get isSelected => contains(WidgetState.selected);

  bool get isScrolledUnder => contains(WidgetState.scrolledUnder);

  bool get isDisabled => contains(WidgetState.disabled);

  bool get isError => contains(WidgetState.error);
}
