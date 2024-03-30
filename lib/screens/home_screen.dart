import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const initialSeconds = 1500;
  int totalSeconds = initialSeconds;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void handleOnTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros++;
        isRunning = false;
        totalSeconds = initialSeconds;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), handleOnTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String formatSeconds(int totalSeconds) {
    int seconds = totalSeconds % 60;
    int minutes = totalSeconds ~/ 60;

    String formattedSec = seconds.toString().padLeft(2, '0');
    String formattedMin = minutes.toString().padLeft(2, '0');

    return '$formattedMin:$formattedSec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Flexible(
          child: Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              formatSeconds(totalSeconds),
              style: TextStyle(
                color: Theme.of(context).cardColor,
                fontSize: 88,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: IconButton(
              iconSize: 120,
              color: Theme.of(context).cardColor,
              onPressed: isRunning ? onPausePressed : onStartPressed,
              icon: Icon(
                isRunning
                    ? Icons.pause_circle_outline_rounded
                    : Icons.play_circle_outline_rounded,
              ),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Pomodoros',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                      Text(
                        '$totalPomodoros',
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w600,
                          color:
                              Theme.of(context).textTheme.displayLarge!.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
