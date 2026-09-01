import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character_def.dart';
import '../models/routine_task.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/character_avatar.dart';
import 'task_guide_screen.dart';

class RoutineScreen extends StatefulWidget {
  const RoutineScreen({super.key});

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final character = characterById(state.selectedCharacterId ?? kCharacters.first.id);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.justCompletedToday) {
        state.clearJustCompletedFlag();
        _showCelebration(context, character);
      }
    });

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  CharacterAvatar(
                    character: character,
                    size: 88,
                    stage: state.characterStage,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.childName != null ? 'Oi, ${state.childName}!' : character.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        Text(
                          'com ${character.name}',
                          style: const TextStyle(fontSize: 13, color: AppColors.textDark),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '🔥 ${state.currentStreak} dia(s) seguido(s)',
                          style: const TextStyle(fontSize: 15, color: AppColors.textDark),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: state.progressToday,
                            minHeight: 10,
                            backgroundColor: Colors.white,
                            valueColor: const AlwaysStoppedAnimation(AppColors.mint),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              for (final period in Period.values) ...[
                Text(
                  periodLabel(period),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 8),
                for (final task in kDefaultTasks.where((t) => t.period == period))
                  _TaskRow(
                    task: task,
                    done: state.doneToday.contains(task.id),
                    onTap: () {
                      if (state.doneToday.contains(task.id)) {
                        context.read<AppState>().toggleTask(task.id);
                        return;
                      }
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TaskGuideScreen(task: task, character: character),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showCelebration(BuildContext context, CharacterDef character) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(character.emoji, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 12),
            const Text(
              'Dia completo! 🎉',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${character.name} ficou muito feliz com você hoje!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Center(
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Continuar'),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskRow extends StatelessWidget {
  final RoutineTaskDef task;
  final bool done;
  final VoidCallback onTap;

  const _TaskRow({required this.task, required this.done, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Text(task.emoji, style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task.label,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textDark,
                      decoration: done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
                Icon(
                  done ? Icons.check_circle : Icons.circle_outlined,
                  color: done ? AppColors.mint : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
