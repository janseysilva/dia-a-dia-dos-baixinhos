import 'package:flutter/material.dart';
import '../models/character_def.dart';

class CharacterAvatar extends StatelessWidget {
  final CharacterDef character;
  final double size;
  final int stage;
  final bool selected;

  const CharacterAvatar({
    super.key,
    required this.character,
    this.size = 96,
    this.stage = 0,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: character.color.withValues(alpha: 0.25),
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? character.color : Colors.transparent,
              width: 4,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            character.emoji,
            style: TextStyle(fontSize: size * 0.55),
          ),
        ),
        if (stage > 0)
          Positioned(
            top: -4,
            right: -4,
            child: Text(
              stage >= 3 ? '👑' : '⭐',
              style: TextStyle(fontSize: size * 0.28),
            ),
          ),
      ],
    );
  }
}
