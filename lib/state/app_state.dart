import 'package:flutter/foundation.dart';
import '../models/routine_task.dart';
import '../services/local_store.dart';

class AppState extends ChangeNotifier {
  final LocalStore _store = LocalStore();

  String? selectedCharacterId;
  Set<String> doneToday = {};
  int currentStreak = 0;
  int bestStreak = 0;
  bool loading = true;
  bool justCompletedToday = false;
  String? childName;
  String? bestFriendName;
  bool? goesToSchool;
  bool onboardingQuestionsDone = false;

  int get totalTasks => kDefaultTasks.length;
  bool get allDoneToday => doneToday.length >= totalTasks;
  double get progressToday => totalTasks == 0 ? 0 : doneToday.length / totalTasks;

  int get characterStage {
    if (bestStreak >= 14) return 3;
    if (bestStreak >= 7) return 2;
    if (bestStreak >= 3) return 1;
    return 0;
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> init() async {
    childName = await _store.loadChildName();
    selectedCharacterId = await _store.loadCharacterId();
    bestFriendName = await _store.loadBestFriendName();
    goesToSchool = await _store.loadGoesToSchool();
    onboardingQuestionsDone = await _store.loadOnboardingQuestionsDone();
    currentStreak = await _store.loadCurrentStreak();
    bestStreak = await _store.loadBestStreak();
    final lastActive = await _store.loadLastActiveDate();
    final today = _todayKey();

    if (lastActive == null) {
      await _store.saveLastActiveDate(today);
      doneToday = {};
    } else if (lastActive != today) {
      final previousDone = await _store.loadTasksDoneToday();
      if (previousDone.length < totalTasks) {
        currentStreak = 0;
        await _store.saveCurrentStreak(0);
      }
      doneToday = {};
      await _store.saveTasksDoneToday(doneToday);
      await _store.saveLastActiveDate(today);
    } else {
      doneToday = await _store.loadTasksDoneToday();
    }

    loading = false;
    notifyListeners();
  }

  Future<void> selectCharacter(String id) async {
    selectedCharacterId = id;
    await _store.saveCharacterId(id);
    notifyListeners();
  }

  Future<void> saveChildName(String name) async {
    childName = name;
    await _store.saveChildName(name);
    notifyListeners();
  }

  Future<void> saveOnboardingAnswers({required bool school, String? bestFriend}) async {
    goesToSchool = school;
    bestFriendName = (bestFriend == null || bestFriend.trim().isEmpty) ? null : bestFriend.trim();
    onboardingQuestionsDone = true;
    await _store.saveGoesToSchool(school);
    await _store.saveBestFriendName(bestFriendName);
    await _store.saveOnboardingQuestionsDone(true);
    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final wasAllDone = allDoneToday;
    if (doneToday.contains(id)) {
      doneToday.remove(id);
    } else {
      doneToday.add(id);
    }
    await _store.saveTasksDoneToday(doneToday);

    if (!wasAllDone && allDoneToday) {
      currentStreak += 1;
      if (currentStreak > bestStreak) {
        bestStreak = currentStreak;
        await _store.saveBestStreak(bestStreak);
      }
      await _store.saveCurrentStreak(currentStreak);
      justCompletedToday = true;
    } else if (wasAllDone && !allDoneToday) {
      currentStreak = currentStreak > 0 ? currentStreak - 1 : 0;
      await _store.saveCurrentStreak(currentStreak);
      justCompletedToday = false;
    }

    notifyListeners();
  }

  void clearJustCompletedFlag() {
    justCompletedToday = false;
    notifyListeners();
  }
}
