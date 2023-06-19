library reactfier;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:rx_notifier/rx_notifier.dart';

/// A Observable Class.
class Reactfier<Value> {
  Reactfier(Value value) : _valueNotifier = RxNotifier<Value>(value);

  final RxNotifier<Value> _valueNotifier;
  Value get value => _valueNotifier.value;
  set value(Value value) => _valueNotifier.value = value;
}

class ReactfierList<Value> extends RxList<Value> {
  ReactfierList(super.value);
}

class ReactfierListState<Value, State> extends ReactfierList<Value> {
  ReactfierListState(
    super.value,
    State state,
  ) : _stateNotifier = RxNotifier<State>(state);

  final RxNotifier<State> _stateNotifier;
  State get state => _stateNotifier.value;
  set state(State state) => _stateNotifier.value = state;
}

class ReactfierState<Value, State> extends Reactfier<Value> {
  ReactfierState(
    super.value,
    State state,
  ) : _stateNotifier = RxNotifier<State>(state);

  final RxNotifier<State> _stateNotifier;
  State get state => _stateNotifier.value;
  set state(State state) => _stateNotifier.value = state;
}

/// A Observable Listener Widget
class ReactfierBuilder extends StatelessWidget {
  const ReactfierBuilder({
    required this.builder,
    super.key,
    this.filter,
  });

  final Widget Function(BuildContext) builder;
  final bool Function()? filter;

  @override
  Widget build(BuildContext context) => RxBuilder(
        builder: builder,
        filter: filter,
      );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties
      ..add(DiagnosticsProperty('builder', builder))
      ..add(DiagnosticsProperty('filter', filter));
  }
}

class ReactfierDisposer {
  ReactfierDisposer(this.dispose);
  final RxDisposer dispose;
}

ReactfierDisposer reactfierListener<Notifier>(
  Notifier? Function() fn, {
  bool Function()? filter,
  void Function(Notifier? value)? effect,
}) =>
    ReactfierDisposer(
      rxObserver(
        fn,
        filter: filter,
        effect: effect,
      ),
    );
