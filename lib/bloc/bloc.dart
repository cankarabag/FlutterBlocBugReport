import 'package:bloc/bloc.dart';
import 'package:issue_bloc/bloc/event_example.dart';
import 'package:issue_bloc/bloc/state_example.dart';

class BlocExample extends Bloc<ExampleEvent, ExampleState> {
  @override
  ExampleState get initialState => ExampleStateInitial();

  @override
  Stream<ExampleState> mapEventToState(ExampleEvent event) async* {
    if (event is ExampleEventToFirstStep) {
      yield ExampleStateLoading();
      yield ExampleStateStepFirst();
    } else if (event is ExampleEventToSecondStep) {
      yield ExampleStateLoading();
      yield ExampleStateStepSecond(info: "info");
    }
  }
}
