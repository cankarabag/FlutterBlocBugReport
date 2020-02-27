import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:issue_bloc/bloc/bloc.dart';
import 'package:issue_bloc/bloc/event_example.dart';
import 'package:issue_bloc/bloc/state_example.dart';

class StepFirst extends StatefulWidget {
  final VoidCallback onNextPressed;

  const StepFirst({Key key, this.onNextPressed}) : super(key: key);

  @override
  _StepFirstState createState() => _StepFirstState();
}

class _StepFirstState extends State<StepFirst> {
  BlocExample exampleBloc;

  @override
  void initState() {
    super.initState();
    exampleBloc = BlocProvider.of<BlocExample>(context);
  }

  continueBtnTapped() {
    exampleBloc.add(ExampleEventToSecondStep());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<BlocExample>(context),
      listener: (context, state) {
        print(">> Step First, State $state");
        if (state is ExampleStateStepSecond) {
          widget.onNextPressed();
        }
      },
      child: Center(
          child: Column(
        children: <Widget>[
          Text("Step First"),
          RaisedButton(
            onPressed: continueBtnTapped,
            child: Text("Next"),
          ),
        ],
      )),
    );
  }
}
