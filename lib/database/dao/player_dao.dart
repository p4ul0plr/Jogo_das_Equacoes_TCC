import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jogo_das_equacoes/models/player.dart';

class PlayerDao {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  create(Player player) {
    _db.collection('players').add(player.toJson());
  }
}
