import 'dart:math';
import 'dart:async';  

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
 
import 'gamepage.dart';

final List<int> _scores = [];
final List<String> _times = [];
int _score = 0;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Reflex Trainer',
      theme: ThemeData( 
 
        primarySwatch: Colors.lightBlue,

        textTheme:  const TextTheme(
          headline1: TextStyle(fontSize: 24.0, color: Colors.white),
          headline2: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      home: const MyHomePage(title: 'Reflex Trainer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key); 

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
  
  static currentdatetime(){  
    var dt = DateTime.now();

    String dayweek = DateFormat('EEEE').format(dt).toString();

    String monthandday = DateFormat('MMMd').format(dt).toString();

    String year = DateFormat('y').format(dt).toString();

    String hour  = DateFormat('hh').format(dt).toString();

    String minute = DateFormat('mm').format(dt).toString();

    String date = dayweek + " " + monthandday + " " + year + " - " + hour + ":" + minute; 
    print("Current date is $date"); 

    return date;

  }

  void _startGuessing() async{  

    _score = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>   const GuessPage(title: "Reflex Trainer")),
    );
    setState(() {
      _scores.insert(0, _score);
      _times.insert(0, currentdatetime().toString());
    });
    print("SCORES");
    print(_times);
    print(_scores);
    print("SCORES END");
    
  } 

  clear(){
    setState(() {
    _scores.clear();
    _times.clear();
    });
  }

  @override
  Widget build(BuildContext context) {  

    return Scaffold(
      appBar: AppBar( 
        title: Text(widget.title, 
        style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), 
        child: Center( 
          child: ListView(  
            children: [
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text(
                    'Reflex text',
                    style: Theme.of(context).textTheme.headline2,
                  ),

              const SizedBox(
                    height:20,

              ),

              const Text(
                    "Pressing on + buttons will give you points"
              ),

              const SizedBox(
                    height:4,

              ),

              const Text(
                    "Pressing on - buttons will take away points"
              ),

              const SizedBox(
                    height:4,

              ),

              const Text(
                    'Try to score as you can in 10 seconds', 
              ),

              const SizedBox(
                    height:10,

              ),

              ElevatedButton(
                    onPressed: _startGuessing,
                     child:  Text("Got It",
                     style: Theme.of(context).textTheme.bodyText1,
                     ),
                    ),

              const SizedBox(
                    height: 20,
                    ),
                     

              const SizedBox(
                    height: 20,
                    ),
                    
     
              Text(                                                       //Sleep Data text
                'Scores',
                style: Theme.of(context).textTheme.bodyText2,
              ),
              
                 ],
               ), 
               
              const SizedBox(
                height: 20,
              ), 

              if (_scores.isNotEmpty) ListView.builder(
                shrinkWrap: true, 
                itemCount: _scores.length,
                itemBuilder: (context, index) {
                  return Column( 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                      Text('Time : ${_times[index]}'), 
                      Text('Score : ${_scores[index]}'),

                      const SizedBox(
                        height: 20,
                      ),   

                  ],);
                }
                
                ) else const Center(
                child: 
                Text('No records'), 
              ),

              const SizedBox(
                        height: 20,
                      ),        
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  ElevatedButton(                                           //Stop Button
                onPressed: _scores.isEmpty ? null : clear,
                  child:  Text("CLEAR",
                  style: Theme.of(context).textTheme.bodyText1,
               ),
              ),
                ],
              )

            ],

          ),
        ),
      ), 
    );
  }
}


