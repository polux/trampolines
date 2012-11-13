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
  abstract bool get _isDone;
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
