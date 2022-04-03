import 'dart:async';

import 'package:flutter/material.dart';

typedef CustomErrorWidget = Widget Function(dynamic, Future<void> Function()?);

typedef AsyncCallback = FutureOr<void> Function();
