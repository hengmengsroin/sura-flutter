import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'callback.dart';

///Previously call [BaseStream] or [BaseExtendBloc]
///[AsyncSubjectManager] is a wrap around bloc pattern that use [rxdart]
///[AsyncSubjectManager] provide a method [asyncOperation] to handle or call async function associated with rxdart's [BehaviorSubject]
///
class AsyncSubjectManager<T> {
  late final BehaviorSubject<T?> _controller;

  ///A future function that return the type of T
  final FutureFunction<T>? futureFunction;

  /// A function that call after [asyncOperation] is success
  final SuccessCallBack<T>? onSuccess;

  /// A function that call after everything is done
  final VoidCallback? onDone;

  /// A function that call after there is an error
  final ErrorCallBack? onError;

  /// if [reloading] is true, reload the controller to initial state
  final bool reloading;

  AsyncSubjectManager({this.futureFunction, this.reloading = true, this.onSuccess, this.onDone, this.onError}) {
    _controller = BehaviorSubject<T?>();
    if (futureFunction != null) {
      asyncOperation(
        futureFunction!,
        reloading: reloading,
        onSuccess: onSuccess,
        onDone: onDone,
        onError: onError,
      );
    }
  }

  ValueStream<T?> get stream => _controller.stream;

  bool get hasData => _controller.hasValue && _controller.value != null;

  T? get value => _controller.value;

  Future<T?> Function({
    bool? reloading,
    SuccessCallBack<T>? onSuccess,
    VoidCallback? onDone,
    ErrorCallBack? onError,
    bool? throwError,
  }) refresh = ({reloading, onSuccess, onDone, onError, throwError}) async {
    print("refresh is depend on AsyncOperation, You need to call asyncOperation once before you can call refresh");
    return null;
  };

  void addData(T? data) {
    if (!_controller.isClosed) _controller.add(data);
  }

  Future<T?>? asyncOperation(
    FutureFunction<T> futureFunction, {
    bool? reloading,
    SuccessCallBack<T>? onSuccess,
    VoidCallback? onDone,
    ErrorCallBack? onError,
    bool throwError = false,
  }) async {
    refresh = ({reloading, onSuccess, onDone, onError, throwError}) async {
      bool shouldReload = reloading ?? this.reloading;
      SuccessCallBack<T>? successCallBack = onSuccess ?? this.onSuccess;
      ErrorCallBack? errorCallBack = onError ?? this.onError;
      VoidCallback? onOperationDone = onDone ?? this.onDone;
      bool shouldThrowError = throwError ?? false;
      //
      bool triggerError = true;
      if (this._controller.hasValue) {
        triggerError = shouldReload;
      }
      try {
        if (shouldReload) this.addData(null);
        T data = await futureFunction.call();
        if (successCallBack != null) {
          data = await successCallBack.call(data);
        }
        this.addData(data);
        return data;
      } catch (exception) {
        errorCallBack?.call(exception);
        if (triggerError) this.addError(exception);
        if (shouldThrowError) {
          throw exception;
        }
        return null;
      } finally {
        onOperationDone?.call();
      }
    };
    return refresh(
      reloading: reloading,
      onSuccess: onSuccess,
      onDone: onDone,
      onError: onError,
      throwError: throwError,
    );
  }

  void addError(dynamic error) {
    if (!_controller.isClosed) {
      _controller.sink.addError(error);
    }
  }

  void dispose() async {
    _controller.close();
  }
}
