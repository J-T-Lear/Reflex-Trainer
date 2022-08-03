
import 'dart:math';
import 'dart:async'; 

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
 
import 'scorepage.dart';


class GuessPage extends StatefulWidget {
  const GuessPage({Key? key, required this.title}) : super(key: key); 
  final String title;

  @override
  State<GuessPage> createState() => _GuessPage();
}

class _GuessPage extends State<GuessPage> {
  _GuessPage();
 
  
  String guessword = 'default value';
  String timeleftstr = "sas";
  int guesswordnum = 1;
  int tries = 0;
  int score = 0;
  int timeleft = 0;
  bool firstboot = true; 
  bool end = false;

  var btncolor = Colors.white;
  var bgcolor = Colors.white;  

  double w1 = 0;
  double w2 = 0;
  double w3 = 0;
  double w4 = 0;
  double w5 = 0;
  double w6 = 0;

  double h1 = 0;
  double h2 = 0;

  bool button1vis = false;
  bool button2vis = false;
  bool button3vis = false;
  bool button4vis = false;
  bool button5vis = false;
  bool button6vis = false;
  bool button7vis = false;
  bool button8vis = false;
  bool button9vis = false; 

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 10;  

  randomizegaps(){ 
      w1 = Random().nextInt(150) + Random().nextDouble();
      w2 = Random().nextInt(150) + Random().nextDouble();
      w3 = Random().nextInt(150) + Random().nextDouble();
      w4 = Random().nextInt(150) + Random().nextDouble();
      w5 = Random().nextInt(150) + Random().nextDouble();
      w6 = Random().nextInt(150) + Random().nextDouble();

      
      h1 = Random().nextInt(200) + Random().nextDouble();
      h2 = Random().nextInt(200) + Random().nextDouble();  
  }

  randomizebutton(){ 
      button1vis = Random().nextBool();
      button2vis = Random().nextBool();
      button3vis = Random().nextBool();
      button4vis = Random().nextBool();
      button5vis = Random().nextBool();
      button6vis = Random().nextBool();
      button7vis = Random().nextBool();
      button8vis = Random().nextBool();
      button9vis = Random().nextBool(); 
  } 

  void startTimer() {
    print("Timer Start");
    const oneSec = Duration(seconds: 1); 
    Timer _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timeleft == 0) { 
              setState(() { 
                endGame(); 
                print("timer ends");
                timer.cancel(); 
                print(timer.isActive);
                end = true; 
              }); 
              
        } else { 
            setState(() {
              timeleft = timeleft-1; 
              timeformatter();
              randomizebutton();
              randomizegaps();
            });
        }
        print(timeleft);  
      },
    ); 
    @override
    void dispose() {
     _timer.cancel();
     super.dispose();
  } 
  } 

  scored(){
    setState(() { 
    tries = tries + 1; 
    score = score + 1; 
    bgcolor = Colors.greenAccent;
    randomizebutton();
    randomizegaps(); 
    });

    print("Tries: $tries");
    print("Score: $score");

    if(tries >= 100){  
    gameEnd();
    }
                          
  } 

  demerited(){
    setState(() { 
    tries = tries + 1; 
    score = score - 1; 
    bgcolor = Colors.redAccent;
    randomizebutton();
    randomizegaps();
    });

    print("Tries: $tries");
    print("Score: $score");

    if(tries >= 100){  
    gameEnd();
    }
                          
  } 

  timeformatter(){
    int timeleftlength = timeleft.toString().length;
    if (timeleftlength == 1){
      timeleftstr = "00:0" + timeleft.toString();
    } else {
      timeleftstr = "00:" + timeleft.toString();
    }
    print(timeleftstr);
    return timeleftstr;
  }

  gameEnd() {  
    timeleft = 0; 
    endGame();
    end = true; 
  }

  endGame(){
    if (end == false) {
      Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) =>   ScorePage(title: "Reflex Trainer",score: score, timeleftstr: timeleftstr,)),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    if(firstboot == true){ 
      firstboot = false;
      timeleft = 10;
      tries = 0;
      score = 0;
      timeformatter();
      randomizebutton();
      randomizegaps();
      startTimer();
    }; 

    return Scaffold(
      appBar: AppBar(
        title: const Text("Reflex Trainer",
        style: TextStyle(color: Colors.white),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
 
          Container( 
            width: 600,
            height: 500,
              color: bgcolor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button1vis? Colors.red : Colors.green, // bac / foreground
                          ),
                          onPressed: button1vis ? demerited : scored,
                          child: button1vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          ) 
                        ),

                        SizedBox(
                          width: w1,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button2vis? Colors.red : Colors.green,   
                          ),
                          onPressed: button2vis ? demerited : scored,
                          child: button2vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),

                        SizedBox(
                          width: w2,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button3vis? Colors.red : Colors.green, 
                          ),
                          onPressed: button3vis ? demerited : scored,
                          child: button3vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),
                      ]
                    ),

                    SizedBox(
                          height: h1,
                        ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button4vis? Colors.red : Colors.green,  // bac / foreground
                          ),
                          onPressed: button4vis ? demerited : scored,
                          child: button4vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),

                        SizedBox(
                          width: w3,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button5vis? Colors.red : Colors.green,  // bac / foreground
                          ),
                          onPressed: button5vis ? demerited : scored,
                          child: button5vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),

                        SizedBox(
                          width: w4,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button6vis? Colors.red : Colors.green, 
                          ),
                          onPressed: button6vis ? demerited : scored,
                          child: button6vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),
                      ]
                    ),

                    SizedBox(
                          height: h2,
                        ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button7vis? Colors.red : Colors.green, 
                          ),
                          onPressed: button7vis ? demerited : scored,
                         child: button7vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),

                        SizedBox(
                          width: w5,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: button8vis? Colors.red : Colors.green, 
                          ),
                          onPressed: button8vis ? demerited : scored,
                         child: button8vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),

                        SizedBox(
                          width: w6,
                        ),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: !button8vis? Colors.red : Colors.green, 
                          ),
                          onPressed: !button8vis ? demerited : scored,
                          child: !button8vis ? Text("-",
                          style: Theme.of(context).textTheme.bodyText1,
                          ) : Text('+',
                          style: Theme.of(context).textTheme.bodyText1,
                          )
                        ),
                      ]
                    )    
              ],
            ),
          ),

          Column(
            children: [
                const SizedBox(
                 height: 80,
                 ),

                Text(
                  "$timeleftstr"
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                  "Current Score:", 
                ),
                
                Text(
                  "$score",
                ),
                  ],
                ),
                  ],
                ),  
          ],
        ),
      ),
    );
  }

}




