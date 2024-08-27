// ignore_for_file: unnecessary_null_comparison
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:smart_flutter_utils/smart_flutter_utils.dart';
import 'package:smart_flutter_widgets/smart_flutter_widgets.dart';

const kAutocompleteMinOptionHeight = 54.0;
const kAutocompleteVisibleOptionCount = 5;
const kAutocompleteOptionsOffset = Offset(0.0, 8.0);

typedef AutocompleteOptionViewBuilder<T extends Object> = Widget Function(
  BuildContext context,
  AutocompleteOnSelected<T> onSelected,
  int index,
  T option,
);

typedef AutocompleteOptionFilter<T extends Object> = bool Function(
  TextEditingValue textEditingValue,
  T option,
);

typedef AutocompleteOptions<T extends Object> = Iterable<T> Function();

class SmartAutocomplete<T extends Object> extends StatelessWidget {
  const SmartAutocomplete({
    super.key,
    required this.options,
    this.onSelected,
    this.fieldViewBuilder,
    this.optionViewBuilder,
    this.optionFilter,
    this.divider,
    this.optionHeight = kAutocompleteMinOptionHeight,
    this.visibleOptionCount = kAutocompleteVisibleOptionCount,
    this.padding = const EdgeInsetsDirectional.only(end: 16.0),
    this.clearOnUnfocus = false,
    this.clearOnSelection = false,
    this.alwaysShowOptions = false,
    this.selectOnSubmit = true,
    this.selectOnSubmitIfEmpty = true,
    this.optionsOffset = kAutocompleteOptionsOffset,
    this.displayStringForOption = SmartRawAutocomplete.defaultStringForOption,
    this.focusNode,
    this.controller,
    this.initialValue,
    this.onFieldChanged,
  });

  final AutocompleteOptions<T> options;
  final AutocompleteOnSelected<T>? onSelected;
  final AutocompleteFieldViewBuilder? fieldViewBuilder;
  final AutocompleteOptionViewBuilder<T>? optionViewBuilder;
  final AutocompleteOptionFilter<T>? optionFilter;
  final Widget? divider;
  final double optionHeight;
  final int visibleOptionCount;
  final EdgeInsetsGeometry? padding;
  final bool clearOnUnfocus;
  final bool clearOnSelection;
  final bool alwaysShowOptions;
  final bool selectOnSubmit;
  final bool selectOnSubmitIfEmpty;
  final Offset optionsOffset;
  final AutocompleteOptionToString<T> displayStringForOption;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextEditingValue? initialValue;
  final ValueChanged<String>? onFieldChanged;

  bool _optionFilter(TextEditingValue textEditingValue, T option) =>
      option.toString().containsIgnoreCase(textEditingValue.text);

  @override
  Widget build(BuildContext context) {
    return SmartRawAutocomplete<T>(
      onSelected: onSelected,
      optionsBuilder: (textEditingValue) {
        final options = this.options();
        final filter = optionFilter ?? _optionFilter;
        return textEditingValue.text.isEmpty
            ? options
            : options.where((option) => filter(textEditingValue, option));
      },
      fieldViewBuilder: fieldViewBuilder,
      optionsViewBuilder: _buildOptionsView,
      clearOnUnfocus: clearOnUnfocus,
      clearOnSelection: clearOnSelection,
      alwaysShowOptions: alwaysShowOptions,
      selectOnSubmit: selectOnSubmit,
      selectOnSubmitIfEmpty: selectOnSubmitIfEmpty,
      optionsOffset: optionsOffset,
      displayStringForOption: displayStringForOption,
      focusNode: focusNode,
      controller: controller,
      initialValue: initialValue,
      onFieldChanged: onFieldChanged,
    );
  }

  Widget _buildOptionsView(
    BuildContext context,
    AutocompleteOnSelected<T> onSelected,
    Iterable<T> options,
  ) {
    return Container(
      margin: padding,
      padding: padding,
      alignment: AlignmentDirectional.topStart,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: min(
            optionHeight * visibleOptionCount,
            optionHeight * options.length,
          ),
          child: SmartListView.builder(
            padding: EdgeInsets.zero,
            itemCount: options.length,
            divider: divider ?? const Divider(indent: 16, endIndent: 16),
            itemBuilder: (context, index, _) {
              final option = options.elementAt(index);
              return optionViewBuilder?.call(
                    context,
                    onSelected,
                    index,
                    option,
                  ) ??
                  SimpleListTile(
                    title: Text(displayStringForOption(option)),
                    onTap: () => onSelected(option),
                  );
            },
          ),
        ),
      ),
    );
  }
}

/// The user's text input is received in a field built with the
/// [fieldViewBuilder] parameter. The options to be displayed are determined
/// using [optionsBuilder] and rendered with [optionsViewBuilder].
///
/// This is a core framework widget with very basic UI.
///
/// {@tool dartpad}
/// This example shows how to create a very basic autocomplete widget using the
/// [fieldViewBuilder] and [optionsViewBuilder] parameters.
///
/// ** See code in examples/api/lib/widgets/autocomplete/raw_autocomplete.0.dart **
/// {@end-tool}
///
/// The type parameter T represents the type of the options. Most commonly this
/// is a String, as in the example above. However, it's also possible to use
/// another type with a `toString` method, or a custom [displayStringForOption].
/// Options will be compared using `==`, so it may be beneficial to override
/// [Object.==] and [Object.hashCode] for custom types.
///
/// {@tool dartpad}
/// This example is similar to the previous example, but it uses a custom T data
/// type instead of directly using String.
///
/// ** See code in examples/api/lib/widgets/autocomplete/raw_autocomplete.1.dart **
/// {@end-tool}
///
/// {@tool dartpad}
/// This example shows the use of RawAutocomplete in a form.
///
/// ** See code in examples/api/lib/widgets/autocomplete/raw_autocomplete.2.dart **
/// {@end-tool}
///
/// See also:
///
///  * [Autocomplete], which is a Material-styled implementation that is based
/// on RawAutocomplete.
class SmartRawAutocomplete<T extends Object> extends StatefulWidget {
  /// Create an instance of RawAutocomplete.
  ///
  /// [displayStringForOption], [optionsBuilder] and [optionsViewBuilder] must
  /// not be null.
  const SmartRawAutocomplete({
    super.key,
    required this.optionsViewBuilder,
    required this.optionsBuilder,
    this.displayStringForOption = defaultStringForOption,
    this.fieldViewBuilder,
    this.focusNode,
    this.onSelected,
    this.controller,
    this.initialValue,
    this.alwaysShowOptions = false,
    this.clearOnUnfocus = false,
    this.clearOnSelection = false,
    this.selectOnSubmit = true,
    this.selectOnSubmitIfEmpty = true,
    this.optionsOffset = kAutocompleteOptionsOffset,
    this.onFieldChanged,
  })  : assert(displayStringForOption != null),
        assert(
          fieldViewBuilder != null ||
              (key != null && focusNode != null && controller != null),
          'Pass in a fieldViewBuilder, or otherwise create a separate field and pass in the FocusNode, TextEditingController, and a key. Use the key with RawAutocomplete.onFieldSubmitted.',
        ),
        assert(optionsBuilder != null),
        assert(optionsViewBuilder != null),
        assert((focusNode == null) == (controller == null)),
        assert(
          !(controller != null && initialValue != null),
          'textEditingController and initialValue cannot be simultaneously defined.',
        );

  /// {@template flutter.widgets.RawAutocomplete.fieldViewBuilder}
  /// Builds the field whose input is used to get the options.
  ///
  /// Pass the provided [TextEditingController] to the field built here so that
  /// RawAutocomplete can listen for changes.
  /// {@endtemplate}
  final AutocompleteFieldViewBuilder? fieldViewBuilder;

  /// The [FocusNode] that is used for the text field.
  ///
  /// {@template flutter.widgets.RawAutocomplete.split}
  /// The main purpose of this parameter is to allow the use of a separate text
  /// field located in another part of the widget tree instead of the text
  /// field built by [fieldViewBuilder]. For example, it may be desirable to
  /// place the text field in the AppBar and the options below in the main body.
  ///
  /// When following this pattern, [fieldViewBuilder] can return
  /// `SizedBox.shrink()` so that nothing is drawn where the text field would
  /// normally be. A separate text field can be created elsewhere, and a
  /// FocusNode and TextEditingController can be passed both to that text field
  /// and to RawAutocomplete.
  ///
  /// {@tool dartpad}
  /// This examples shows how to create an autocomplete widget with the text
  /// field in the AppBar and the results in the main body of the app.
  ///
  /// ** See code in examples/api/lib/widgets/autocomplete/raw_autocomplete.focus_node.0.dart **
  /// {@end-tool}
  /// {@endtemplate}
  ///
  /// If this parameter is not null, then [controller] must also be
  /// not null.
  final FocusNode? focusNode;

  /// {@template flutter.widgets.RawAutocomplete.optionsViewBuilder}
  /// Builds the selectable options widgets from a list of options objects.
  ///
  /// The options are displayed floating below the field using a
  /// [CompositedTransformFollower] inside of an [Overlay], not at the same
  /// place in the widget tree as [RawAutocomplete].
  ///
  /// In order to track which item is highlighted by keyboard navigation, the
  /// resulting options will be wrapped in an inherited
  /// [AutocompleteHighlightedOption] widget.
  /// Inside this callback, the index of the highlighted option can be obtained
  /// from [AutocompleteHighlightedOption.of] to display the highlighted option
  /// with a visual highlight to indicate it will be the option selected from
  /// the keyboard.
  ///
  /// {@endtemplate}
  final AutocompleteOptionsViewBuilder<T> optionsViewBuilder;

  /// {@template flutter.widgets.RawAutocomplete.displayStringForOption}
  /// Returns the string to display in the field when the option is selected.
  ///
  /// This is useful when using a custom T type and the string to display is
  /// different than the string to search by.
  ///
  /// If not provided, will use `option.toString()`.
  /// {@endtemplate}
  final AutocompleteOptionToString<T> displayStringForOption;

  /// {@template flutter.widgets.RawAutocomplete.onSelected}
  /// Called when an option is selected by the user.
  ///
  /// Any [TextEditingController] listeners will not be called when the user
  /// selects an option, even though the field will update with the selected
  /// value, so use this to be informed of selection.
  /// {@endtemplate}
  final AutocompleteOnSelected<T>? onSelected;

  /// {@template flutter.widgets.RawAutocomplete.optionsBuilder}
  /// A function that returns the current selectable options objects given the
  /// current TextEditingValue.
  /// {@endtemplate}
  final AutocompleteOptionsBuilder<T> optionsBuilder;

  /// The [TextEditingController] that is used for the text field.
  ///
  /// {@macro flutter.widgets.RawAutocomplete.split}
  ///
  /// If this parameter is not null, then [focusNode] must also be not null.
  final TextEditingController? controller;

  /// {@template flutter.widgets.RawAutocomplete.initialValue}
  /// The initial value to use for the text field.
  /// {@endtemplate}
  ///
  /// Setting the initial value does not notify [controller]'s
  /// listeners, and thus will not cause the options UI to appear.
  ///
  /// This parameter is ignored if [controller] is defined.
  final TextEditingValue? initialValue;

  final bool clearOnUnfocus;
  final bool clearOnSelection;
  final bool alwaysShowOptions;
  final bool selectOnSubmit;
  final bool selectOnSubmitIfEmpty;
  final Offset optionsOffset;
  final ValueChanged<String>? onFieldChanged;

  /// Calls [AutocompleteFieldViewBuilder]'s onFieldSubmitted callback for the
  /// RawAutocomplete widget indicated by the given [GlobalKey].
  ///
  /// This is not typically used unless a custom field is implemented instead of
  /// using [fieldViewBuilder]. In the typical case, the onFieldSubmitted
  /// callback is passed via the [AutocompleteFieldViewBuilder] signature. When
  /// not using fieldViewBuilder, the same callback can be called by using this
  /// static method.
  ///
  /// See also:
  ///
  ///  * [focusNode] and [controller], which contain a code example
  ///    showing how to create a separate field outside of fieldViewBuilder.
  static void onFieldSubmitted<T extends Object>(GlobalKey key) {
    final _SmartRawAutocompleteState<T> rawAutocomplete =
        key.currentState! as _SmartRawAutocompleteState<T>;
    rawAutocomplete._onFieldSubmitted();
  }

  /// The default way to convert an option to a string in
  /// [displayStringForOption].
  ///
  /// Simply uses the `toString` method on the option.
  static String defaultStringForOption(dynamic option) {
    return option.toString();
  }

  @override
  State<SmartRawAutocomplete<T>> createState() =>
      _SmartRawAutocompleteState<T>();
}

class _SmartRawAutocompleteState<T extends Object>
    extends State<SmartRawAutocomplete<T>> {
  final GlobalKey _fieldKey = GlobalKey();
  final LayerLink _optionsLayerLink = LayerLink();
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late final Map<Type, Action<Intent>> _actionMap;
  late final _AutocompleteCallbackAction<AutocompletePreviousOptionIntent>
      _previousOptionAction;
  late final _AutocompleteCallbackAction<AutocompleteNextOptionIntent>
      _nextOptionAction;
  late final _AutocompleteCallbackAction<DismissIntent> _hideOptionsAction;
  Iterable<T> _options = Iterable<T>.empty();
  T? _selection;
  bool _userHidOptions = false;
  String _lastFieldText = '';
  final ValueNotifier<int> _highlightedOptionIndex = ValueNotifier<int>(0);

  static const Map<ShortcutActivator, Intent> _shortcuts =
      <ShortcutActivator, Intent>{
    SingleActivator(LogicalKeyboardKey.arrowUp):
        AutocompletePreviousOptionIntent(),
    SingleActivator(LogicalKeyboardKey.arrowDown):
        AutocompleteNextOptionIntent(),
  };

  // The OverlayEntry containing the options.
  OverlayEntry? _floatingOptions;

  bool get _noSelection => widget.alwaysShowOptions || _selection == null;

  // True iff the state indicates that the options should be visible.
  bool get _shouldShowOptions {
    return !_userHidOptions &&
        _focusNode.hasFocus &&
        _noSelection &&
        _options.isNotEmpty;
  }

  Future<void> _updateOptions([TextEditingValue? value]) async {
    _options = await widget.optionsBuilder(
      value ?? _textEditingController.value,
    );
    _updateHighlight(_highlightedOptionIndex.value);
  }

  // Called when _textEditingController changes.
  Future<void> _onChangedField() async {
    final TextEditingValue value = _textEditingController.value;
    widget.onFieldChanged?.call(value.text);
    await _updateOptions(value);
    if (_selection != null &&
        value.text != widget.displayStringForOption(_selection!)) {
      _selection = null;
    }

    // Make sure the options are no longer hidden if the content of the field
    // changes (ignore selection changes).
    if (value.text != _lastFieldText) {
      _userHidOptions = false;
      _lastFieldText = value.text;
    }
    _updateActions();
    _updateOverlay();
  }

  // Called when the field's FocusNode changes.
  void _onChangedFocus() {
    if (widget.clearOnUnfocus && !_focusNode.hasFocus) {
      _textEditingController.clear();
      _selection = null;
    }
    // Options should no longer be hidden when the field is re-focused.
    _userHidOptions = !_focusNode.hasFocus;
    _updateActions();
    _updateOverlay();
  }

  // Called from fieldViewBuilder when the user submits the field.
  void _onFieldSubmitted() {
    if (_options.isEmpty || _userHidOptions) {
      return;
    }
    if (widget.selectOnSubmit) {
      if (!widget.selectOnSubmitIfEmpty &&
          _textEditingController.text.isEmpty) {
        return;
      }
      _select(_options.elementAt(_highlightedOptionIndex.value));
    }
  }

  // Select the given option and update the widget.
  void _select(T nextSelection) {
    if (widget.clearOnSelection) {
      _textEditingController.clear();
      _selection = nextSelection;
    } else {
      if (nextSelection == _selection) return;

      _selection = nextSelection;
      final String selectionString =
          widget.displayStringForOption(nextSelection);
      _textEditingController.value = TextEditingValue(
        selection: TextSelection.collapsed(offset: selectionString.length),
        text: selectionString,
      );
    }
    _updateActions();
    _updateOverlay();
    widget.onSelected?.call(_selection!);
  }

  void _updateHighlight(int newIndex) {
    _highlightedOptionIndex.value =
        _options.isEmpty ? 0 : newIndex % _options.length;
  }

  void _highlightPreviousOption(AutocompletePreviousOptionIntent intent) {
    if (_userHidOptions) {
      _userHidOptions = false;
      _updateActions();
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value - 1);
  }

  void _highlightNextOption(AutocompleteNextOptionIntent intent) {
    if (_userHidOptions) {
      _userHidOptions = false;
      _updateActions();
      _updateOverlay();
      return;
    }
    _updateHighlight(_highlightedOptionIndex.value + 1);
  }

  Object? _hideOptions(DismissIntent intent) {
    if (!_userHidOptions) {
      _userHidOptions = true;
      _updateActions();
      _updateOverlay();
      return null;
    }
    return Actions.invoke(context, intent);
  }

  void _setActionsEnabled(bool enabled) {
    // The enabled state determines whether the action will consume the
    // key shortcut or let it continue on to the underlying text field.
    // They should only be enabled when the options are showing so shortcuts
    // can be used to navigate them.
    _previousOptionAction.enabled = enabled;
    _nextOptionAction.enabled = enabled;
    _hideOptionsAction.enabled = enabled;
  }

  void _updateActions() {
    _setActionsEnabled(
      _focusNode.hasFocus && _noSelection && _options.isNotEmpty,
    );
  }

  bool _floatingOptionsUpdateScheduled = false;
  // Hide or show the options overlay, if needed.
  void _updateOverlay() {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      if (!_floatingOptionsUpdateScheduled) {
        _floatingOptionsUpdateScheduled = true;
        SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
          _floatingOptionsUpdateScheduled = false;
          _updateOverlay();
        });
      }
      return;
    }

    _floatingOptions?.remove();
    if (_shouldShowOptions) {
      final OverlayEntry newFloatingOptions = OverlayEntry(
        builder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _optionsLayerLink,
            showWhenUnlinked: false,
            offset: widget.optionsOffset,
            targetAnchor: Alignment.bottomLeft,
            child: AutocompleteHighlightedOption(
              highlightIndexNotifier: _highlightedOptionIndex,
              child: Builder(
                builder: (BuildContext context) {
                  return widget.optionsViewBuilder(context, _select, _options);
                },
              ),
            ),
          );
        },
      );
      Overlay.of(context, rootOverlay: true).insert(newFloatingOptions);
      _floatingOptions = newFloatingOptions;
    } else {
      _floatingOptions = null;
    }
  }

  // Handle a potential change in textEditingController by properly disposing of
  // the old one and setting up the new one, if needed.
  void _updateTextEditingController(
    TextEditingController? old,
    TextEditingController? current,
  ) {
    if ((old == null && current == null) || old == current) {
      return;
    }
    if (old == null) {
      _textEditingController.removeListener(_onChangedField);
      _textEditingController.dispose();
      _textEditingController = current!;
    } else if (current == null) {
      _textEditingController.removeListener(_onChangedField);
      _textEditingController = TextEditingController();
    } else {
      _textEditingController.removeListener(_onChangedField);
      _textEditingController = current;
    }
    _textEditingController.addListener(_onChangedField);
  }

  // Handle a potential change in focusNode by properly disposing of the old one
  // and setting up the new one, if needed.
  void _updateFocusNode(FocusNode? old, FocusNode? current) {
    if ((old == null && current == null) || old == current) {
      return;
    }
    if (old == null) {
      _focusNode.removeListener(_onChangedFocus);
      _focusNode.dispose();
      _focusNode = current!;
    } else if (current == null) {
      _focusNode.removeListener(_onChangedFocus);
      _focusNode = FocusNode();
    } else {
      _focusNode.removeListener(_onChangedFocus);
      _focusNode = current;
    }
    _focusNode.addListener(_onChangedFocus);
  }

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ??
        TextEditingController.fromValue(widget.initialValue);
    _textEditingController.addListener(_onChangedField);
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onChangedFocus);
    _previousOptionAction =
        _AutocompleteCallbackAction<AutocompletePreviousOptionIntent>(
      onInvoke: _highlightPreviousOption,
    );
    _nextOptionAction =
        _AutocompleteCallbackAction<AutocompleteNextOptionIntent>(
      onInvoke: _highlightNextOption,
    );
    _hideOptionsAction =
        _AutocompleteCallbackAction<DismissIntent>(onInvoke: _hideOptions);
    _actionMap = <Type, Action<Intent>>{
      AutocompletePreviousOptionIntent: _previousOptionAction,
      AutocompleteNextOptionIntent: _nextOptionAction,
      DismissIntent: _hideOptionsAction,
    };
    _updateActions();
    _updateOverlay();
  }

  @override
  void didUpdateWidget(SmartRawAutocomplete<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateTextEditingController(
      oldWidget.controller,
      widget.controller,
    );
    _updateFocusNode(oldWidget.focusNode, widget.focusNode);
    _updateActions();
    _updateOverlay();
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onChangedField);
    if (widget.controller == null) {
      _textEditingController.dispose();
    }
    _focusNode.removeListener(_onChangedFocus);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _floatingOptions?.remove();
    _floatingOptions = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _fieldKey,
      child: Shortcuts(
        shortcuts: _shortcuts,
        child: Actions(
          actions: _actionMap,
          child: CompositedTransformTarget(
            link: _optionsLayerLink,
            child: widget.fieldViewBuilder == null
                ? const SizedBox.shrink()
                : widget.fieldViewBuilder!(
                    context,
                    _textEditingController,
                    _focusNode,
                    _onFieldSubmitted,
                  ),
          ),
        ),
      ),
    );
  }
}

class _AutocompleteCallbackAction<T extends Intent> extends CallbackAction<T> {
  _AutocompleteCallbackAction({
    required super.onInvoke,
    this.enabled = true,
  });

  bool enabled;

  @override
  bool isEnabled(covariant T intent) => enabled;

  @override
  bool consumesKey(covariant T intent) => enabled;
}
