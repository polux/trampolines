// Copyright 2012 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
    print("You should have used dart-trampolines!");
  }
}
