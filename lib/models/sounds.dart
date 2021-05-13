import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Sounds {
  AudioCache audioCache = AudioCache(fixedPlayer: new AudioPlayer());

  void clearCache() {
    audioCache.clearCache();
  }

  void clickSound() {
    audioCache.play(
      'audio/click.mp3',
      volume: 0.1,
    );
  }

  void successSound() {
    audioCache.play(
      'audio/success.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
  }

  void failureSound() {
    audioCache.play(
      'audio/failure.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
  }

  void tictacSound() {
    audioCache.play(
      'audio/tictac.wav',
      volume: 0.02,
    );
  }
}
