import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peblo_assignment/utils/app_colors.dart';
import 'package:provider/provider.dart';

import '../providers/story_provider.dart';

class QuizCard extends StatefulWidget {
  const QuizCard({super.key});

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard>
    with SingleTickerProviderStateMixin {
  late ConfettiController _controller;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  bool _hasPlayedConfetti = false;

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 3));
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    //Wrong option animation
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -6), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: -6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6, end: 6), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6, end: 0), weight: 1),
    ]).animate(_shakeController);
  }

  @override
  void dispose() {
    _controller.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StoryProvider>(
      builder: (context, provider, child) {
        if (!provider.showQuiz) {
          return const SizedBox.shrink();
        }

        // Reset the confetti flag when quiz state is reset
        if (!provider.isCorrect) {
          _hasPlayedConfetti = false;
        }

        // Play confetti only once per correct answer
        if (provider.isCorrect && !_hasPlayedConfetti) {
          _hasPlayedConfetti = true;
          _controller.play();
        }

        return Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    border: Border.all(color: AppColors.border, width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          provider.quiz.question,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        ...provider.quiz.options.map((option) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: provider.isCorrect
                                    ? null
                                    : () {
                                        HapticFeedback.heavyImpact();

                                        provider.checkAnswer(option);

                                        if (!provider.isCorrect) {
                                          _shakeController.forward(from: 0);
                                        }
                                      },
                                child: AnimatedBuilder(
                                  animation: _shakeController,
                                  builder: (context, child) {
                                    final shouldShake =
                                        provider.selectedAnswer == option &&
                                        !provider.isCorrect;

                                    return Transform.translate(
                                      offset: Offset(
                                        shouldShake ? _shakeAnimation.value : 0,
                                        0,
                                      ),
                                      child: child,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.background,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: provider.selectedAnswer == option
                                            ? (provider.isCorrect
                                                  ? Colors.green
                                                  : Colors.red)
                                            : AppColors.border,
                                        width: 2,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            option,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.text,
                                            ),
                                          ),
                                          Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              color:
                                                  provider.selectedAnswer ==
                                                      option
                                                  ? (provider.isCorrect
                                                        ? Colors.green
                                                        : Colors.red)
                                                  : AppColors.background,
                                              borderRadius:
                                                  BorderRadius.circular(99),
                                              border: Border.all(
                                                color:
                                                    provider.selectedAnswer ==
                                                        option
                                                    ? (provider.isCorrect
                                                          ? Colors.green
                                                          : Colors.red)
                                                    : AppColors.border,
                                                width: 2,
                                              ),
                                            ),
                                            child:
                                                provider.selectedAnswer ==
                                                    option
                                                ? Icon(
                                                    provider.isCorrect
                                                        ? Icons.check
                                                        : Icons.close,
                                                    color: Colors.white,
                                                    size: 18,
                                                  )
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),

                        const SizedBox(height: 15),

                        if (provider.selectedAnswer != null)
                          provider.isCorrect
                              ? const Text(
                                  "🎉 Awesome! That's Correct!",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                )
                              : const Text(
                                  "Oops! Try Again.",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: ConfettiWidget(
                confettiController: _controller,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                gravity: 0.3,
                numberOfParticles: 30,
              ),
            ),
          ],
        );
      },
    );
  }
}
