// Copyright (c) 2012, Google Inc. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Author: Paul Brauner (polux@google.com)

import 'package:trampolines/trampolines.dart';

class Defs {
  static odd(n) => n == 0 ? done(false) : tailcall(() => even(n-1));
  static even(n) => n == 0 ? done(true) : tailcall(() => odd(n-1));

  static badodd(n) => n == 0 ? false : badeven(n-1);
  static badeven(n) => n == 0 ? true : badodd(n-1);
}

main() {
  print(Defs.even(100000).compute());
  try {
    print(Defs.badeven(100000));
  } on StackOverflowError catch (_) {
    print("You should have used trampolines!");
  }
}
