import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rps_game/handlers/play_handler.dart';
import 'package:rps_game/ui/home_page.dart';


void main() {
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ChangeNotifierProvider<PlayHandler>(
        create: (BuildContext context) => PlayHandler(),
        child: HomePage()),
  ));
}
