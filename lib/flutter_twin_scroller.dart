library flutter_twin_scroller;

import 'package:flutter/material.dart';

class TwinScrollerController {
  final ScrollController controller;
  final Widget child;
  final void Function(TwinScrollerController sender, double pixels) setScrollerPixelsPosition;
  final void Function(TwinScrollerController sender, bool enable) setCurrentScrollerOutOfBounds;

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

class TwinScrollController {
  final List<TwinScrollerController> scrollerControllers = [];

  TwinScrollerController? currentScroller;
  TwinScrollerController? currentScrollerOutOfBounds;
  TwinScrollerController? latestScroller;
  double currentPosition = 0;

  void addScrollerController(ScrollController scrollController, Widget child) {
    scrollController.position.jumpTo(currentPosition);
    scrollerControllers.add(TwinScrollerController(scrollController, child, setScrollerPixelsPosition, setCurrentScrollerOutOfBounds));
  }

  void removeScrollerController(ScrollController scrollController) {
    final List<TwinScrollerController> toRemove = [];
    for (final controller in scrollerControllers) {
      if (controller.controller == scrollController) {
        toRemove.add(controller);
      }
    }
    scrollerControllers.removeWhere((currentController) => toRemove.contains(currentController));
  }

  void setScrollerPixelsPosition(TwinScrollerController sender, double pixels) {
    if ((sender == currentScrollerOutOfBounds || currentScrollerOutOfBounds == null) && currentScroller == null) {
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
    if (sender != currentScrollerOutOfBounds && currentScrollerOutOfBounds != null && sender.controller.hasClients && currentScrollerOutOfBounds!.controller.hasClients) {
      sender.controller.position.jumpTo(currentScrollerOutOfBounds!.controller.position.pixels);
    }
  }

  void setCurrentScrollerOutOfBounds(TwinScrollerController sender, bool enable) {
    if(latestScroller == sender) {
      if (enable && currentScrollerOutOfBounds == null) {
        currentScrollerOutOfBounds = sender;
      }
    }
    if (!enable) {
      currentScrollerOutOfBounds = null;
    }
  }

  void holdPositions() {
    if(latestScroller?.controller.hasClients ?? false) {
      if(latestScroller!.controller.position.outOfRange) {
        latestScroller?.controller.position.jumpTo(latestScroller!.controller.position.maxScrollExtent);
      } else {
        latestScroller?.controller.position.jumpTo(latestScroller!.controller.position.pixels);
      }
    }

  }
}

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
    WidgetsBinding.instance!.addPostFrameCallback((_) => widget.controller.addScrollerController(widget.childScrollController, widget.child));
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
