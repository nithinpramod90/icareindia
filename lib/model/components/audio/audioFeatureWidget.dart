// AudioFeatureWidget.dart
import 'package:flutter/material.dart';
import 'package:icareindia/model/components/audio/audioPlayerWidget.dart';
import 'package:icareindia/model/components/audio/audioRecorder.dart';

class AudioFeatureWidget extends StatefulWidget {
  const AudioFeatureWidget({Key? key}) : super(key: key);

  @override
  _AudioFeatureWidgetState createState() => _AudioFeatureWidgetState();
}

class _AudioFeatureWidgetState extends State<AudioFeatureWidget> {
  bool showPlayer = false;
  String? audioPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showPlayer && audioPath != null)
            AudioPlayerWidget(
              source: audioPath!,
              onDelete: () {
                setState(() {
                  showPlayer = false;
                  audioPath = null;
                });
              },
            )
          else
            AudioRecorder(
              onStop: (String path) {
                setState(() {
                  audioPath = path;
                  showPlayer = true;
                });
              },
            ),
          if (!showPlayer)
            const Text(
              'Press record to start',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
        ],
      ),
    );
  }
}
