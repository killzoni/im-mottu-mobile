import 'package:flutter/material.dart';
import 'package:im_mottu_mobile/app/utils/state_page.dart';

typedef WidgetStateCallback = Widget Function();
typedef SuccessCallback<T> = Widget Function(T?);
typedef ErrorCallback = Widget Function(StateError);

class ObservableState<T> extends StatelessWidget {
  final StatePage state;

  final WidgetStateCallback? stateStart;
  final WidgetStateCallback? stateLoading;
  final WidgetStateCallback? stateEmpty;
  final SuccessCallback<T>? stateSuccess;
  final ErrorCallback? stateError;

  const ObservableState({
    super.key,
    required this.state,
    this.stateStart,
    this.stateLoading,
    this.stateSuccess,
    this.stateEmpty,
    this.stateError,
  });

  @override
  Widget build(BuildContext context) {
    try {
      if (state is StateStart && stateStart != null) {
        return stateStart!();
      }

      if (state is StateLoading && stateLoading != null) {
        return stateLoading!();
      }

      if (state is StateEmpty && stateEmpty != null) {
        return stateEmpty!();
      }

      if (state is StateSuccess && stateSuccess != null) {
        return stateSuccess!((state as StateSuccess).data as T);
      }

      if (state is StateError && stateError != null) {
        return stateError!(state as StateError);
      }
    } on Exception catch (e) {
      if (state is StateError) {
        return stateError!(StateError(
            message: "Error in ObservableState widget \n${e.toString()}"));
      }
    }

    throw Exception(
        "Error widget ObservableState, no callback(${state.runtimeType.toString()}) defined!");
  }
}
