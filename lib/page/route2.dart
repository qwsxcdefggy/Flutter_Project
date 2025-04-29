import 'package:flutter/material.dart';

class route2 extends StatefulWidget{
  const route2({super.key});

  @override
  State<StatefulWidget> createState() {
   return route2state();
  }
}

class route2state extends State<route2>{
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Set<dynamic>;
    return Container(
      child: Text("from route2! 参数: ${args.toString()}"),
    );
  }
}
