import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/home/controller/home_controller.dart';

class VoicePage extends StatelessWidget {
  final controller = Get.put(VoiceController());
  final textController = TextEditingController();

  VoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voice + Text Sender')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: textController,
              onChanged: (val) => controller.messageText.value = val,
              decoration: InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // 🎙 Recording button
            Obx(
              () => GestureDetector(
                onTap: () async {
                  if (!controller.isRecording.value) {
                    await controller.startRecording();
                  } else {
                    await controller.stopRecording();
                    await controller.sendVoiceAndText();
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: controller.isRecording.value ? 100 : 80,
                  height: controller.isRecording.value ? 100 : 80,
                  decoration: BoxDecoration(
                    color:
                        controller.isRecording.value ? Colors.red : Colors.blue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (controller.isRecording.value)
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.6),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                    ],
                  ),
                  child: Icon(Icons.mic, color: Colors.white, size: 40),
                ),
              ),
            ),

            SizedBox(height: 40),

            // ▶️ Play/Stop button
            Obx(
              () => ElevatedButton.icon(
                onPressed: () async {
                  if (!controller.isPlaying.value) {
                    await controller.playRecording();
                  } else {
                    await controller.stopPlayback();
                  }
                },
                icon: Icon(
                  controller.isPlaying.value ? Icons.stop : Icons.play_arrow,
                ),
                label: Text(
                  controller.isPlaying.value
                      ? 'Stop Playback'
                      : 'Play Recording',
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
