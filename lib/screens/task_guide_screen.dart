import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character_def.dart';
import '../models/routine_task.dart';
import '../services/step_audio_service.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/character_avatar.dart';

/// Guia passo a passo (estilo "storybook") de como fazer a tarefa, pra
/// criança acompanhar junto com o adulto enquanto faz de verdade — em vez
/// de só marcar um checkbox depois. Alguns passos são perguntas (ex: "o
/// que você vai tomar no café?"), com uma reação diferente por resposta.
class TaskGuideScreen extends StatefulWidget {
  final RoutineTaskDef task;
  final CharacterDef character;

  const TaskGuideScreen({super.key, required this.task, required this.character});

  @override
  State<TaskGuideScreen> createState() => _TaskGuideScreenState();
}

class _TaskGuideScreenState extends State<TaskGuideScreen> {
  int _stepIndex = 0;
  TaskChoice? _selectedChoice;
  late final StepAudioService _audioService;

  @override
  void initState() {
    super.initState();
    _audioService = context.read<StepAudioService>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _speakCurrentStep());
  }

  void _speakCurrentStep() {
    final steps = widget.task.steps;
    if (steps.isEmpty) return;
    _audioService.play(steps[_stepIndex].audioId);
  }

  /// O áudio gravado nunca inclui o nome do amigo(a) (não dá pra gravar
  /// antecipadamente um nome livre) — só o texto na tela é personalizado.
  String _textFor(TaskStep step) {
    final state = context.read<AppState>();
    if (widget.task.id == 'dormir' &&
        step == widget.task.steps.last &&
        state.bestFriendName != null) {
      return '${step.text} Amanhã você pode contar pro ${state.bestFriendName} como foi o seu dia!';
    }
    return step.text;
  }

  void _pickChoice(TaskChoice choice) {
    setState(() => _selectedChoice = choice);
    _audioService.play(choice.audioId);
  }

  void _next() {
    final steps = widget.task.steps;
    if (_stepIndex < steps.length - 1) {
      setState(() {
        _stepIndex++;
        _selectedChoice = null;
      });
      _speakCurrentStep();
      return;
    }
    _audioService.stop();
    final state = context.read<AppState>();
    if (!state.doneToday.contains(widget.task.id)) {
      state.toggleTask(widget.task.id);
    }
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _audioService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.task.steps;
    final step = steps[_stepIndex];
    final isLast = _stepIndex >= steps.length - 1;
    final isQuestion = step.choices != null;
    final canAdvance = !isQuestion || _selectedChoice != null;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Expanded(
                      child: Text(
                        widget.task.label,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const Spacer(),
                CharacterAvatar(character: widget.character, size: 72),
                const SizedBox(height: 20),
                Text(
                  _selectedChoice?.emoji ?? step.emoji,
                  style: const TextStyle(fontSize: 96),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    _selectedChoice?.reaction ?? _textFor(step),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18, color: AppColors.textDark),
                  ),
                ),
                if (isQuestion && _selectedChoice == null) ...[
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: step.choices!
                        .map((choice) => _ChoiceChip(choice: choice, onTap: () => _pickChoice(choice)))
                        .toList(),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  '${_stepIndex + 1} de ${steps.length}',
                  style: const TextStyle(color: AppColors.textDark),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: !canAdvance
                          ? Colors.grey
                          : (isLast ? AppColors.mint : AppColors.coral),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                    onPressed: canAdvance ? _next : null,
                    child: Text(
                      isLast ? 'Consegui! 🎉' : 'Próximo',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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

class _ChoiceChip extends StatelessWidget {
  final TaskChoice choice;
  final VoidCallback onTap;

  const _ChoiceChip({required this.choice, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBg,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Column(
            children: [
              Text(choice.emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(height: 6),
              Text(
                choice.label,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
