import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/character_select_screen.dart';
import 'screens/name_screen.dart';
import 'screens/onboarding_questions_screen.dart';
import 'screens/routine_screen.dart';
import 'services/step_audio_service.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()..init()),
        Provider(create: (_) => StepAudioService()),
      ],
      child: MaterialApp(
        title: 'Rotina Kids',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const _StartGate(),
      ),
    );
  }
}

class _StartGate extends StatelessWidget {
  const _StartGate();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    if (state.loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.childName == null) {
      return const NameScreen();
    }

    if (state.selectedCharacterId == null) {
      return const CharacterSelectScreen();
    }

    if (!state.onboardingQuestionsDone) {
      return const OnboardingQuestionsScreen();
    }

    return const RoutineScreen();
  }
}
