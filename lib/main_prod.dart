import 'dart:async';

import 'package:splittr/constants/env/env.dart';
import 'package:splittr/main.dart';

Future<void> main() async {
  await mainCommon(Env.prod);
}
