import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routeStackPod = StateProvider<List<Route>>((ref) => <Route>[]);
