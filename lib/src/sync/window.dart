// Copyright 2015 Google Inc. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:math' show Point, Rectangle;

import 'common.dart';
import 'web_driver.dart';

class Window {
  final WebDriver _driver;
  final Resolver _resolver;

  final String handle;

  Window(this._driver, this.handle) :
        _resolver = new Resolver(_driver, 'window/$handle');

  /// The size of this window.
  Rectangle<int> get size {
    var size = _resolver.get('size');
    return new Rectangle<int>(
        0, 0, size['width'].toInt(), size['height'].toInt());
  }

  /// The location of this window.
  Point<int> get location {
    var point = _resolver.get('position');
    return new Point<int>(point['x'].toInt(), point['y'].toInt());
  }

  /// Maximize this window.
  void maximize() {
    _resolver.post('maximize');
  }

  /// Set this window size.
  void setSize(Rectangle<int> size) {
    _resolver.post('size', {'width': size.width.toInt(), 'height': size.height.toInt()});
  }

  /// Set this window location.
  void setLocation(Point<int> point) {
    _resolver.post('position', {'x': point.x.toInt(), 'y': point.y.toInt()});
  }

  @override
  int get hashCode => handle.hashCode * 3 + _driver.hashCode;

  @override
  bool operator ==(other) =>
      other is Window &&
      other._driver == this._driver &&
      other.handle == this.handle;

  @override
  String toString() => '$_driver.windows[$handle]';
}