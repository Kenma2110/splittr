import 'dart:async';

import 'package:splittr/constants/env/env.dart';
import 'package:splittr/main.dart';

void main() {
  unawaited(mainCommon(Env.prod));
}
