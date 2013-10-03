# Trampolines for Tail Recursion

Two functions and one method: `tailcall`, `done`, and `compute`. This is no
rocket science but it is boilerplate code for the Dart functional programmer
that can be handy to have around as a library.

Note however that this is probably not the recommended way of programming in
Dart. This is still useful for porting libraries that make heavy use of mutual
tail recursion to Dart.

```dart
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
```

## Try it!

```
git clone https://github.com/polux/trampolines.git
cd trampolines
pub install
dart example/demo.dart
```
