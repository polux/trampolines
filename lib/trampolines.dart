// Copyright (c) 2012, Google Inc. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

// Author: Paul Brauner (polux@google.com)

library trampolines;

abstract class TailRec<A> {
  A compute() {
    TailRec<A> res = this;
    while (!res._isDone) {
      final _Bounce<A> bounce = res;
      res = bounce.continuation();
    }
    _Done done = res;
    return done.value;
  }
  bool get _isDone;
}

class _Done<A> extends TailRec<A> {
  final A value;
  final bool _isDone = true;
  _Done(this.value);
}

class _Bounce<A> extends TailRec<A> {
  final Function continuation;
  final bool _isDone = false;
  _Bounce(TailRec<A> continuation())
      : this.continuation = continuation;
}

TailRec done(x) => new _Done(x);
TailRec tailcall(TailRec continuation()) => new _Bounce(continuation);
