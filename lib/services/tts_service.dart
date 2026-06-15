import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> initialize({
    required Function() onComplete,
    required Function() onError,
  }) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.setPitch(1.0);

    flutterTts.setCompletionHandler(() {
      onComplete();
    });

    flutterTts.setErrorHandler((message) {
      onError();
    });
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}