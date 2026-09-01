import 'package:shared_preferences/shared_preferences.dart';

class LocalStore {
  static const _kCharacterId = 'character_id';
  static const _kLastActiveDate = 'last_active_date';
  static const _kTasksDoneToday = 'tasks_done_today';
  static const _kCurrentStreak = 'current_streak';
  static const _kBestStreak = 'best_streak';
  static const _kChildName = 'child_name';
  static const _kBestFriendName = 'best_friend_name';
  static const _kGoesToSchool = 'goes_to_school';
  static const _kOnboardingQuestionsDone = 'onboarding_questions_done';

  Future<String?> loadChildName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kChildName);
  }

  Future<void> saveChildName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kChildName, name);
  }

  Future<String?> loadBestFriendName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kBestFriendName);
  }

  Future<void> saveBestFriendName(String? name) async {
    final prefs = await SharedPreferences.getInstance();
    if (name == null || name.isEmpty) {
      await prefs.remove(_kBestFriendName);
    } else {
      await prefs.setString(_kBestFriendName, name);
    }
  }

  Future<bool?> loadGoesToSchool() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_kGoesToSchool) ? prefs.getBool(_kGoesToSchool) : null;
  }

  Future<void> saveGoesToSchool(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kGoesToSchool, value);
  }

  Future<bool> loadOnboardingQuestionsDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kOnboardingQuestionsDone) ?? false;
  }

  Future<void> saveOnboardingQuestionsDone(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingQuestionsDone, value);
  }

  Future<String?> loadCharacterId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kCharacterId);
  }

  Future<void> saveCharacterId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kCharacterId, id);
  }

  Future<String?> loadLastActiveDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLastActiveDate);
  }

  Future<void> saveLastActiveDate(String isoDate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLastActiveDate, isoDate);
  }

  Future<Set<String>> loadTasksDoneToday() async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_kTasksDoneToday) ?? []).toSet();
  }

  Future<void> saveTasksDoneToday(Set<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_kTasksDoneToday, ids.toList());
  }

  Future<int> loadCurrentStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kCurrentStreak) ?? 0;
  }

  Future<void> saveCurrentStreak(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kCurrentStreak, value);
  }

  Future<int> loadBestStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kBestStreak) ?? 0;
  }

  Future<void> saveBestStreak(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kBestStreak, value);
  }
}
