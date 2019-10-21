import 'package:collision_check/collision_check.dart';
import 'package:collision_example/page/test_page.dart';
import 'package:collision_example/widget/complex_view.dart';
import 'package:collision_example/widget/rect_view.dart';
import 'package:collision_example/widget/circle_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "碰撞测试Demo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "碰撞测试Demo"),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildChooseItem(
            context,
            text: "矩形~矩形",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TestPage(
                  shapeA: RectView(color: Colors.blue),
                  shapeB: RectView(
                    color: Colors.orange,
                    initPosition: const CcOffset(200, 200),
                  ),
                );
              }));
            },
          ),
          _buildChooseItem(
            context,
            text: "矩形~圆形",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TestPage(
                  shapeA: RectView(color: Colors.blue),
                  shapeB: CircleView(
                    color: Colors.orange,
                    initPosition: const CcOffset(200, 200),
                  ),
                );
              }));
            },
          ),
          _buildChooseItem(
            context,
            text: "矩形~复杂图形",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TestPage(
                  shapeA: RectView(color: Colors.blue),
                  shapeB: ComplexView(
                    color: Colors.orange,
                    initPosition: const CcOffset(200, 200),
                  ),
                );
              }));
            },
          ),
          _buildChooseItem(
            context,
            text: "圆形~圆形",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TestPage(
                  shapeA: CircleView(color: Colors.blue),
                  shapeB: CircleView(
                    color: Colors.orange,
                    initPosition: const CcOffset(200, 200),
                  ),
                );
              }));
            },
          ),
          _buildChooseItem(
            context,
            text: "圆形~复杂图形",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TestPage(
                  shapeA: CircleView(color: Colors.blue),
                  shapeB: ComplexView(
                    color: Colors.orange,
                    initPosition: const CcOffset(200, 200),
                  ),
                );
              }));
            },
          ),
          _buildChooseItem(
            context,
            text: "复杂图形~复杂图形",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return TestPage(
                  shapeA: ComplexView(color: Colors.blue),
                  shapeB: ComplexView(
                    color: Colors.orange,
                    initPosition: const CcOffset(200, 200),
                  ),
                );
              }));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChooseItem(BuildContext context,
      {@required String text, @required VoidCallback onTap}) {
    return MaterialButton(
      color: Colors.grey,
      onPressed: onTap,
      child: Text(text),
    );
  }
}
