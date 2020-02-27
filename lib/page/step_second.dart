import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:issue_bloc/bloc/bloc.dart';

class StepSecond extends StatelessWidget {
  const StepSecond({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocExample, ExampleState>(
      builder: (context, state) {
        if (state is ExampleStateStepSecond) {
          return Center(child: Text('Info: ${state.info}'));
        }
        return Center(child: Text('Something went wrong'));
      },
    );
  }
}
