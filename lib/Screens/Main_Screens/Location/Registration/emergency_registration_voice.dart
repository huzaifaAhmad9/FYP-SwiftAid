// // ignore_for_file: library_private_types_in_public_api

// import 'package:permission_handler/permission_handler.dart';
// import 'package:swift_aid/components/custom_button.dart';
// import 'package:audio_waveforms/audio_waveforms.dart';
// import 'package:swift_aid/app_colors/app_colors.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:swift_aid/components/toast.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:flutter/material.dart';
// import 'dart:io';

// class VoiceRecorderScreen extends StatefulWidget {
//   const VoiceRecorderScreen({super.key});

//   @override
//   _VoiceRecorderScreenState createState() => _VoiceRecorderScreenState();
// }

// class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
//   FlutterSoundRecorder? _recorder;
//   bool _isRecording = false;
//   final List<String> _recordings = [];
//   final List<RecorderController> _recorderControllers = [];
//   final PlayerController _playerController = PlayerController();
//   final Map<int, bool> _isPlaying = {};

//   @override
//   void initState() {
//     super.initState();
//     _initRecorder();
//   }

//   Future<void> _initRecorder() async {
//     _recorder = FlutterSoundRecorder();
//     await _recorder!.openRecorder();
//     await Permission.microphone.request();
//   }

//   Future<String> _getRecordingPath() async {
//     Directory tempDir = await getApplicationDocumentsDirectory();
//     String path =
//         '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
//     return path;
//   }

//   Future<void> _startRecording() async {
//     if (_isRecording) return;

//     final path = await _getRecordingPath();
//     final recorderController = RecorderController();

//     await _recorder!.startRecorder(
//       toFile: path,
//       codec: Codec.aacADTS,
//     );
//     recorderController.record(path: path);

//     setState(() {
//       _isRecording = true;
//       _recorderControllers.add(recorderController);
//     });
//   }

//   Future<void> _stopRecording() async {
//     if (!_isRecording) return;

//     final path = await _recorder!.stopRecorder();
//     if (path != null) {
//       _recordings.add(path);
//     }

//     setState(() {
//       _isRecording = false;
//     });
//   }

//   Future<void> _playOrPauseRecording(int index) async {
//     final controller = _playerController;

//     if (_isPlaying[index] == true) {
//       await controller.pausePlayer();
//       setState(() {
//         _isPlaying[index] = false;
//       });
//     } else {
//       await controller.stopPlayer();
//       await controller.preparePlayer(path: _recordings[index]);
//       await controller.startPlayer();

//       setState(() {
//         _isPlaying.updateAll((key, value) => false);
//         _isPlaying[index] = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       appBar: AppBar(
//         title: const Text(
//           'Voice Registration',
//           style: TextStyle(color: AppColors.whiteColor),
//         ),
//         backgroundColor: AppColors.primaryColor,
//         centerTitle: true,
//         iconTheme: const IconThemeData(
//           color: AppColors.whiteColor,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (_isRecording)
//               AudioWaveforms(
//                 enableGesture: false,
//                 size: Size(MediaQuery.of(context).size.width, 50.0),
//                 recorderController: _recorderControllers.isNotEmpty
//                     ? _recorderControllers.last
//                     : RecorderController(),
//                 waveStyle: const WaveStyle(
//                   waveColor: Colors.blue,
//                   extendWaveform: true,
//                   showMiddleLine: false,
//                 ),
//               )
//             else
//               const SizedBox(height: 50),
//             const SizedBox(height: 20),
//             Expanded(
//               child: _recordings.isEmpty
//                   ? const Center(child: Text('No recordings yet'))
//                   : ListView.builder(
//                       itemCount: _recordings.length,
//                       itemBuilder: (context, index) {
//                         String filename = _recordings[index].split('/').last;
//                         return Card(
//                           child: ListTile(
//                             leading: Icon(
//                               _isPlaying[index] == true
//                                   ? Icons.pause
//                                   : Icons.play_arrow,
//                             ),
//                             title: Text('Recording ${index + 1}'),
//                             subtitle: Text(filename),
//                             onTap: () => _playOrPauseRecording(index),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//             if (_recordings.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.only(left: 20, right: 100, bottom: 5),
//                 child: CustomButton(
//                   borderRadius: 20.0,
//                   text: 'Send Alert',
//                   onPressed: () {
//                     //! -----------------------------
//                   },
//                   backgroundColor: AppColors.primaryColor,
//                   width: 350,
//                 ),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: AvatarGlow(
//         animate: _isRecording,
//         glowColor: AppColors.primaryColor,
//         duration: const Duration(milliseconds: 2000),
//         glowShape: BoxShape.circle,
//         curve: Curves.fastOutSlowIn,
//         repeat: true,
//         child: GestureDetector(
//           onTap: () => showToast(msg: "Hold to record"),
//           onLongPress: _startRecording,
//           onLongPressUp: _stopRecording,
//           child: Material(
//             elevation: 8.0,
//             shape: const CircleBorder(),
//             child: CircleAvatar(
//               backgroundColor: AppColors.primaryColor,
//               radius: 30,
//               child: Icon(
//                 _isRecording ? Icons.mic : Icons.mic_none,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _recorder?.closeRecorder();
//     for (var controller in _recorderControllers) {
//       controller.dispose();
//     }
//     _playerController.dispose();
//     super.dispose();
//   }
// }

// ignore_for_file: library_private_types_in_public_api

import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swift_aid/components/custom_button.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:swift_aid/app_colors/app_colors.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swift_aid/components/toast.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:developer' show log;
import 'dart:io' show Directory;

class VoiceRecorderScreen extends StatefulWidget {
  const VoiceRecorderScreen({super.key});

  @override
  _VoiceRecorderScreenState createState() => _VoiceRecorderScreenState();
}

class _VoiceRecorderScreenState extends State<VoiceRecorderScreen> {
  final PlayerController _playerController = PlayerController();
  final List<RecorderController> _recorderControllers = [];
  final GlobalKey _recordButtonKey = GlobalKey();
  TutorialCoachMark? tutorialCoachMark;
  final Map<int, bool> _isPlaying = {};
  final List<String> _recordings = [];
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _initRecorder();
    WidgetsBinding.instance.addPostFrameCallback((_) => showTutorial());
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
    await Permission.microphone.request();
  }

  Future<String> _getRecordingPath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String path =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';
    return path;
  }

  Future<void> _startRecording() async {
    if (_isRecording) return;

    final path = await _getRecordingPath();
    final recorderController = RecorderController();

    await _recorder!.startRecorder(
      toFile: path,
      codec: Codec.aacADTS,
    );
    recorderController.record(path: path);

    setState(() {
      _isRecording = true;
      _recorderControllers.add(recorderController);
    });
  }

  Future<void> _stopRecording() async {
    if (!_isRecording) return;

    final path = await _recorder!.stopRecorder();
    if (path != null) {
      _recordings.add(path);
    }

    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playOrPauseRecording(int index) async {
    final controller = _playerController;

    if (_isPlaying[index] == true) {
      await controller.pausePlayer();
      setState(() {
        _isPlaying[index] = false;
      });
    } else {
      await controller.stopPlayer();
      await controller.preparePlayer(path: _recordings[index]);
      await controller.startPlayer();

      setState(() {
        _isPlaying.updateAll((key, value) => false);
        _isPlaying[index] = true;
      });
    }
  }

  void showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: [
        TargetFocus(
          identify: "record_button",
          keyTarget: _recordButtonKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Text(
                "Hold this button to record your voice.",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
      colorShadow: Colors.black.withOpacity(0.8),
      textSkip: "SKIP",
      alignSkip: Alignment.topRight,
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        log("Tutorial finished");
      },
      onClickTarget: (target) {
        log("Clicked on target: $target");
      },
      onSkip: () {
        log("Tutorial skipped");
        return true;
      },
    )..show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text(
          'Voice Registration',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (_isRecording)
              AudioWaveforms(
                enableGesture: false,
                size: Size(MediaQuery.of(context).size.width, 50.0),
                recorderController: _recorderControllers.isNotEmpty
                    ? _recorderControllers.last
                    : RecorderController(),
                waveStyle: const WaveStyle(
                  waveColor: Colors.blue,
                  extendWaveform: true,
                  showMiddleLine: false,
                ),
              )
            else
              const SizedBox(height: 50),
            const SizedBox(height: 20),
            Expanded(
              child: _recordings.isEmpty
                  ? const Center(child: Text('No recordings yet'))
                  : ListView.builder(
                      itemCount: _recordings.length,
                      itemBuilder: (context, index) {
                        String filename = _recordings[index].split('/').last;
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              _isPlaying[index] == true
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            title: Text('Recording ${index + 1}'),
                            subtitle: Text(filename),
                            onTap: () => _playOrPauseRecording(index),
                          ),
                        );
                      },
                    ),
            ),
            if (_recordings.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 100, bottom: 5),
                child: CustomButton(
                  borderRadius: 20.0,
                  text: 'Send Alert',
                  onPressed: () {
                    //! -----------------------------
                  },
                  backgroundColor: AppColors.primaryColor,
                  width: 350,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: AvatarGlow(
        animate: _isRecording,
        glowColor: AppColors.primaryColor,
        duration: const Duration(milliseconds: 2000),
        glowShape: BoxShape.circle,
        curve: Curves.fastOutSlowIn,
        repeat: true,
        child: GestureDetector(
          key: _recordButtonKey,
          onTap: () => showToast(msg: "Hold to record"),
          onLongPress: _startRecording,
          onLongPressUp: _stopRecording,
          child: Material(
            elevation: 8.0,
            shape: const CircleBorder(),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 30,
              child: Icon(
                _isRecording ? Icons.mic : Icons.mic_none,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    for (var controller in _recorderControllers) {
      controller.dispose();
    }
    _playerController.dispose();
    super.dispose();
  }
}
