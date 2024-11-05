import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/page_transition_model.dart';
import '../enums/swipe_direction.dart';

class GestureNavigationController extends GetxController {
  // État observable pour la transition de page
  final _transitionState = PageTransitionModel(
    currentPage: Container(),
  ).obs;

  // Getters pour l'état de transition
  PageTransitionModel get transitionState => _transitionState.value;

  // Map des pages disponibles pour chaque direction
  final Map<SwipeDirection, Widget?> _availablePages = {
    SwipeDirection.up: null,
    SwipeDirection.down: null,
    SwipeDirection.left: null,
    SwipeDirection.right: null,
  };

  // Configuration des pages pour chaque direction
  void setPageForDirection(SwipeDirection direction, Widget page) {
    _availablePages[direction] = page;
    update();
  }

  // Initialisation des pages
  void initializeWithCenterPage(Widget centerPage) {
    _transitionState.value = PageTransitionModel(currentPage: centerPage);
    update();
  }

  // Gestion du début du swipe
  void onSwipeStart(Offset position) {
    _transitionState.value = _transitionState.value.copyWith(
      startPosition: position,
      isTransitioning: true,
      progress: 0.0,
    );
  }

  // Gestion du swipe en cours
  void onSwipeUpdate(Offset position) {
    final direction = SwipeDirection.fromOffset(
      position.dx - _transitionState.value.startPosition.dx,
      position.dy - _transitionState.value.startPosition.dy,
    );

    // Vérifier si la page est disponible dans cette direction
    final targetPage = _availablePages[direction];
    if (targetPage == null) return;

    // Calculer la progression du swipe
    double progress;
    if (direction.isHorizontal) {
      progress = (position.dx - _transitionState.value.startPosition.dx) / 300;
    } else {
      progress = (position.dy - _transitionState.value.startPosition.dy) / 300;
    }

    // Mettre à jour l'état
    _transitionState.value = _transitionState.value.copyWith(
      direction: direction,
      targetPage: targetPage,
      progress: progress.clamp(-1.0, 1.0),
    );
  }

  // Gestion de la fin du swipe
  Future<void> onSwipeEnd() async {
    if (!_transitionState.value.isTransitioning) return;

    final shouldComplete = _transitionState.value.shouldComplete;
    final direction = _transitionState.value.direction;

    if (shouldComplete && _availablePages[direction] != null) {
      // Compléter la transition
      await _animateTransition(1.0);
      _transitionState.value = PageTransitionModel(
        currentPage: _transitionState.value.targetPage!,
      );
    } else {
      // Annuler la transition
      await _animateTransition(0.0);
      _transitionState.value = PageTransitionModel(
        currentPage: _transitionState.value.currentPage,
      );
    }
  }

  // Animation de la transition
  Future<void> _animateTransition(double target) async {
    final start = _transitionState.value.progress;
    final controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: navigator!.overlay!,
    );

    final animation = Tween(
      begin: start,
      end: target,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    ));

    animation.addListener(() {
      _transitionState.value = _transitionState.value.copyWith(
        progress: animation.value,
      );
    });

    try {
      await controller.forward();
    } finally {
      controller.dispose();
    }
  }

  // Vérifier si une direction est autorisée
  bool isDirectionAllowed(SwipeDirection direction) {
    return _availablePages[direction] != null;
  }
}
