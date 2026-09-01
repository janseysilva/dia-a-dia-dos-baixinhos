import 'package:flutter/material.dart';

class AppColors {
  static const mint = Color(0xFF2FD3B5);
  static const coral = Color(0xFFFF7E67);
  static const sun = Color(0xFFFFC857);
  static const textDark = Color(0xFF2E3A3A);
  static const cardBg = Color(0xFFFFFFFF);
}

final appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: const Color(0xFFF2FBF9),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.mint,
    primary: AppColors.mint,
    secondary: AppColors.coral,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.textDark, fontSize: 16),
  ),
);

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFDFF7F1), Color(0xFFFFF3E0)],
        ),
      ),
      child: child,
    );
  }
}
