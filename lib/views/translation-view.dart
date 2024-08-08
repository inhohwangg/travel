import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:travel_project/controllers/translation-ctl.dart';
import 'package:travel_project/main.dart';
import 'package:travel_project/services/print-color.dart';

class TranslationView extends GetView<TranslationController> {
  TranslationView({super.key});

  @override
  Widget build(BuildContext context) {
    TranslationController controller = Get.put(TranslationController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Translation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                  labelText: 'Enter text to translate',
                  border: OutlineInputBorder()),
            ),
            Gap(10),
            ElevatedButton(
              onPressed: () {
                printYellow(getStorage.read('geminiKey'));
                controller.translateText(
                    controller.textController.text, controller.targetLanguage);
              },
              child: Text('번역'),
            ),
            Gap(10),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return CircularProgressIndicator();
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('번역된 문자 : ${controller.translatedText.value}'),
                      Text('감지된 언어 : ${controller.detectedLanguage.value}')
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
