library simple_radio_group;

import 'package:flutter/material.dart';

class SimpleRadioGroupController<T> extends ChangeNotifier {
  T? _value;

  SimpleRadioGroupController({
    T? value,
  }) : _value = value;

  T? get value => _value;

  set value(T? value) {
    _value = value;
    notifyListeners();
  }
}

class SimpleRadioGroup<T> extends FormField<T> {
  final SimpleRadioGroupController<T>? controller;

  SimpleRadioGroup({
    super.key,
    this.controller,
    T? initialValue,
    Axis direction = Axis.vertical,
    Widget Function(T option)? labelBuilder,
    required List<T> options,
    ValueChanged<T?>? onChanged,
    super.validator,
  })  : assert(initialValue == null || controller == null),
        super(
          initialValue: initialValue ?? controller?.value,
          builder: (FormFieldState<T> state) {
            return _SimpleRadioGroupWidget(
              options: options,
              labelBuilder: labelBuilder,
              onChanged: onChanged,
              controller: (state as _SimpleRadioGroupState<T>).effectiveController,
              direction: direction,
              hasError: state.hasError,
              errorText: state.errorText,
            );
          },
        );

  @override
  FormFieldState<T> createState() => _SimpleRadioGroupState<T>();
}

class _SimpleRadioGroupState<T> extends FormFieldState<T> {
  late final SimpleRadioGroupController<T> effectiveController;

  @override
  void initState() {
    super.initState();
    effectiveController = _radioGroup.controller ??
        SimpleRadioGroupController<T>(
          value: _radioGroup.initialValue,
        );
    effectiveController.addListener(_setValue);
  }

  @override
  void dispose() {
    effectiveController.removeListener(_setValue);
    if (_radioGroup.controller == null) {
      effectiveController.dispose();
    }
    super.dispose();
  }

  void _setValue() {
    setValue(effectiveController.value);
  }

  SimpleRadioGroup<T> get _radioGroup => widget as SimpleRadioGroup<T>;
}

class _SimpleRadioGroupWidget<T> extends StatefulWidget {
  final SimpleRadioGroupController<T> controller;
  final Axis direction;
  final List<T> options;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final Widget Function(T option)? labelBuilder;
  final bool hasError;
  final String? errorText;

  const _SimpleRadioGroupWidget({
    super.key,
    required this.controller,
    required this.direction,
    required this.options,
    this.onChanged,
    this.labelBuilder,
    this.initialValue,
    this.hasError = false,
    this.errorText,
  });

  @override
  State<_SimpleRadioGroupWidget<T>> createState() => _SimpleRadioGroupWidgetState<T>();
}

class _SimpleRadioGroupWidgetState<T> extends State<_SimpleRadioGroupWidget<T>> {
  void _onChanged(T? option) {
    setState(() {
      widget.controller.value = widget.controller.value == option ? null : option;
      widget.onChanged?.call(widget.controller.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flex(
          direction: widget.direction,
          children: [
            for (final option in widget.options)
              Row(
                children: [
                  Radio<T>(
                    value: option,
                    groupValue: widget.controller.value,
                    onChanged: _onChanged,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () => _onChanged(option),
                    child: widget.labelBuilder?.call(option) ?? Text(option.toString()),
                  ),
                ],
              ),
          ],
        ),
        if (widget.hasError)
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.errorText!,
              style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
            ),
          )
      ],
    );
  }
}
