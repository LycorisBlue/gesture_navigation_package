import 'package:flutter/material.dart';
import '../enums/swipe_direction.dart';

class PageTransitionModel {
  /// Page actuelle
  final Widget currentPage;

  /// Page vers laquelle on transite
  final Widget? targetPage;

  /// Direction du swipe
  final SwipeDirection direction;

  /// Progression de la transition (0.0 à 1.0)
  final double progress;

  /// Position de départ du geste
  final Offset startPosition;

  /// Si la transition est en cours
  final bool isTransitioning;

  /// Si la transition peut être effectuée dans cette direction
  final bool canTransition;

  const PageTransitionModel({
    required this.currentPage,
    this.targetPage,
    this.direction = SwipeDirection.none,
    this.progress = 0.0,
    this.startPosition = Offset.zero,
    this.isTransitioning = false,
    this.canTransition = true,
  });

  /// Crée une copie du modèle avec les nouvelles valeurs spécifiées
  PageTransitionModel copyWith({
    Widget? currentPage,
    Widget? targetPage,
    SwipeDirection? direction,
    double? progress,
    Offset? startPosition,
    bool? isTransitioning,
    bool? canTransition,
  }) {
    return PageTransitionModel(
      currentPage: currentPage ?? this.currentPage,
      targetPage: targetPage ?? this.targetPage,
      direction: direction ?? this.direction,
      progress: progress ?? this.progress,
      startPosition: startPosition ?? this.startPosition,
      isTransitioning: isTransitioning ?? this.isTransitioning,
      canTransition: canTransition ?? this.canTransition,
    );
  }

  /// Calcule la transformation à appliquer en fonction de la direction et de la progression
  Matrix4? get transform {
    if (!isTransitioning || direction == SwipeDirection.none) return null;

    final value = progress;

    switch (direction) {
      case SwipeDirection.left:
        return Matrix4.translationValues(-value * 300, 0, 0);
      case SwipeDirection.right:
        return Matrix4.translationValues(value * 300, 0, 0);
      case SwipeDirection.up:
        return Matrix4.translationValues(0, -value * 300, 0);
      case SwipeDirection.down:
        return Matrix4.translationValues(0, value * 300, 0);
      case SwipeDirection.none:
        return null;
    }
  }

  /// Détermine si la transition est suffisamment avancée pour être complétée
  bool get shouldComplete => progress.abs() > 0.5;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageTransitionModel &&
          runtimeType == other.runtimeType &&
          currentPage == other.currentPage &&
          targetPage == other.targetPage &&
          direction == other.direction &&
          progress == other.progress &&
          startPosition == other.startPosition &&
          isTransitioning == other.isTransitioning &&
          canTransition == other.canTransition;

  @override
  int get hashCode =>
      currentPage.hashCode ^
      targetPage.hashCode ^
      direction.hashCode ^
      progress.hashCode ^
      startPosition.hashCode ^
      isTransitioning.hashCode ^
      canTransition.hashCode;
}
