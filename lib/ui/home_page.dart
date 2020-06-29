import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rps_game/handlers/play_handler.dart';
import 'package:rps_game/styles/text_styles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    final handler = Provider.of<PlayHandler>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Consumer<PlayHandler>(
              builder: (BuildContext context, PlayHandler v, Widget child) {
                return Row(
                  children: <Widget>[
                    PlayCard(
                      animation: "rock",
                      flrPath: "assets/rock.flr",
                      id: 0,
                      color:
                          v.cChoice == "stone" ? Colors.red : Colors.red[200],
                      name: "STONE",
                      size: size,
                      onTap: null,
                    ),
                    PlayCard(
                      animation: "paper",
                      flrPath: "assets/paper.flr",
                      id: 1,
                      color:
                          v.cChoice == "paper" ? Colors.blue : Colors.blue[200],
                      name: "PAPER",
                      size: size,
                      onTap: null,
                    ),
                    PlayCard(
                      animation: "scissors",
                      flrPath: "assets/scissors.flr",
                      color: v.cChoice == "scissor"
                          ? Colors.green
                          : Colors.green[200],
                      name: "SCISSOR",
                      size: size,
                      id: 2,
                      onTap: null,
                    ),
                  ],
                );
              },
            ),
            //SCORECARD
            Row(
              children: <Widget>[
                Consumer<PlayHandler>(builder:
                    (BuildContext context, PlayHandler value, Widget child) {
                  return GestureDetector(
                    child: Container(
                      width: size.width / 2,
                      height: size.height / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "YOUR SCORE",
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                          AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 200),
                            style: isFirst
                                ? TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w800,
                                    fontSize: 40)
                                : TextStyle(
                                    color: Colors.red[400],
                                    fontWeight: FontWeight.w800,
                                    fontSize: 40),
                            child: Text(
                              "${value.pScore}",
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      isFirst ? isFirst = false : isFirst = true;
                      setState(() {});
                    },
                  );
                }),
                Consumer<PlayHandler>(builder:
                    (BuildContext context, PlayHandler value, Widget child) {
                  return Container(
                    width: size.width / 2,
                    height: size.height / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "COMP SCORE",
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w800,
                              fontSize: 20),
                        ),
                        Text("${value.cScore}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 40)),
                      ],
                    ),
                  );
                }),
              ],
            ),
            Row(
              children: <Widget>[
                PlayCard(
                  animation: "rock",
                  flrPath: "assets/rock.flr",
                  id: 0,
                  color: Colors.red[200],
                  name: "STONE",
                  size: size,
                  onTap: () {
                    handler.startGame(0,context);
                  },
                ),
                PlayCard(
                  animation: "paper",
                  flrPath: "assets/paper.flr",
                  id: 1,
                  color: Colors.blue[200],
                  name: "PAPER",
                  size: size,
                  onTap: () {
                    handler.startGame(1,context);
                  },
                ),
                PlayCard(
                  animation: "scissors",
                  flrPath: "assets/scissors.flr",
                  color: Colors.green[200],
                  name: "SCISSOR",
                  size: size,
                  id: 2,
                  onTap: () {
                    handler.startGame(2,context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlayCard extends StatefulWidget {
  final String name;
  final Size size;
  final Color color;
  final int id;
  final Function onTap;
  final String flrPath;
  final String animation;

  PlayCard(
      {@required this.name,
      @required this.size,
      @required this.color,
      @required this.id,
      @required this.onTap,
      @required this.flrPath,
      @required this.animation})
      : assert(name != null);
  @override
  _PlayCardState createState() => _PlayCardState();
}

class _PlayCardState extends State<PlayCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: widget.color,
          child: InkWell(
            splashColor: Colors.yellowAccent,
            onTap: widget.onTap,
            child: Container(
              decoration: BoxDecoration(),
              width: widget.size.width / 3.2,
              height: 150,
              child: FlareActor(
                widget.flrPath,
                callback: (val) {
                  print("ANIM COMPLETED");
                },
                fit: BoxFit.cover,
                alignment: Alignment.center,
                animation: widget.animation,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
