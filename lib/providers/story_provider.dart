import 'package:flutter/material.dart';
import 'package:peblo_assignment/services/tts_service.dart';

import '../models/quiz_model.dart';
import '../utils/app_data.dart';

class StoryProvider extends ChangeNotifier {
  final QuizModel quiz = QuizModel.fromJson(AppData.quiz);
  final TtsService _ttsService = TtsService();

  bool isLoading = false;
  bool isSpeaking = false;
  bool showQuiz = false;
  bool isCorrect = false;

  String? selectedAnswer;

  Future<void> initializeTts() async {
    await _ttsService.initialize(
      onComplete: () {
        stopSpeaking();
        showQuizCard();
      },
      onError: () {
        stopLoading();
        stopSpeaking();
      },
    );
  }

  Future<void> readStory() async {
    resetQuizState();
    startLoading();

    await initializeTts();

    stopLoading();

    startSpeaking();

    await _ttsService.speak(AppData.story);
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    isLoading = false;
    notifyListeners();
  }

  void startSpeaking() {
    isSpeaking = true;
    notifyListeners();
  }

  void stopSpeaking() {
    isSpeaking = false;
    notifyListeners();
  }

  void showQuizCard() {
    showQuiz = true;
    notifyListeners();
  }

  void checkAnswer(String answer) {
    if (isCorrect) return;

    selectedAnswer = answer;

    if (answer == quiz.answer) {
      isCorrect = true;
    } else {
      isCorrect = false;
    }

    notifyListeners();
  }

  void resetQuizState() {
    selectedAnswer = null;
    isCorrect = false;
    notifyListeners();
  }
}
