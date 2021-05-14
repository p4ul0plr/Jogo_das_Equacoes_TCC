import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class Sounds {
  AudioPlayer audioPlayer;
  AudioCache audioCache;

  void clickSound() async {
    initState();
    await audioCache.play(
      'audio/click.mp3',
      volume: 0.1,
    );
  }

  void successSound() async {
    initState();
    await audioCache.play(
      'audio/success.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
  }

  void failureSound() async {
    initState();
    await audioCache.play(
      'audio/failure.wav',
      mode: PlayerMode.LOW_LATENCY,
    );
  }

  void tictacSound() async {
    initState();
    await audioCache.play(
      'audio/tictac.wav',
      volume: 0.02,
    );
  }

  void initState() {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
  }

  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearCache();
  }
}
