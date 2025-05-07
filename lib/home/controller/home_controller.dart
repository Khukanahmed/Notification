import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceController extends GetxController {
  final recorder = FlutterSoundRecorder();
  final player = FlutterSoundPlayer();

  var isRecording = false.obs;
  var isPlaying = false.obs;
  var messageText = ''.obs;

  String? filePath;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    await Permission.microphone.request();
    await recorder.openRecorder();
    await player.openPlayer();
  }

  Future<void> startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    filePath = '${dir.path}/recorded.aac';

    await recorder.startRecorder(toFile: filePath, codec: Codec.aacADTS);
    isRecording.value = true;
  }

  Future<void> stopRecording() async {
    await recorder.stopRecorder();
    isRecording.value = false;
  }

  Future<void> playRecording() async {
    if (filePath == null) return;
    await player.startPlayer(
      fromURI: filePath,
      whenFinished: () {
        isPlaying.value = false;
      },
    );
    isPlaying.value = true;
  }

  Future<void> stopPlayback() async {
    await player.stopPlayer();
    isPlaying.value = false;
  }

  Future<void> sendVoiceAndText() async {
    if (filePath == null || messageText.value.isEmpty) return;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'https://your-api-endpoint.com/upload',
      ), // Replace with real API
    );

    request.fields['message'] = messageText.value;
    request.files.add(await http.MultipartFile.fromPath('audio', filePath!));

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Upload successful');
    } else {
      print('Upload failed: ${response.statusCode}');
    }
  }

  @override
  void onClose() {
    recorder.closeRecorder();
    player.closePlayer();
    super.onClose();
  }
}
