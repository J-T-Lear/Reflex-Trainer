import 'dart:math';
import 'dart:async'; 

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
 

class ScorePage extends StatefulWidget {
  const ScorePage({Key? key, required this.title,this.score,this.timeleftstr,this.testvalue}) : super(key: key); 
  final String title;
  final score; 
  final timeleftstr;
  final testvalue;


  @override
  State<ScorePage> createState() => _ScorePage(score, timeleftstr);
}

class _ScorePage extends State<ScorePage> { 
  _ScorePage(this.score, this.timeleftstr);

  final score;
  final timeleftstr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflex Trainer",
        style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          Column(
                children: [
              const Text(
                "You Scored", 
              ), 

              Text(
                "$score",
                style: Theme.of(context).textTheme.headline2,
              ),
 
              
               const SizedBox(
                height: 80,
              ),

            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context, score); 
                },
                child: Text('Play Again',
                style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),

          ],
        ),
      ),
    );
  }

}




