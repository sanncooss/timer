part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {
  const TimerEvent();
}

final class TimerStarted extends TimerEvent {
  const TimerStarted({required this.duration});
  final int duration;
}

final class TimerPaused extends TimerEvent {
  const TimerPaused();
}

final class TimerResumed extends TimerEvent {
  const TimerResumed();
}

final class TimerReset extends TimerEvent {
  const TimerReset();
}

final class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});

  final int duration;
}
