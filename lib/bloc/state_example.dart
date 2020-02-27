part of 'bloc.dart';

abstract class ExampleState extends Equatable {
  ExampleState([List props = const []]) : super(props);
}

class ExampleStateInitial extends ExampleState {}

class ExampleStateLoading extends ExampleState {}

class ExampleStateStepFirst extends ExampleState {}

class ExampleStateStepSecond extends ExampleState {
  final String info;

  ExampleStateStepSecond({@required this.info}) : super([info]);
}
