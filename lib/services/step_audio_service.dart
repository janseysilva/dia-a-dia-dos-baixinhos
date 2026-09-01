import 'package:audioplayers/audioplayers.dart';

/// Toca as narrações dos passos da rotina — áudios gravados uma vez com a
/// voz da Letícia (Azure), empacotados no app. Sem TTS ao vivo: mais
/// natural, funciona sem internet, e sem custo por uso.
class StepAudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String audioId) async {
    try {
      await _player.stop();
      await _player.play(AssetSource('audio/steps/$audioId.mp3'));
    } catch (_) {
      // Áudio ausente pra esse passo — segue silencioso, o texto na tela continua.
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (_) {}
  }
}
