part of '../field/field_bloc.dart';

/// A `FieldBloc` used for `String` type, but generally
/// it is also used to obtain `int` and `double` values
/// ​​of texts thanks to the methods
/// [valueToInt] and [valueToDouble].
class TextFieldBloc extends FieldBlocBase<String, String, TextFieldBlocState> {
  /// ### Properties:
  ///
  /// * [initialValue] : The initial value of the field,
  /// by default is a empty `String` ('').
  /// * [validators] : List of [Validator]s.
  /// Each time the `value` will change,
  /// if the [FormBloc] that use this [TextFieldBloc] has set
  /// in the `super` constructor `autoValidate = true`,
  /// the `value` is passed to each `validator`,
  /// and if any `validator` returns a `String error`,
  /// it will be added to [TextFieldBlocState.error].
  /// Else if `autoValidate = false`, the value will be checked only
  /// when you call [validate] which is called automatically when call [FormBloc.submit].
  /// * [asyncValidators] : List of [AsyncValidator]s.
  /// it is the same as [validators] but asynchronous.
  /// Very useful for server validation.
  /// * [asyncValidatorDebounceTime] : The debounce time when any `asyncValidator`
  /// must be called, by default is 500 milliseconds.
  /// Very useful for reduce the number of invocations of each `asyncValidator.
  /// For example, used for prevent limit in API calls.
  /// * [suggestions] : This need be a [Suggestions] and will be
  /// added to [TextFieldBlocState.suggestions].
  /// It is used to suggest values, usually from an API,
  /// and any of those suggestions can be used to update
  /// the value using [updateValue].
  /// * [toStringName] : This will be added to [TextFieldBlocState.toStringName].
  TextFieldBloc({
    String initialValue = '',
    List<Validator<String>> validators,
    List<AsyncValidator<String>> asyncValidators,
    Duration asyncValidatorDebounceTime = const Duration(milliseconds: 500),
    Suggestions<String> suggestions,
    String toStringName,
  })  : assert(initialValue != null),
        assert(asyncValidatorDebounceTime != null),
        super(
          initialValue,
          validators,
          asyncValidators,
          asyncValidatorDebounceTime,
          suggestions,
          toStringName,
        );

  @override
  TextFieldBlocState get initialState => TextFieldBlocState(
        value: _initialValue,
        error: _getInitialStateError,
        isInitial: true,
        suggestions: _suggestions,
        isValidated: _isValidated(_getInitialStateIsValidating),
        isValidating: _getInitialStateIsValidating,
        toStringName: _toStringName,
      );

  /// Return the parsed `value` to `int` of the current state.
  ///
  /// if the `value` is an `int` returns the parsed `value`,
  /// else returns `null`.
  int get valueToInt => state.valueToInt;

  /// Return the parsed `value` to `double` of the current state.
  ///
  /// if the `value` is a `double` returns the parsed `value`,
  /// else returns `null`.
  double get valueToDouble => state.valueToDouble;

  /// Set the `value` to `''` of the current state.
  ///
  /// {@macro form_bloc.field_bloc.update_value}
  @override
  void clear() => add(UpdateFieldBlocValue(''));
}
