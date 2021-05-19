import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:jogo_das_equacoes/database/authentication_service.dart';
import 'package:jogo_das_equacoes/database/firebase-message.dart';
import 'package:jogo_das_equacoes/models/consts.dart';
import 'package:jogo_das_equacoes/models/player.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class PlayerDao {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> _players;

  PlayerDao() {
    _players = _db.collection('players');
  }

  void incrementQuest(String id) async {
    int _quest;
    int _stage;
    var _player = await read(id);
    _quest = _player.playerStatus.quest;
    _stage = _player.playerStatus.stage;
    if (_quest < NUMBER_OF_QUESTS_IN_EACH_STAGE * _stage) {
      _quest++;
    } else if (_stage < NUMBER_OF_STAGES) {
      _quest++;
      _stage++;
    }
    await _players.doc(id).update({
      'playerStatus.quest': _quest,
      'playerStatus.stage': _stage,
    });
  }

  void create(Player player) {
    try {
      _players.doc(player.id).set(player.toJson());
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
    }
  }

  Future<Player> read(String id) async {
    try {
      return await _players.doc(id).get().then((value) {
        if (value.id == id) {
          return Player.fromJson(value.data());
        }
        return null;
      });
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
      return null;
    }
  }

  readAll() {
    try {
      var stremListPlayers = _players
          .orderBy('playerStatus.score', descending: true)
          .snapshots()
          .map(
            (snapshots) => snapshots.docs
                .map(
                  (doc) => Player.fromJson(doc.data()),
                )
                .toList(),
          )
          .asBroadcastStream();
      return stremListPlayers;
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
    }
  }

  readfirstPlaced() {
    try {
      var stremListPlayers = _players
          .orderBy('playerStatus.score', descending: true)
          .limit(3)
          .snapshots()
          .map(
            (snapshots) => snapshots.docs
                .map(
                  (doc) => Player.fromJson(doc.data()),
                )
                .toList(),
          )
          .asBroadcastStream();
      return stremListPlayers;
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
    }
  }

  readlastPlaced() {
    try {
      var stremListPlayers = _players
          .orderBy('playerStatus.score', descending: true)
          .limit(12)
          .snapshots()
          .map(
            (snapshots) => snapshots.docs
                .map(
                  (doc) => Player.fromJson(doc.data()),
                )
                .toList(),
          )
          .asBroadcastStream();
      return stremListPlayers;
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
    }
  }

  void newCreate(Player player, BuildContext context) async {
    User _currentUser;
    await context.read<AuthenticationService>().register(
          email: player.email,
          password: player.password,
        );
    await context.read<AuthenticationService>().signIn(
          email: player.email,
          password: player.password,
        );
    _currentUser = context.read<AuthenticationService>().currentUser;
    try {
      _players.doc(_currentUser.uid).set(player.toJson());
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
    }
  }

  void delete(String id) {
    try {
      _players.doc(id).delete();
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
    }
  }

  void update(Map<String, Object> data, String id) {
    try {
      _players.doc(id).update(data);
    } on FirebaseException catch (e) {
      print(FirebaseMessage().verifyErroCode(e.message));
    }
  }
}
