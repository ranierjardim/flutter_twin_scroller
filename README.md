# Flutter TwinScroll

A Flutter package to sync scroll position between multiple ScrollControllers

## iOS Demo

![Demo iOS Flutter TwinScroll](https://media.giphy.com/media/HwYyNDvffzzd8Efs8A/giphy.gif)

## Android Demo

![Demo Android Flutter TwinScroll](https://media.giphy.com/media/HfGo8GVX4GzNCH7Isj/giphy.gif)

## Features

- Sync ScrollController of different Widgets
- Sync ScrollController between pages
- Supports BouncingScrollPhysics (iOS) & ClampingScrollPhysics (Android) ScrollPhysics

## Requirements

- All the widgets that have a TwinScrollController binded must have the same scroll area (Same width if is horizontal or height if is vertical).

## Usage

1. Create the TwinScrollController

```dart
final twinScrollController = TwinScrollController();
```

2. Use the TwinScroller Widget to bind the ScrollController with the TwinScrollController

```dart
TwinScroller(
    controller: twinScrollController,
    childScrollController: scrollController,
    child: ListView.builder(
        controller: scrollController,
        itemCount: 20,
        itemBuilder: (context, index) {
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    children: [
                        Text(
                            'Item: $index',
                            style: const TextStyle(color: Colors.black),
                        )
                    ],
                ),
            );
        },
    ),
),
```

And all the ScrollControls that have the same TwinScrollController will be the same scroll position

## Additional information

Feel free to contribute, more info at GitHub