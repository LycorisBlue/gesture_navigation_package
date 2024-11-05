import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/gesture_navigation_controller.dart';
import '../models/page_transition_model.dart';
import '../enums/swipe_direction.dart';

class GestureWrapper extends StatelessWidget {
  final Widget centerPage;
  final Widget? topPage;
  final Widget? bottomPage;
  final Widget? leftPage;
  final Widget? rightPage;

  final double swipeThreshold;
  final Duration animationDuration;

  GestureWrapper({
    Key? key,
    required this.centerPage,
    this.topPage,
    this.bottomPage,
    this.leftPage,
    this.rightPage,
    this.swipeThreshold = 0.3,
    this.animationDuration = const Duration(milliseconds: 300),
  }) : super(key: key) {
    // Initialiser le contrôleur si ce n'est pas déjà fait
    final controller = Get.put(GestureNavigationController());

    // Configurer les pages disponibles
    if (topPage != null) {
      controller.setPageForDirection(SwipeDirection.up, topPage!);
    }
    if (bottomPage != null) {
      controller.setPageForDirection(SwipeDirection.down, bottomPage!);
    }
    if (leftPage != null) {
      controller.setPageForDirection(SwipeDirection.left, leftPage!);
    }
    if (rightPage != null) {
      controller.setPageForDirection(SwipeDirection.right, rightPage!);
    }

    // Initialiser la page centrale
    controller.initializeWithCenterPage(centerPage);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GestureNavigationController>();

    return GestureDetector(
      onPanStart: (details) {
        controller.onSwipeStart(details.localPosition);
      },
      onPanUpdate: (details) {
        controller.onSwipeUpdate(details.localPosition);
      },
      onPanEnd: (details) {
        controller.onSwipeEnd();
      },
      child: Obx(() {
        final state = controller.transitionState;

        return Stack(
          children: [
            // Page actuelle
            _buildTransformedPage(
              state.currentPage,
              state.transform ?? Matrix4.identity(),
            ),

            // Page cible (si en transition)
            if (state.isTransitioning && state.targetPage != null)
              _buildTransformedPage(
                state.targetPage!,
                _calculateTargetPageTransform(state),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildTransformedPage(Widget page, Matrix4 transform) {
    return Positioned.fill(
      child: AnimatedContainer(
        duration: animationDuration,
        transform: transform,
        child: page,
      ),
    );
  }

  Matrix4 _calculateTargetPageTransform(PageTransitionModel state) {
    final progress = state.progress;
    final direction = state.direction;

    switch (direction) {
      case SwipeDirection.left:
        return Matrix4.translationValues(
          MediaQuery.of(Get.context!).size.width * (1 - progress),
          0,
          0,
        );
      case SwipeDirection.right:
        return Matrix4.translationValues(
          MediaQuery.of(Get.context!).size.width * (-1 + progress),
          0,
          0,
        );
      case SwipeDirection.up:
        return Matrix4.translationValues(
          0,
          MediaQuery.of(Get.context!).size.height * (1 - progress),
          0,
        );
      case SwipeDirection.down:
        return Matrix4.translationValues(
          0,
          MediaQuery.of(Get.context!).size.height * (-1 + progress),
          0,
        );
      case SwipeDirection.none:
        return Matrix4.identity();
    }
  }
}
