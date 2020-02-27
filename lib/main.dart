import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:issue_bloc/bloc/bloc.dart';
import 'package:issue_bloc/page/step_first.dart';
import 'package:issue_bloc/page/step_second.dart';
import 'package:issue_bloc/widget/custom_stepper_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider<BlocExample>(
        create: (_) => BlocExample(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index;
  BlocExample exampleBloc;

  leadingBtnTapped() {
    if (index != 0) {
      stepBack();
    }
  }

  stepBack() {
    setState(() {
      if (this.index > 0) {
        this.index--;
        if (this.index == 0) {
          exampleBloc.add(ExampleEventToFirstStep());
        } else {
          exampleBloc.add(ExampleEventToSecondStep());
        }
      }
    });
  }

  stepContinue() {
    setState(() {
      this.index = (this.index + 1) % 2;
    });
  }

  @override
  void initState() {
    super.initState();
    index = 0;
    exampleBloc = BlocProvider.of<BlocExample>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: exampleBloc,
      listener: (context, state) {
        print(">> Step First, State $state");
        if (state is ExampleStateStepSecond) {
          stepContinue();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: index == 0 ? Icon(Icons.menu) : Icon(Icons.arrow_back),
            onPressed: leadingBtnTapped,
          ),
          title: Text("Issue"),
        ),
        body: CustomStepperWidget(
          type: StepperType.horizontal,
          currentStep: index,
          steps: [
            CustomStep(
              title: Text("Step 1"),
              activeIcon: Icon(Icons.settings),
              passiveIcon: Icon(Icons.settings),
              content: StepFirst(),
            ),
            CustomStep(
              title: Text("Step 2"),
              activeIcon: Icon(Icons.settings),
              passiveIcon: Icon(Icons.settings),
              content: StepSecond(),
            ),
          ],
        ),
      ),
    );
  }
}
