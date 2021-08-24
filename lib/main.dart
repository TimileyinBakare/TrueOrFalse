import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'engine.dart';

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Quiz Header"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: QuizzlerBody(),
        ),
      ),
    );
  }
}

class QuizzlerBody extends StatefulWidget {
  @override
  _QuizzlerBodyState createState() => _QuizzlerBodyState();
}

class _QuizzlerBodyState extends State<QuizzlerBody> {
  QuizBrain q1 = new QuizBrain();
  List<Icon> answerIndicator = [];
  void setIndicator(userPicked) {
    setState(() {
      if (q1.isFinished() == true) {
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz madacuker.',
        ).show();

        answerIndicator = [];
        q1.reset();
      } else {
        bool? answersPicked = q1.getAnswer();
        if (userPicked == answersPicked) {
          answerIndicator.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          answerIndicator.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        q1.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              q1.getQuestion(),
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            setIndicator(true);
          },
          child: Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "True",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            setIndicator(false);
          },
          child: Container(
            margin: EdgeInsets.all(20),
            child: Text(
              "False",
              style: TextStyle(color: Colors.white),
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: answerIndicator,
          ),
        ),
      ],
    );
  }
}
