import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/page/BottomNavigationScreen.dart';
import 'package:flutter_project2/page/CardLayoutScreen.dart';
import 'package:flutter_project2/page/Chart2_.dart';
import 'package:flutter_project2/page/Chart3_.dart';
import 'package:flutter_project2/page/Chart4_.dart';
import 'package:flutter_project2/page/Chart5_.dart';
import 'package:flutter_project2/page/Chart_.dart';
import 'package:flutter_project2/page/Combine.dart';
import 'package:flutter_project2/page/GridLayoutScreen.dart';
import 'package:flutter_project2/page/SidebarLayout.dart';
import 'package:flutter_project2/page/Web1.dart';
import 'package:flutter_project2/page/contain_layout.dart';
import 'package:flutter_project2/page/route2.dart';
import 'package:flutter_project2/page/second.dart';
import 'package:flutter_project2/page/WaterfallFlow.dart';
import 'package:window_manager/window_manager.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // 确保 Flutter 引擎已初始化
  windowManager.ensureInitialized();
  windowManager.setTitle('Demo'); // 设置标题
  // 设置无边框窗口

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 去除 Debug 标志
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Arial', // 使用系统通用字体
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Arial', color: Colors.black),
        ),
      ),


      routes: {
        '/' : (context)=> const ContainLayout(),
        '/card': (content) => CardLayoutScreen(),
        '/bottomscreen':(context)=> BottomNavigationScreen(),
        '/grid':(context)=> GridLayoutScreen(),
        '/waterfall':(content)=> WaterfallFlow(),
        '/route2': (content) => route2(),
        '/sider': (content) => SidebarLayout(),
        '/combine':(content)=> Combine(),
        '/second':(content)=> Second(),
        '/chart_':(content)=>  Chart_(),
        '/chart2_':(content)=> Chart2_(),
        '/chart3_':(content)=> Chart3_(),
        '/chart4_':(content)=> Chart4_(),
        '/chart5_':(content)=> Chart5_(),
        '/web1':(content)=>  Web1(),
      },
      initialRoute: '/', // 初始路由
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
