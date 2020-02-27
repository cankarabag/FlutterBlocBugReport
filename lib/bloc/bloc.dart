import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'event_example.dart';
part 'state_example.dart';

class BlocExample extends Bloc<ExampleEvent, ExampleState> {
  @override
  ExampleState get initialState => ExampleStateInitial();

  @override
  void onTransition(Transition<ExampleEvent, ExampleState> transition) {
    super.onTransition(transition);
    print(transition);
  }

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
