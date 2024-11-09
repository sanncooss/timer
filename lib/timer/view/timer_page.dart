import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/ticker.dart';
import 'package:flutter_application_1/timer/bloc/timer_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(
        const Ticker(),
      ),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter timer',
        ),
      ),
      body: const Stack(
        children: [
          // const Background();
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 100,
                ),
                child: Center(
                  child: TimerText(),
                ),
              ),
              Actions()
            ],
          )
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minuteStr = ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minuteStr:$secondStr',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context.read<TimerBloc>().add(TimerStarted(
                          duration: state.duration,
                        )),
                  )
                ],
              TimerRunInProgress() => [
                  FloatingActionButton(
                    child: const Icon(
                      Icons.replay,
                    ),
                    onPressed: () => context.read<TimerBloc>().add(
                          const TimerPaused(),
                        ),
                  ),
                  FloatingActionButton(
                    child: const Icon(
                      Icons.pause,
                    ),
                    onPressed: () => context.read<TimerBloc>().add(
                          const TimerReset(),
                        ),
                  )
                ],
              TimerRunPause() => [
                  FloatingActionButton(
                      child: const Icon(Icons.play_arrow),
                      onPressed: () => context.read<TimerBloc>().add(
                            const TimerResumed(),
                          )),
                  FloatingActionButton(
                      child: const Icon(Icons.play_arrow),
                      onPressed: () => context.read<TimerBloc>().add(
                            const TimerResumed(),
                          ))
                ],
              TimerRunComplete() => [
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () => context.read<TimerBloc>().add(
                          const TimerReset(),
                        ),
                  )
                ]
            }
          ],
        );
      },
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            Colors.blue.shade300,
          ],
        ),
      ),
    );
  }
}
