library flutter_twin_scroller;

import 'package:flutter/material.dart';

///
/// Internal controller that manage the scroll events
///
class TwinScrollerController {
  final ScrollController controller;
  final Widget child;
  final void Function(TwinScrollerController sender, double pixels)
      setScrollerPixelsPosition;
  final void Function(TwinScrollerController sender, bool enable)
      setCurrentScrollerOutOfBounds;

  bool isOutOfBounds = false;

  TwinScrollerController(
    this.controller,
    this.child,
    this.setScrollerPixelsPosition,
    this.setCurrentScrollerOutOfBounds,
  ) {
    controller.position.addListener(_listener);
  }

  void _listener() {
    setScrollerPixelsPosition(this, controller.position.pixels);
    if (isOutOfBounds != controller.position.outOfRange) {
      isOutOfBounds = controller.position.outOfRange;
      setCurrentScrollerOutOfBounds(this, isOutOfBounds);
    }
  }
}

/// The controller that manage instances
class TwinScrollController {
  final List<TwinScrollerController> scrollerControllers = [];

  /// Current TwinScrollerController that triggering user scroll input
  TwinScrollerController? currentScroller;

  /// Current controller that is out of bounds (if is out of bounds)
  TwinScrollerController? currentScrollerOutOfBounds;

  /// Latest scroller that have a scroll
  TwinScrollerController? latestScroller;

  /// Latest/current scroll position
  double currentPosition = 0;

  /// Bind the ScrollController
  void addScrollerController(ScrollController scrollController, Widget child) {
    scrollController.position.jumpTo(currentPosition);
    scrollerControllers.add(TwinScrollerController(scrollController, child,
        _setScrollerPixelsPosition, _setCurrentScrollerOutOfBounds));
  }

  /// Must be called when the widget was disposed
  void removeScrollerController(ScrollController scrollController) {
    final List<TwinScrollerController> toRemove = [];
    for (final controller in scrollerControllers) {
      if (controller.controller == scrollController) {
        toRemove.add(controller);
      }
    }
    scrollerControllers.removeWhere(
        (currentController) => toRemove.contains(currentController));
  }

  void _setScrollerPixelsPosition(
      TwinScrollerController sender, double pixels) {
    if ((sender == currentScrollerOutOfBounds ||
            currentScrollerOutOfBounds == null) &&
        currentScroller == null) {
      latestScroller = sender;
      currentScroller = sender;
      currentPosition = pixels;
      for (final controller in scrollerControllers) {
        if (controller != sender && controller.controller.hasClients) {
          controller.controller.position.jumpTo(pixels);
        }
      }
      currentScroller = null;
    }
    if (sender != currentScrollerOutOfBounds &&
        currentScrollerOutOfBounds != null &&
        sender.controller.hasClients &&
        currentScrollerOutOfBounds!.controller.hasClients) {
      sender.controller.position
          .jumpTo(currentScrollerOutOfBounds!.controller.position.pixels);
    }
  }

  void _setCurrentScrollerOutOfBounds(
      TwinScrollerController sender, bool enable) {
    if (latestScroller == sender) {
      if (enable && currentScrollerOutOfBounds == null) {
        currentScrollerOutOfBounds = sender;
      }
    }
    if (!enable) {
      currentScrollerOutOfBounds = null;
    }
  }

  /// Use when open a new screen to prevent bricking
  void holdPositions() {
    if (latestScroller?.controller.hasClients ?? false) {
      if (latestScroller!.controller.position.outOfRange) {
        latestScroller?.controller.position
            .jumpTo(latestScroller!.controller.position.maxScrollExtent);
      } else {
        latestScroller?.controller.position
            .jumpTo(latestScroller!.controller.position.pixels);
      }
    }
  }
}

/// Use in every widget that have a ScrollController to
/// bind a ScrollController to a TwinScrollController
/// automatically
class TwinScroller extends StatefulWidget {
  final TwinScrollController controller;
  final ScrollController childScrollController;
  final Widget child;

  const TwinScroller({
    Key? key,
    required this.controller,
    required this.childScrollController,
    required this.child,
  }) : super(key: key);

  @override
  State<TwinScroller> createState() => _TwinScrollerState();
}

class _TwinScrollerState extends State<TwinScroller> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.controller
        .addScrollerController(widget.childScrollController, widget.child));
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.controller.removeScrollerController(widget.childScrollController);
    super.dispose();
  }
}
