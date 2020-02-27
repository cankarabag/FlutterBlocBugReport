import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:issue_bloc/bloc/bloc.dart';
import 'package:issue_bloc/bloc/state_example.dart';

class StepSecond extends StatefulWidget {
  const StepSecond({Key key}) : super(key: key);

  @override
  _StepSecondState createState() => _StepSecondState();
}

class _StepSecondState extends State<StepSecond> {
  String info = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<BlocExample>(context),
      listener: (context, state) {
        print(">> Step Second, State $state");
        if (state is ExampleStateStepSecond) {
          setState(() {
            info = state.info;
          });
        }
      },
      child: Center(child: Text("Info: $info")),
    );
  }
}
