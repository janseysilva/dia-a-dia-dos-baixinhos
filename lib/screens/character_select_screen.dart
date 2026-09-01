import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character_def.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/character_avatar.dart';
import 'onboarding_questions_screen.dart';

class CharacterSelectScreen extends StatelessWidget {
  const CharacterSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                const Text(
                  'Escolha seu personagem!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ele vai crescer junto com você',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.textDark),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.9,
                    children: kCharacters
                        .map((c) => _CharacterCard(character: c))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final CharacterDef character;
  const _CharacterCard({required this.character});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(20),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          final state = context.read<AppState>();
          await state.selectCharacter(character.id);
          if (context.mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const OnboardingQuestionsScreen()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CharacterAvatar(character: character, size: 80),
              const SizedBox(height: 12),
              Text(
                character.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
