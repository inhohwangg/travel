import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:travel_project/main.dart';
import 'package:travel_project/services/print-color.dart';

class TranslationController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final String targetLanguage = 'ko';
  RxBool isLoading = false.obs;
  RxString translatedText = ''.obs;
  RxString detectedLanguage = ''.obs;

  final Gemini gemini = Gemini.init(
      apiKey: getStorage.read('geminiKey'),
      baseURL: 'https://api.gemini.com/v1/');

  Future<void> translateText(String text, String targetLanguage) async {
    isLoading.value = true;
    try {
      final res = await gemini.text(
        text,
        modelName: 'gemini-pro',
        generationConfig: GenerationConfig(
          stopSequences: [],
          temperature: 0.7,
          maxOutputTokens: 100,
          topP: 0.9,
          topK: 50,
        ),
      );
      //  if (res != null && res.text != null) {
      //   translatedText.value = res.text!;
      //   detectedLanguage.value = targetLanguage;
      // } else {
      //   throw Exception('No translation text received');
      // }
      inspect(res);
      inspect(res);
    } catch (e, s) {
      printRed('번역 실패 : $e');
      printRed('번역 실패 StackTrace : $s');
    } finally {
      isLoading.value = false;
    }
  }
}
