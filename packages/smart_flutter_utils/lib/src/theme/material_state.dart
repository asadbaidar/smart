part of 'theme.dart';

extension MaterialStates<T> on MaterialStateProperty<T> {
  T? get normal => resolve({});

  T? get hovered => resolve({MaterialState.hovered});

  T? get focused => resolve({MaterialState.focused});

  T? get pressed => resolve({MaterialState.pressed});

  T? get dragged => resolve({MaterialState.dragged});

  T? get selected => resolve({MaterialState.selected});

  T? get scrolledUnder => resolve({MaterialState.scrolledUnder});

  T? get disabled => resolve({MaterialState.disabled});

  T? get error => resolve({MaterialState.error});
}

extension MaterialStateSet on Set<MaterialState> {
  bool get isNormal => isEmpty;

  bool get isHovered => contains(MaterialState.hovered);

  bool get isFocused => contains(MaterialState.focused);

  bool get isPressed => contains(MaterialState.pressed);

  bool get isDragged => contains(MaterialState.dragged);

  bool get isSelected => contains(MaterialState.selected);

  bool get isScrolledUnder => contains(MaterialState.scrolledUnder);

  bool get isDisabled => contains(MaterialState.disabled);

  bool get isError => contains(MaterialState.error);
}
