enum SwipeDirection {
  up,
  down,
  left,
  right,
  none;

  bool get isHorizontal => this == left || this == right;
  bool get isVertical => this == up || this == down;
  
  SwipeDirection get opposite {
    switch (this) {
      case SwipeDirection.up:
        return SwipeDirection.down;
      case SwipeDirection.down:
        return SwipeDirection.up;
      case SwipeDirection.left:
        return SwipeDirection.right;
      case SwipeDirection.right:
        return SwipeDirection.left;
      case SwipeDirection.none:
        return SwipeDirection.none;
    }
  }

  static SwipeDirection fromOffset(double dx, double dy) {
    if (dx.abs() > dy.abs()) {
      if (dx > 0) {
        return SwipeDirection.right;
      } else {
        return SwipeDirection.left;
      }
    } else if (dy.abs() > dx.abs()) {
      if (dy > 0) {
        return SwipeDirection.down;
      } else {
        return SwipeDirection.up;
      }
    }
    return SwipeDirection.none;
  }
}