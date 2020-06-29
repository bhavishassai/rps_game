
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String path;
  final String msg;
  final String animation;
  final Function func;
  ResultPage(
      {@required this.path,
      @required this.animation,
      @required this.func,
      @required this.msg});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    widget.func();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:widget.msg=="You Won!"? Colors.green[600]:Colors.redAccent,
        title: Text(
          widget.msg,
          
        ),
      ),
      body: Container(
        height: size.height-20,
        width: size.width-20,
        child: FlareActor(
          widget.path,
          alignment: Alignment.center,
          fit: BoxFit.contain,
          animation: widget.animation,
        ),
      ),
    );
  }
}
