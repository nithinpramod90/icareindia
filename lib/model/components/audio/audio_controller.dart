import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart' as ap;

class AudioController extends GetxController {
  var showPlayer = false.obs; // Observable for the player state
  ap.AudioSource? audioSource;

  void setAudioSource(ap.AudioSource source) {
    audioSource = source;
    showPlayer.value = true; // Set showPlayer to true to display the player
  }

  void resetAudio() {
    showPlayer.value = false; // Set showPlayer to false to hide the player
    audioSource = null;
  }
}
