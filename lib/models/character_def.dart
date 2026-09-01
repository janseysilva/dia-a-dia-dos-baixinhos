import 'package:flutter/material.dart';

class CharacterDef {
  final String id;
  final String name;
  final String emoji;
  final Color color;

  const CharacterDef({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });
}

const List<CharacterDef> kCharacters = [
  CharacterDef(id: 'joao', name: 'João', emoji: '👦🏻', color: Color(0xFF4FC3F7)),
  CharacterDef(id: 'davi', name: 'Davi', emoji: '👦🏽', color: Color(0xFF81C784)),
  CharacterDef(id: 'miguel', name: 'Miguel', emoji: '👦🏿', color: Color(0xFFFFB74D)),
  CharacterDef(id: 'ana', name: 'Ana', emoji: '👧🏻', color: Color(0xFFF06292)),
  CharacterDef(id: 'sofia', name: 'Sofia', emoji: '👧🏽', color: Color(0xFFBA68C8)),
  CharacterDef(id: 'luana', name: 'Luana', emoji: '👧🏿', color: Color(0xFFFFD54F)),
];

CharacterDef characterById(String id) =>
    kCharacters.firstWhere((c) => c.id == id, orElse: () => kCharacters.first);
