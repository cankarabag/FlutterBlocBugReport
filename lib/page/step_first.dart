import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:issue_bloc/bloc/bloc.dart';

class StepFirst extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: <Widget>[
        Text("Step First"),
        RaisedButton(
          onPressed: () =>
              context.bloc<BlocExample>().add(ExampleEventToSecondStep()),
          child: Text("Next"),
        ),
      ],
    ));
  }
}
