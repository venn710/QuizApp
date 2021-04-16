import 'package:flutter/material.dart';
import 'quiz_brain.dart';
void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  int crct=0;
  int wrong=0;
  int track=0;
  bool flag=false;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.questionBank[track].questionAnswer;
    setState(() {
      if(track<quizBrain.questionBank.length-1)
     { 
      if (userPickedAnswer == correctAnswer) {
        crct=crct+1;
        track=track+1;
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
       wrong=wrong+1;
       track=track+1;
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      quizBrain.nextQuestion();
    }
    else
    flag=true;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return (flag==true)?Container(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.check),
              title: Text("Correct Answers are "),
              trailing: Text(crct.toString())),
              ListTile(
              leading: Icon(Icons.close),
              title: Text("Wrong Answers are "),
              trailing: Text(wrong.toString())),
              ElevatedButton(onPressed: ()
              {
                setState(() {
                  crct=0;
                  wrong=0;
                  track=0;
                  flag=false;
                  scoreKeeper=[];

                });
              }, child: Text("Restart"))
          ]
        ),
      ):Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questionBank[track].questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
