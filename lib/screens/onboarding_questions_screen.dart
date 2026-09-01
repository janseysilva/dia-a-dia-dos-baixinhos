import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'routine_screen.dart';

/// Perguntas rápidas sobre a criança, feitas uma única vez, pra deixar o
/// app mais pessoal (usadas depois em falas do personagem).
class OnboardingQuestionsScreen extends StatefulWidget {
  const OnboardingQuestionsScreen({super.key});

  @override
  State<OnboardingQuestionsScreen> createState() => _OnboardingQuestionsScreenState();
}

class _OnboardingQuestionsScreenState extends State<OnboardingQuestionsScreen> {
  bool? _goesToSchool;
  final _friendController = TextEditingController();

  @override
  void dispose() {
    _friendController.dispose();
    super.dispose();
  }

  void _finish() async {
    if (_goesToSchool == null) return;
    final state = context.read<AppState>();
    await state.saveOnboardingAnswers(
      school: _goesToSchool!,
      bestFriend: _friendController.text,
    );
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const RoutineScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = context.watch<AppState>().childName ?? '';

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  'Só mais duas perguntinhas, $name!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  '🏫 Você vai pra escola?',
                  style: TextStyle(fontSize: 18, color: AppColors.textDark),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _ChoiceButton(
                        label: 'Sim',
                        selected: _goesToSchool == true,
                        onTap: () => setState(() => _goesToSchool = true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ChoiceButton(
                        label: 'Não',
                        selected: _goesToSchool == false,
                        onTap: () => setState(() => _goesToSchool = false),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Text(
                  '🤝 Quem é seu melhor amigo(a)? (se quiser contar)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: AppColors.textDark),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _friendController,
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Nome do seu amigo(a)',
                    filled: true,
                    fillColor: AppColors.cardBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.mint,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: _goesToSchool == null ? null : _finish,
                    child: const Text(
                      'Começar!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
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

class _ChoiceButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ChoiceButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.mint : AppColors.cardBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: selected ? Colors.white : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}
