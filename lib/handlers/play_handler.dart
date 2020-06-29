import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:rps_game/ui/result_page.dart';

class PlayHandler extends ChangeNotifier {
  static Random _random = Random();

  List<String> choice = ["stone", "paper", "scissor"];

  int pScore = 0;
  int cScore = 0;
  String pChoice;
  String cChoice;

  void startGame(int index, BuildContext context) async {
    pChoice = choice[index];
    cChoice = choice[_random.nextInt(3)];
    playLocalAsset(index);
    notifyListeners();

    await Future.delayed(Duration(seconds: 2), () {
      compute();
    });

    notifyListeners();

    pChoice = null;
    cChoice = null;
    notifyListeners();

    if (pScore >= 10) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => ResultPage(
                msg: "You Won!",
                func:playWinAud ,
                    animation: "Untitled",
                    path: "assets/win.flr",
                  )));
      pScore = 0;
      cScore = 0;
    }
    if (cScore >= 10) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (c) => ResultPage(
                msg: "You Lose",
                func: playLoseAud,
                    animation: "crying",
                    path: "assets/crying.flr",
                  )));
      pScore = 0;
      cScore = 0;
    }
  }

  void compute() {
    if (pChoice == cChoice) {
    } else {
      if (pChoice == 'stone') {
        cChoice == 'paper' ? cScore++ : pScore++;
      }
      if (pChoice == 'paper') {
        cChoice == 'scissor' ? cScore++ : pScore++;
      }
      if (pChoice == 'scissor') {
        cChoice == 'stone' ? cScore++ : pScore++;
      }
    }
  }

  Future<AudioPlayer> playLocalAsset(int index) async {
    AudioCache cache = new AudioCache();
    //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
    //Just pass the file name only.
    return await cache.play("aud$index.mp3");
  }

   Future<AudioPlayer> playWinAud() async {
    AudioCache cache = new AudioCache();
   //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
   //Just pass the file name only.
    return await cache.play("winaud.mp3",volume: 0.4); 
}
   Future<AudioPlayer> playLoseAud() async {
    AudioCache cache = new AudioCache();
   //At the next line, DO NOT pass the entire reference such as assets/yes.mp3. This will not work.
   //Just pass the file name only.
    return await cache.play("winaud.mp3",volume: 0.4); 
}
}
