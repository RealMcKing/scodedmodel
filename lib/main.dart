import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScopedModel Widget',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScopedModel Widget'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ScopedModel<MyModel>(
            model: MyModel(),
            child: _AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class _AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: [
          Text(
            'Root Widget',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_Counter(), _Counter()],
          )
        ],
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MyModel>(
        rebuildOnChange: true,
        builder: (context, child, model) => Card(
              margin: EdgeInsets.all(4).copyWith(bottom: 32),
              color: Colors.yellowAccent,
              child: Column(
                children: [
                  Text('Children Widget'),
                  Text(
                    '${model.counterValue}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  ButtonBar(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          model._decrementCounter();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          model._incrementCounter();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }
}

class MyModel extends Model {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void _decrementCounter() {
    _counter--;
    notifyListeners();
  }
}
