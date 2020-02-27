// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

const TextStyle _kStepStyle = TextStyle(
  fontSize: 12.0,
  color: Colors.white,
);
const Color _kCircleActiveLight = Colors.white;

/// A material step used in [Stepper]. The step can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
///
/// See also:
///
///  * [Stepper]
///  * <https://material.io/archive/guidelines/components/steppers.html>
@immutable
class CustomStep {
  /// Creates a step for a [Stepper].
  ///
  /// The [title], [content], and [state] arguments must not be null.
  const CustomStep({
    @required this.title,
    @required this.activeIcon,
    @required this.passiveIcon,
//    this.subtitle,
    @required this.content,
    this.state = StepState.indexed,
    this.isActive = false,
  })  : assert(title != null),
        assert(content != null),
        assert(state != null);

  /// The title of the step that typically describes it.
  final Widget title;

  /// Icon for each step
  final Widget activeIcon;

  final Widget passiveIcon;

  /// The subtitle of the step that appears below the title and has a smaller
  /// font size. It typically gives more details that complement the title.
  ///
  /// If null, the subtitle is not shown.
//  final Widget subtitle;

  /// The content of the step that appears below the [title] and [subtitle].
  ///
  /// Below the content, every step has a 'continue' and 'cancel' button.
  final Widget content;

  /// The state of the step which determines the styling of its components
  /// and whether steps are interactive.
  final StepState state;

  /// Whether or not the step is active. The flag only influences styling.
  final bool isActive;
}

/// A material stepper widget that displays progress through a sequence of
/// steps. Steppers are particularly useful in the case of forms where one step
/// requires the completion of another one, or where multiple steps need to be
/// completed in order to submit the whole form.
///
/// The widget is a flexible wrapper. A parent class should pass [currentStep]
/// to this widget based on some logic triggered by the three callbacks that it
/// provides.
///
/// See also:
///
///  * [Step]
///  * <https://material.io/archive/guidelines/components/steppers.html>
class CustomStepperWidget extends StatefulWidget {
  /// Creates a stepper from a list of steps.
  ///
  /// This widget is not meant to be rebuilt with a different list of steps
  /// unless a key is provided in order to distinguish the old stepper from the
  /// new one.
  ///
  /// The [steps], [type], and [currentStep] arguments must not be null.
  const CustomStepperWidget({
    Key key,
    @required this.steps,
    this.physics,
    this.scrollController,
    this.type = StepperType.vertical,
    this.currentStep = 0,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
  })  : assert(steps != null),
        assert(type != null),
        assert(currentStep != null),
        assert(0 <= currentStep && currentStep < steps.length),
        super(key: key);

  /// The steps of the stepper whose titles, subtitles, icons always get shown.
  ///
  /// The length of [steps] must not change.
  final List<CustomStep> steps;

  /// How the stepper's scroll view should respond to user input.
  ///
  /// For example, determines how the scroll view continues to
  /// animate after the user stops dragging the scroll view.
  ///
  /// If the stepper is contained within another scrollable it
  /// can be helpful to set this property to [ClampingScrollPhysics].
  final ScrollPhysics physics;

  final ScrollController scrollController;

  /// The type of stepper that determines the layout. In the case of
  /// [StepperType.horizontal], the content of the current step is displayed
  /// underneath as opposed to the [StepperType.vertical] case where it is
  /// displayed in-between.
  final StepperType type;

  /// The index into [steps] of the current step whose content is displayed.
  final int currentStep;

  /// The callback called when a step is tapped, with its index passed as
  /// an argument.
  final ValueChanged<int> onStepTapped;

  /// The callback called when the 'continue' button is tapped.
  ///
  /// If null, the 'continue' button will be disabled.
  final VoidCallback onStepContinue;

  /// The callback called when the 'cancel' button is tapped.
  ///
  /// If null, the 'cancel' button will be disabled.
  final VoidCallback onStepCancel;

  /// The callback for creating custom controls.
  ///
  /// If null, the default controls from the current theme will be used.
  ///
  /// This callback which takes in a context and two functions,[onStepContinue]
  /// and [onStepCancel]. These can be used to control the stepper.
  ///
  /// {@tool snippet --template=stateless_widget_scaffold}
  /// Creates a stepper control with custom buttons.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Stepper(
  ///     controlsBuilder:
  ///       (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
  ///          return Row(
  ///            children: <Widget>[
  ///              FlatButton(
  ///                onPressed: onStepContinue,
  ///                child: const Text('CONTINUE'),
  ///              ),
  ///              FlatButton(
  ///                onPressed: onStepCancel,
  ///                child: const Text('CANCEL'),
  ///              ),
  ///            ],
  ///          );
  ///       },
  ///     steps: const <Step>[
  ///       Step(
  ///         title: Text('A'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///       Step(
  ///         title: Text('B'),
  ///         content: SizedBox(
  ///           width: 100.0,
  ///           height: 100.0,
  ///         ),
  ///       ),
  ///     ],
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  final ControlsWidgetBuilder controlsBuilder;

  @override
  _CustomStepperWidgetState createState() => _CustomStepperWidgetState();
}

class _CustomStepperWidgetState extends State<CustomStepperWidget>
    with TickerProviderStateMixin {
  final Map<int, StepState> _oldStates = <int, StepState>{};

  /*@override
  void initState() {
    super.initState();
    List<GlobalKey>  _keys = List<GlobalKey>.generate(
      widget.steps.length,
      (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i += 1)
      _oldStates[i] = widget.steps[i].state;

    SchedulerBinding.instance.addPostFrameCallback((ignored) {});
  }*/

  @override
  void didUpdateWidget(CustomStepperWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1)
      _oldStates[i] = oldWidget.steps[i].state;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Widget _buildCircleChild(int index, bool oldState) {
    final StepState state =
        oldState ? _oldStates[index] : widget.steps[index].state;
    final bool isDarkActive = _isDark() && widget.steps[index].isActive;
    assert(state != null);
    switch (state) {
      case StepState.indexed:
        return _isCurrent(index)
            ? widget.steps[index].activeIcon
            : widget.steps[index].passiveIcon;
      case StepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive
              ? _kStepStyle.copyWith(color: Colors.black87)
              : _kStepStyle,
        );
      case StepState.editing:
        return Icon(
          Icons.edit,
          color: _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.complete:
        return Icon(
          Icons.check,
          color: _kCircleActiveLight,
          size: 18.0,
        );
      case StepState.error:
        return const Text('!', style: _kStepStyle);
    }
    return null;
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: 50,
      height: 50,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color:
                  _isCurrent(index) ? Colors.transparent : Color(0xffb4bac6)),
          color: _isCurrent(index) ? Color(0xff3699ad) : Colors.green,
        ),
        child: Center(
          child: _buildCircleChild(
              index, oldState && widget.steps[index].state == StepState.error),
        ),
      ),
    );
  }

  Widget _buildHeaderText(int index) {
    final title = widget.steps[index].title;
    return AnimatedDefaultTextStyle(
      style: _isCurrent(index)
          ? Theme.of(context).textTheme.title
          : Theme.of(context).textTheme.title,
      duration: kThemeAnimationDuration,
      curve: Curves.fastOutSlowIn,
      child: title,
    );
  }

  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[];

    for (int i = 0; i < widget.steps.length; i += 1) {
      children.add(
        Column(
          children: <Widget>[
            _buildCircle(i, false),
            _buildHeaderText(i),
          ],
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      controller: widget.scrollController,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width / 15 * 2),
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 33, // top padding of circle + height of circle / 2
                  width: size.width - 50,
                  left: size.width / 15 * 2 - 25,
                  child: Container(
                    height: 1.0,
                    color: Color(0xffb4bac6),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: children,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
//            child: AnimatedSize(
//              curve: Curves.fastOutSlowIn,
//              duration: kThemeAnimationDuration,
//              vsync: this,
            child: widget.steps[widget.currentStep].content,
//            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<CustomStepperWidget>() != null)
        throw FlutterError(
            'Steppers must not be nested. The material specification advises '
            'that one should avoid embedding steppers within steppers. '
            'https://material.io/archive/guidelines/components/steppers.html#steppers-usage');
      return true;
    }());
    assert(widget.type != null);
    switch (widget.type) {
      case StepperType.vertical:
      case StepperType.horizontal:
        return _buildHorizontal();
    }
    return null;
  }
}
