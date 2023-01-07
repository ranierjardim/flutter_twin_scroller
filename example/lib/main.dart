import 'package:flutter/material.dart';
import 'package:flutter_twin_scroller/flutter_twin_scroller.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'TwinScroller Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final verticalTwinScrollController = TwinScrollController();
  final verticalScrollController1 = ScrollController();
  final verticalScrollController2 = ScrollController();

  final horizontalTwinScrollController = TwinScrollController();
  final horizontalScrollController1 = ScrollController();
  final horizontalScrollController2 = ScrollController();
  final horizontalScrollController3 = ScrollController();

  int stackIndex = 0;
  int _counter = 20;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: IndexedStack(
        index: stackIndex,
        children: [
          Column(
            children: [
              TwinScroller(
                controller: horizontalTwinScrollController,
                childScrollController: horizontalScrollController1,
                child: Container(
                  height: 60,
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.3),
                  child: ListView.builder(
                    controller: horizontalScrollController1,
                    itemCount: _counter,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.3),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TwinScroller(
                        controller: verticalTwinScrollController,
                        childScrollController: verticalScrollController1,
                        child: Container(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(0.3),
                          child: ListView.builder(
                            controller: verticalScrollController1,
                            itemCount: _counter,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Item: $index',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: TwinScroller(
                        controller: verticalTwinScrollController,
                        childScrollController: verticalScrollController2,
                        child: Container(
                          color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                  .toInt())
                              .withOpacity(0.1),
                          child: ListView.builder(
                            controller: verticalScrollController2,
                            itemCount: _counter,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Item: $index',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              TwinScroller(
                controller: horizontalTwinScrollController,
                childScrollController: horizontalScrollController2,
                child: Container(
                  height: 60,
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.3),
                  child: ListView.builder(
                    controller: horizontalScrollController2,
                    itemCount: _counter,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.3),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              TwinScroller(
                controller: horizontalTwinScrollController,
                childScrollController: horizontalScrollController3,
                child: Container(
                  height: 60,
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(0.3),
                  child: ListView.builder(
                    controller: horizontalScrollController3,
                    itemCount: _counter,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Color(
                                (math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.3),
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
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        child: const Text(
                          'Open Multiple TwinScrollers Page',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          horizontalTwinScrollController.holdPositions();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ThreeTwinScrollerScreen(
                                      horizontalTwinScrollController:
                                          horizontalTwinScrollController,
                                    )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: stackIndex,
        onTap: (index) {
          setState(() {
            stackIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_list,
            ),
            label: 'Dual List',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_list,
            ),
            label: 'Counter',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_list,
            ),
            label: 'Multiple Page',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This tr
    );
  }
}

class ThreeTwinScrollerScreen extends StatefulWidget {
  final TwinScrollController horizontalTwinScrollController;

  const ThreeTwinScrollerScreen(
      {Key? key, required this.horizontalTwinScrollController})
      : super(key: key);

  @override
  State<ThreeTwinScrollerScreen> createState() =>
      _ThreeTwinScrollerScreenState();
}

class _ThreeTwinScrollerScreenState extends State<ThreeTwinScrollerScreen> {
  final horizontalScrollController1 = ScrollController();
  final int _counter = 20;
  final verticalTwinScrollController = TwinScrollController();
  final verticalScrollController1 = ScrollController();
  final verticalScrollController2 = ScrollController();
  final verticalScrollController3 = ScrollController();
  final verticalScrollController4 = ScrollController();
  final verticalScrollController5 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multiple TwinScroller Scrolls'),
      ),
      body: Column(
        children: [
          TwinScroller(
            controller: widget.horizontalTwinScrollController,
            childScrollController: horizontalScrollController1,
            child: Container(
              height: 60,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(0.3),
              child: ListView.builder(
                controller: horizontalScrollController1,
                itemCount: _counter,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    color:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(0.3),
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
                    ),
                  );
                },
              ),
            ),
          ),
          Flexible(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TwinScroller(
                    controller: verticalTwinScrollController,
                    childScrollController: verticalScrollController1,
                    child: Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(0.3),
                      child: ListView.builder(
                        controller: verticalScrollController1,
                        itemCount: _counter,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 9.0, horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Item: $index',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TwinScroller(
                    controller: verticalTwinScrollController,
                    childScrollController: verticalScrollController2,
                    child: Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(0.1),
                      child: ListView.builder(
                        controller: verticalScrollController2,
                        itemCount: _counter,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Item: $index',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TwinScroller(
                    controller: verticalTwinScrollController,
                    childScrollController: verticalScrollController3,
                    child: Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(0.1),
                      child: ListView.builder(
                        controller: verticalScrollController3,
                        itemCount: _counter,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 11.0, horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Item: $index',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TwinScroller(
                    controller: verticalTwinScrollController,
                    childScrollController: verticalScrollController4,
                    child: Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(0.1),
                      child: ListView.builder(
                        controller: verticalScrollController4,
                        itemCount: _counter,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Item: $index',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: TwinScroller(
                    controller: verticalTwinScrollController,
                    childScrollController: verticalScrollController5,
                    child: Container(
                      color:
                          Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                              .withOpacity(0.1),
                      child: ListView.builder(
                        controller: verticalScrollController5,
                        itemCount: _counter,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withOpacity(0.3),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 8.0),
                              child: Row(
                                children: [
                                  Text(
                                    'Item: $index',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
