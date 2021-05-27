import 'package:flutter/material.dart';

import 'callback.dart';

///This class is inspired from SWR in React
///[FutureManager] is a wrap around [Future] and [ChangeNotifier]
///
///[FutureManager] use [FutureManagerBuilder] instead of FutureBuilder to handle data
///
///[FutureManager] provide a method [asyncOperation] to handle or call async function
class FutureManager<T> extends ChangeNotifier {
  ///A future function that return the type of T
  final FutureFunction<T>? futureFunction;

  /// A function that call after [asyncOperation] is success and you want to manipulate data before
  /// adding it to manager
  final SuccessCallBack<T>? onSuccess;

  /// A function that call after everything is done
  final VoidCallback? onDone;

  /// A function that call after there is an error in our [asyncOperation]
  final ErrorCallBack? onError;

  /// if [reloading] is true, every time there's a new data, FutureManager will reset it's state to loading
  /// default value is [false]
  final bool reloading;

  ///Create a FutureManager instance, You can define a [futureFunction] here then [asyncOperation] will be call immediately
  FutureManager(
      {this.futureFunction,
      this.reloading = true,
      this.onSuccess,
      this.onDone,
      this.onError}) {
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

  ///
  bool _isLoading = true;
  T? _data;
  dynamic _error;

  T? get data => _data;

  dynamic get error => _error;

  ///
  bool get hasData => _data != null;

  bool get hasError => _error != null;

  ///The Future that this class is doing in [asyncOperation]
  ///Sometime you want to use [FutureManager] class with FutureBuilder, so you can use this field
  Future<T>? future;

  ///refresh is a function that call [asyncOperation] again,
  ///return null if [futureFunction] hasn't been initialize
  Future<T?> Function({
    bool? reloading,
    SuccessCallBack<T>? onSuccess,
    VoidCallback? onDone,
    ErrorCallBack? onError,
    bool? throwError,
  }) refresh = ({reloading, onSuccess, onDone, onError, throwError}) async {
    print(
        "refresh is depend on AsyncOperation, You need to call asyncOperation once before you can call refresh");
    return null;
  };

  Future<T?> asyncOperation(
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
      bool? shouldThrowError = throwError ?? false;
      //
      bool triggerError = true;
      if (hasData) {
        triggerError = shouldReload;
      }
      try {
        if (shouldReload) resetData();
        future = futureFunction.call();
        T result = await future!;
        if (successCallBack != null) {
          result = await successCallBack.call(result);
        }
        _data = result;
        return result;
      } catch (exception) {
        if (triggerError) _error = exception;
        errorCallBack?.call(exception);
        if (shouldThrowError) {
          throw exception;
        }
        return null;
      } finally {
        toggleLoading();
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

  void toggleLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void update([T? data]) {
    if (data != null) {
      _data = data;
    }
    notifyListeners();
  }

  void resetData() {
    _isLoading = true;
    _error = null;
    _data = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _data = null;
    super.dispose();
  }
}
