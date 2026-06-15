import 'package:flutter/material.dart';
import 'package:peblo_assignment/providers/story_provider.dart';
import 'package:peblo_assignment/utils/app_colors.dart';
import 'package:peblo_assignment/widgets/quiz_card.dart';
import 'package:provider/provider.dart';

import '../utils/app_data.dart';
import '../widgets/read_button.dart';
import '../widgets/story_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("AI Story Buddy"), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Fixed Robot
          Consumer<StoryProvider>(
            builder: (context, provider, child) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 2),
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset(
                    provider.isCorrect ? "assets/happy.png" : "assets/idle.png",
                    key: ValueKey(provider.isCorrect),
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 15),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  StoryCard(story: AppData.story),

                  const SizedBox(height: 20),

                  Consumer<StoryProvider>(
                    builder: (context, provider, child) {
                      return ReadButton(
                        onPressed: provider.readStory,
                        enabled: !provider.isSpeaking,
                      );
                    },
                  ),

                  Consumer<StoryProvider>(
                    builder: (context, provider, child) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: provider.showQuiz
                            ? const QuizCard()
                            : const SizedBox.shrink(),
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
