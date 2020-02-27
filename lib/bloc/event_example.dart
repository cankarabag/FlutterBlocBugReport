import 'package:equatable/equatable.dart';

abstract class ExampleEvent extends Equatable {
  @override
  List<Object> get props => const [];
}

class ExampleEventToSecondStep extends ExampleEvent {}

class ExampleEventToFirstStep extends ExampleEvent {}
