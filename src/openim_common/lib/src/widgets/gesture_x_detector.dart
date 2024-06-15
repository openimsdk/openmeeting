library gesture_x_detector;

import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math.dart' as vector;

///  A widgets that detects gestures.
/// * Supports Tap, DoubleTap, Move(start, update, end), Scale(start, update, end) and Long Press
/// * All callbacks be used simultaneously
///
/// For handle rotate event, please use rotateAngle on onScaleUpdate.
class XGestureDetector extends StatefulWidget {
  /// Creates a widgets that detects gestures.
  const XGestureDetector(
      {super.key,
      required this.child,
      this.onTap,
      this.onMoveUpdate,
      this.onMoveEnd,
      this.onMoveStart,
      this.onScaleStart,
      this.onScaleUpdate,
      this.onScaleEnd,
      this.onDoubleTap,
      this.onPointerDown,
      this.onScrollEvent,
      this.bypassMoveEventAfterLongPress = true,
      this.bypassTapEventOnDoubleTap = false,
      this.doubleTapTimeConsider = 250,
      this.longPressTimeConsider = 350,
      this.onLongPress,
      this.onLongPressMove,
      this.onLongPressEnd,
      this.behavior = HitTestBehavior.deferToChild,
      this.longPressMaximumRangeAllowed = 25});

  /// The widgets below this widgets in the tree.
  ///
  /// {@macro flutter.meeting.child}
  final Widget child;

  /// a flag to enable/disable tap event when double tap event occurs.
  ///
  /// By default it is false, that mean when user double tap on screen: it will trigge 1 double tap event and 2 single tap events
  final bool bypassTapEventOnDoubleTap;

  ///  by default it is true, means after receive long press event without release pointer (finger still touch on screen)
  /// the move event will be ignore.
  ///
  /// set it to false in case you expect move event will be fire after long press event
  ///
  final bool bypassMoveEventAfterLongPress;

  /// A specific duration to detect double tap
  final int doubleTapTimeConsider;

  /// The pointer that previously triggered the onTapDown has also triggered onTapUp which ends up causing a tap.
  final TapEventListener? onTap;

  /// A pointer has contacted the screen with a primary button and has begun to
  /// move.
  final MoveEventListener? onMoveStart;

  /// A pointer that is in contact with the screen with a primary button and
  /// made a move
  final MoveEventListener? onMoveUpdate;

  /// A pointer that was previously in contact with the screen with a primary
  /// button and moving is no longer in contact with the screen and was moving
  /// at a specific velocity when it stopped contacting the screen.
  final MoveEventListener? onMoveEnd;

  /// The pointers in contact with the screen have established a focal point and
  /// initial scale of 1.0.
  final void Function(Offset initialFocusPoint)? onScaleStart;

  /// The pointers in contact with the screen have indicated a new focal point
  /// and/or scale.
  final ScaleEventListener? onScaleUpdate;

  /// The pointers are no longer in contact with the screen.
  final void Function()? onScaleEnd;

  /// The user has tapped the screen at the same location twice in quick succession.
  final TapEventListener? onDoubleTap;

  /// A pointer has remained in contact with the screen at the same location for a long period of time
  final TapEventListener? onLongPress;

  /// The pointer in the long press state and then made a move
  final MoveEventListener? onLongPressMove;

  /// The pointer are no longer in contact with the screen after onLongPress event.
  final Function()? onLongPressEnd;

  /// The callback for scroll event
  final Function(ScrollEvent event)? onScrollEvent;

  /// A specific duration to detect long press
  final int longPressTimeConsider;

  /// How to behave during hit testing.
  final HitTestBehavior behavior;

  /// The maxium distance between the first touching position and the position when the long press event occurs.
  /// default: distanceSquared =  25
  final int longPressMaximumRangeAllowed;

  final Function(PointerDownEvent event)? onPointerDown;

  @override
  State<XGestureDetector> createState() => _XGestureDetectorState();
}

enum _GestureState { PointerDown, MoveStart, ScaleStart, Scalling, LongPress, Unknown }

class _XGestureDetectorState extends State<XGestureDetector> {
  List<_Touch> touches = [];
  double initialScaleDistance = 1.0;
  _GestureState state = _GestureState.Unknown;
  Timer? doubleTapTimer;
  Timer? longPressTimer;
  Offset lastTouchUpPos = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: widget.behavior,
      onPointerDown: onPointerDown,
      onPointerUp: onPointerUp,
      onPointerMove: onPointerMove,
      onPointerCancel: onPointerUp,
      onPointerSignal: onPointerSignal,
      child: widget.child,
    );
  }

  void onPointerSignal(PointerSignalEvent event) {
    if (event is PointerScrollEvent) {
      widget.onScrollEvent?.call(ScrollEvent(event.pointer, event.localPosition, event.position, event.scrollDelta));
    }
  }

  void onPointerDown(PointerDownEvent event) {
    widget.onPointerDown?.call(event);
    touches.add(_Touch(event.pointer, event.localPosition));

    if (touchCount == 1) {
      state = _GestureState.PointerDown;
      startLongPressTimer(TapEvent.from(event));
    } else if (touchCount == 2) {
      state = _GestureState.ScaleStart;
    } else {
      state = _GestureState.Unknown;
    }
  }

  void initScaleAndRotate() {
    initialScaleDistance = (touches[0].currentOffset - touches[1].currentOffset).distance;
  }

  void onPointerMove(PointerMoveEvent event) {
    final touch = touches.firstWhere((touch) => touch.id == event.pointer);
    touch.currentOffset = event.localPosition;
    cleanupDoubleTimer();

    switch (state) {
      case _GestureState.LongPress:
        if (widget.bypassMoveEventAfterLongPress) {
          widget.onLongPressMove
              ?.call(MoveEvent(event.localPosition, event.position, event.pointer, delta: event.delta, localDelta: event.localDelta));
        } else {
          switch2MoveStartState(touch, event);
        }
        break;
      case _GestureState.PointerDown:
        switch2MoveStartState(touch, event);
        break;
      case _GestureState.MoveStart:
        widget.onMoveUpdate?.call(MoveEvent(event.localPosition, event.position, event.pointer, delta: event.delta, localDelta: event.localDelta));
        break;
      case _GestureState.ScaleStart:
        touch.startOffset = touch.currentOffset;
        state = _GestureState.Scalling;
        initScaleAndRotate();
        if (widget.onScaleStart != null) {
          final centerOffset = (touches[0].currentOffset + touches[1].currentOffset) / 2;
          widget.onScaleStart!(centerOffset);
        }
        break;
      case _GestureState.Scalling:
        if (widget.onScaleUpdate != null) {
          var rotation = angleBetweenLines(touches[0], touches[1]);
          final newDistance = (touches[0].currentOffset - touches[1].currentOffset).distance;
          final centerOffset = (touches[0].currentOffset + touches[1].currentOffset) / 2;

          widget.onScaleUpdate!(ScaleEvent(centerOffset, newDistance / initialScaleDistance, rotation));
        }
        break;
      default:
        touch.startOffset = touch.currentOffset;
        break;
    }
  }

  void switch2MoveStartState(_Touch touch, PointerMoveEvent event) {
    state = _GestureState.MoveStart;
    touch.startOffset = event.localPosition;
    widget.onMoveStart?.call(MoveEvent(event.localPosition, event.localPosition, event.pointer));
  }

  double angleBetweenLines(_Touch f, _Touch s) {
    double angle1 = math.atan2(f.startOffset.dy - s.startOffset.dy, f.startOffset.dx - s.startOffset.dx);
    double angle2 = math.atan2(f.currentOffset.dy - s.currentOffset.dy, f.currentOffset.dx - s.currentOffset.dx);

    double angle = vector.degrees(angle1 - angle2) % 360;
    if (angle < -180.0) angle += 360.0;
    if (angle > 180.0) angle -= 360.0;
    return vector.radians(angle);
  }

  void onPointerUp(PointerEvent event) {
    touches.removeWhere((touch) => touch.id == event.pointer);

    if (state == _GestureState.PointerDown) {
      if (!widget.bypassTapEventOnDoubleTap || widget.onDoubleTap == null) {
        callOnTap(TapEvent.from(event));
      }
      if (widget.onDoubleTap != null) {
        final tapEvent = TapEvent.from(event);
        if (doubleTapTimer == null) {
          startDoubleTapTimer(tapEvent);
        } else {
          cleanupTimer();
          if ((event.localPosition - lastTouchUpPos).distanceSquared < 200) {
            widget.onDoubleTap!(tapEvent);
          } else {
            startDoubleTapTimer(tapEvent);
          }
        }
      }
    } else if (state == _GestureState.ScaleStart || state == _GestureState.Scalling) {
      state = _GestureState.Unknown;
      widget.onScaleEnd?.call();
    } else if (state == _GestureState.MoveStart) {
      state = _GestureState.Unknown;
      widget.onMoveEnd?.call(MoveEvent(event.localPosition, event.position, event.pointer));
    } else if (state == _GestureState.LongPress) {
      widget.onLongPressEnd?.call();
      state = _GestureState.Unknown;
    } else if (state == _GestureState.Unknown && touchCount == 2) {
      state = _GestureState.ScaleStart;
    } else {
      state = _GestureState.Unknown;
    }

    lastTouchUpPos = event.localPosition;
  }

  void startLongPressTimer(TapEvent event) {
    if (widget.onLongPress != null) {
      if (longPressTimer != null) {
        longPressTimer!.cancel();
        longPressTimer = null;
      }
      longPressTimer = Timer(Duration(milliseconds: widget.longPressTimeConsider), () {
        if (touchCount == 1 && touches[0].id == event.pointer && inLongPressRange(touches[0])) {
          state = _GestureState.LongPress;
          widget.onLongPress!(event);
          cleanupTimer();
        }
      });
    }
  }

  bool inLongPressRange(_Touch touch) {
    return (touch.currentOffset - touch.startOffset).distanceSquared < widget.longPressMaximumRangeAllowed;
  }

  void startDoubleTapTimer(TapEvent event) {
    doubleTapTimer = Timer(Duration(milliseconds: widget.doubleTapTimeConsider), () {
      state = _GestureState.Unknown;
      cleanupTimer();
      if (widget.bypassTapEventOnDoubleTap) {
        callOnTap(event);
      }
    });
  }

  void cleanupTimer() {
    cleanupDoubleTimer();
    if (longPressTimer != null) {
      longPressTimer!.cancel();
      longPressTimer = null;
    }
  }

  void cleanupDoubleTimer() {
    if (doubleTapTimer != null) {
      doubleTapTimer!.cancel();
      doubleTapTimer = null;
    }
  }

  void callOnTap(TapEvent event) {
    if (widget.onTap != null) {
      widget.onTap!(event);
    }
  }

  get touchCount => touches.length;
}

class _Touch {
  int id;
  Offset startOffset;
  late Offset currentOffset;

  _Touch(this.id, this.startOffset) {
    this.currentOffset = startOffset;
  }
}

/// The pointer has moved with respect to the device while the pointer is in
/// contact with the device.
///
/// See also:
///
///  * [XGestureDetector.onMoveUpdate], which allows callers to be notified of these
///    events in a widgets tree.
///  * [XGestureDetector.onMoveStart], which allows callers to be notified for the first time this event occurs
///  * [XGestureDetector.onMoveEnd], which allows callers to be notified after the last move event occurs.
@immutable
class MoveEvent extends TapEvent {
  /// The [delta] transformed into the event receiver's local coordinate
  /// system according to [transform].
  ///
  /// If this event has not been transformed, [delta] is returned as-is.
  ///
  /// See also:
  ///
  ///  * [delta], which is the distance the pointer moved in the global
  ///    coordinate system of the screen.
  final Offset localDelta;

  /// Distance in logical pixels that the pointer moved since the last
  /// [MoveEvent].
  ///
  /// See also:
  ///
  ///  * [localDelta], which is the [delta] transformed into the local
  ///    coordinate space of the event receiver.
  final Offset delta;

  const MoveEvent(
    Offset localPos,
    Offset position,
    int pointer, {
    this.localDelta = const Offset(0, 0),
    this.delta = const Offset(0, 0),
  }) : super(localPos, position, pointer);
}

/// The pointer  has made a move.
///
/// See also:
///
///  * [XGestureDetector.onMoveUpdate], which allows callers to be notified of these
///    events in a widgets tree.
@immutable
class TapEvent {
  /// Unique identifier for the pointer, not reused. Changes for each new
  /// pointer down event.
  final int pointer;

  /// The [position] transformed into the event receiver's local coordinate
  /// system according to [transform].
  ///
  /// If this event has not been transformed, [position] is returned as-is.
  /// See also:
  ///
  ///  * [position], which is the position in the global coordinate system of
  ///    the screen.
  final Offset localPos;

  /// Coordinate of the position of the pointer, in logical pixels in the global
  /// coordinate space.
  ///
  /// See also:
  ///
  ///  * [localPosition], which is the [position] transformed into the local
  ///    coordinate system of the event receiver.
  final Offset position;

  const TapEvent(this.localPos, this.position, this.pointer);

  static from(PointerEvent event) {
    return TapEvent(event.localPosition, event.position, event.pointer);
  }
}

/// Two pointers has made contact with the device.
///
/// See also:
///
///  * [XGestureDetector.onScaleUpdate], which allows callers to be notified of these
///    events in a widgets tree.
@immutable
class ScaleEvent {
  /// the middle point between 2 pointers(causes by 2 touching fingers)
  final Offset focalPoint;

  /// The delta distances of 2 pointers between the current and the previous
  final double scale;

  /// the rotate angle in radians - using for rotate
  final double rotationAngle;

  const ScaleEvent(this.focalPoint, this.scale, this.rotationAngle);
}

/// The pointer issued a scroll event.
///
/// Scrolling the scroll wheel on a mouse is an example of an event that
/// would create a [XGestureDetector.ScrollEvent]
///
/// See also: [PointerScrollEvent].
///
/// 1. To use this event for scalling, we can use localPos as the focal point
/// and scrollDelta.distance to get the scale value, scrollDelta.direction to get the direction
/// 2. To use this event for scroll, just use scrollDelta (e.g: currentPosition += scrollDelta)
@immutable
class ScrollEvent {
  /// the pointer id
  final int pointer;

  /// The [position] transformed into the event receiver's local coordinate
  /// system according to [transform].
  ///
  /// If this event has not been transformed, [position] is returned as-is.
  /// See also:
  ///
  ///  * [position], which is the position in the global coordinate system of
  ///    the screen.
  final Offset localPos;

  /// Coordinate of the position of the pointer, in logical pixels in the global
  /// coordinate space.
  ///
  /// See also:
  ///
  ///  * [localPosition], which is the [position] transformed into the local
  ///    coordinate system of the event receiver.
  final Offset position;

  /// The amount to scroll, in logical pixels.
  final Offset scrollDelta;

  const ScrollEvent(this.pointer, this.localPos, this.position, this.scrollDelta);
}

/// Signature for listening to [ScaleEvent] events.
///
/// Used by [XGestureDetector].
typedef ScaleEventListener = void Function(ScaleEvent event);

/// Signature for listening to [TapEvent] events.
///
/// Used by [XGestureDetector].
typedef TapEventListener = void Function(TapEvent event);

/// Signature for listening to [MoveEvent] events.
///
/// Used by [XGestureDetector].
typedef MoveEventListener = void Function(MoveEvent event);
