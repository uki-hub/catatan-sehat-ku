import 'dart:async';
import 'dart:math';

import 'package:catatan_sehat_ku/src/app/app.dart';
import 'package:catatan_sehat_ku/src/controllers/cubit/game_cubit.dart';
import 'package:catatan_sehat_ku/src/models/game_record_model.dart';
import 'package:catatan_sehat_ku/src/views/pages/health/widgets/record_history.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_button.dart';
import 'package:catatan_sehat_ku/src/views/widgets/app_leading_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<String> tileValues;
  late List<bool> tileVisibility;
  late List<bool> tileMatched;
  List<int> scoreHistory = [];
  int currentScore = 0;
  int? firstSelectedIndex;
  bool isProcessing = false;
  Timer? timer;
  int secondsElapsed = 0;
  bool gameStarted = false;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    List<String> baseTiles = List.generate(8, (index) => (index + 1).toString());
    tileValues = List.from(baseTiles)..addAll(baseTiles);
    tileValues.shuffle(Random());
    tileVisibility = List.generate(16, (index) => false);
    tileMatched = List.generate(16, (index) => false);
    currentScore = 0;
    firstSelectedIndex = null;
    isProcessing = false;
    gameStarted = false;
    secondsElapsed = 0;
    timer?.cancel();
    setState(() {});
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
      });
    });
  }

  void onTileTapped(int index) {
    if (isProcessing || tileVisibility[index] || tileMatched[index]) return;

    if (!gameStarted) {
      gameStarted = true;
      startTimer();
    }

    setState(() {
      tileVisibility[index] = true;
    });

    if (firstSelectedIndex == null) {
      firstSelectedIndex = index;
    } else {
      if (tileValues[firstSelectedIndex!] == tileValues[index]) {
        tileMatched[firstSelectedIndex!] = true;
        tileMatched[index] = true;
        firstSelectedIndex = null;
        if (tileMatched.every((matched) => matched)) {
          endGame();
        }
      } else {
        isProcessing = true;
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            tileVisibility[firstSelectedIndex!] = false;
            tileVisibility[index] = false;
            firstSelectedIndex = null;
            isProcessing = false;
          });
        });
      }
    }
  }

  void endGame() {
    timer?.cancel();
    currentScore = secondsElapsed;
    scoreHistory.add(currentScore);
    context.read<GameCubit>().record(GameRecordModel(totalSeconds: secondsElapsed, recordDate: DateTime.now()));
    setState(() {});
  }

  double calculateAverageScore() {
    final records = context.read<GameCubit>().state.records;

    if(records.isEmpty) return 0;

    final totalSecods = records.fold(0, (a, b) => a + b.totalSeconds);
    return totalSecods / records.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: App.color.surface,
        leading: AppLeadingBackButton(onTap: () => true),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Memory Tile Game',
          style: App.text.titleLarge!.copyWith(
            color: App.color.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: App.color.surfaceDim,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Time Taken ',
                          style: App.text.bodyMedium!.copyWith(
                            color: App.color.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: secondsElapsed.toString(),
                          style: App.text.bodyMedium!.copyWith(color: App.color.onSurface, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: ' seconds',
                          style: App.text.bodyMedium!.copyWith(
                            color: App.color.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Average Time ',
                          style: App.text.bodyMedium!.copyWith(
                            color: App.color.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: calculateAverageScore().toStringAsFixed(2),
                          style: App.text.bodyMedium!.copyWith(color: App.color.onSurface, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                          text: ' seconds',
                          style: App.text.bodyMedium!.copyWith(
                            color: App.color.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 370,
              width: double.infinity,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: false,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: 16,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onTileTapped(index),
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(color: tileVisibility[index] ? App.color.primary : App.color.primaryContainer.withAlpha(225), borderRadius: BorderRadius.circular(7)),
                      child: Center(
                        child: tileVisibility[index]
                            ? Text(
                                tileValues[index],
                                style: App.text.headlineLarge!.copyWith(
                                  color: App.color.onPrimary,
                                ),
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
            AppButton(
              rounded: false,
              onTap: resetGame,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restart_alt_rounded,
                    size: 24.sp,
                    color: App.color.onPrimary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'Restart Game',
                    style: App.text.titleMedium!.copyWith(
                      color: App.color.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            // RecordHistory(records: records, rowBuilder: rowBuilder),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
