import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessTrackerApp());
}

// ============================================================
// APP - STATEFUL WIDGET
// ============================================================

class FitnessTrackerApp extends StatefulWidget {
  const FitnessTrackerApp({super.key});

  @override
  State<FitnessTrackerApp> createState() => _FitnessTrackerAppState();
}

class _FitnessTrackerAppState extends State<FitnessTrackerApp> {
  ThemeMode themeMode = ThemeMode.light;

  void changeTheme(bool darkMode) {
    setState(() {
      themeMode = darkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitTrack',

      themeMode: themeMode,

      // LIGHT THEME
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      // DARK THEME
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF101410),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      home: LoginPage(
        onThemeChanged: changeTheme,
        isDarkMode: themeMode == ThemeMode.dark,
      ),
    );
  }
}

// ============================================================
// LOGIN PAGE - STATEFUL WIDGET
// ============================================================

class LoginPage extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const LoginPage({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool hidePassword = true;

  void login() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter email and password'),
        ),
      );
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email'),
        ),
      );
      return;
    }

    if (password.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password must contain at least 4 characters'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FitnessHome(
            onThemeChanged: widget.onThemeChanged,
            isDarkMode: widget.isDarkMode,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                // LOGO
                Container(
                  height: 95,
                  width: 95,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Icon(
                    Icons.fitness_center,
                    color: Colors.white,
                    size: 52,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  'FitTrack',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Your personal fitness companion',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 40),

                // EMAIL
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // PASSWORD
                TextField(
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  'Track • Train • Transform',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// ============================================================
// FITNESS HOME - STATEFUL WIDGET
// ============================================================

class FitnessHome extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const FitnessHome({
    super.key,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<FitnessHome> createState() => _FitnessHomeState();
}

class _FitnessHomeState extends State<FitnessHome> {
  int selectedIndex = 0;

  int steps = 6842;
  int calories = 420;
  int water = 5;
  int streak = 7;

  String selectedGoal = 'Stay Healthy';

  String userName = 'Fitness User';
  String height = '170 cm';
  String weight = '65 kg';

  bool notifications = true;
  bool reminders = true;

  // TIMER
  Timer? workoutTimer;
  int workoutSeconds = 0;
  bool timerRunning = false;

  // 30 DAY PLAN
  final Set<int> completedDays = {};

  // ==========================================================
  // WORKOUTS FOR EACH GOAL
  // ==========================================================

  final Map<String, List<Map<String, dynamic>>> goalWorkouts = {
    'Weight Loss': [
      {
        'name': 'Brisk Walking',
        'duration': '30 min',
        'calories': '180 kcal',
        'icon': Icons.directions_walk,
      },
      {
        'name': 'Cardio Workout',
        'duration': '30 min',
        'calories': '250 kcal',
        'icon': Icons.directions_run,
      },
      {
        'name': 'HIIT Training',
        'duration': '25 min',
        'calories': '280 kcal',
        'icon': Icons.flash_on,
      },
      {
        'name': 'Cycling',
        'duration': '35 min',
        'calories': '300 kcal',
        'icon': Icons.directions_bike,
      },
    ],

    'Muscle Gain': [
      {
        'name': 'Upper Body Strength',
        'duration': '40 min',
        'calories': '300 kcal',
        'icon': Icons.fitness_center,
      },
      {
        'name': 'Lower Body Strength',
        'duration': '45 min',
        'calories': '350 kcal',
        'icon': Icons.accessibility_new,
      },
      {
        'name': 'Core Workout',
        'duration': '30 min',
        'calories': '220 kcal',
        'icon': Icons.self_improvement,
      },
      {
        'name': 'Full Body Strength',
        'duration': '45 min',
        'calories': '380 kcal',
        'icon': Icons.sports_gymnastics,
      },
    ],

    'Improve Fitness': [
      {
        'name': 'Morning Run',
        'duration': '30 min',
        'calories': '240 kcal',
        'icon': Icons.directions_run,
      },
      {
        'name': 'Full Body Workout',
        'duration': '40 min',
        'calories': '320 kcal',
        'icon': Icons.fitness_center,
      },
      {
        'name': 'Cycling',
        'duration': '35 min',
        'calories': '280 kcal',
        'icon': Icons.directions_bike,
      },
      {
        'name': 'Cardio Training',
        'duration': '30 min',
        'calories': '260 kcal',
        'icon': Icons.favorite,
      },
    ],

    'Flexibility': [
      {
        'name': 'Morning Yoga',
        'duration': '30 min',
        'calories': '120 kcal',
        'icon': Icons.self_improvement,
      },
      {
        'name': 'Full Body Stretch',
        'duration': '25 min',
        'calories': '100 kcal',
        'icon': Icons.accessibility_new,
      },
      {
        'name': 'Pilates',
        'duration': '35 min',
        'calories': '160 kcal',
        'icon': Icons.spa,
      },
      {
        'name': 'Relaxation Yoga',
        'duration': '20 min',
        'calories': '90 kcal',
        'icon': Icons.air,
      },
    ],

    'Stay Healthy': [
      {
        'name': 'Morning Walk',
        'duration': '30 min',
        'calories': '150 kcal',
        'icon': Icons.directions_walk,
      },
      {
        'name': 'Full Body Workout',
        'duration': '35 min',
        'calories': '250 kcal',
        'icon': Icons.fitness_center,
      },
      {
        'name': 'Cycling',
        'duration': '30 min',
        'calories': '240 kcal',
        'icon': Icons.directions_bike,
      },
      {
        'name': 'Yoga & Stretching',
        'duration': '25 min',
        'calories': '120 kcal',
        'icon': Icons.self_improvement,
      },
    ],
  };

  // ==========================================================
  // 30 DAY PLANS
  // ==========================================================

  final Map<String, List<Map<String, String>>> goalPlans = {
    'Weight Loss': List.generate(
      30,
      (index) {
        final workouts = [
          'Brisk Walking',
          'Cardio Workout',
          'HIIT Training',
          'Rest & Stretch',
          'Cycling',
          'Cardio Workout',
          'Active Rest',
        ];

        return {
          'workout': workouts[index % workouts.length],
          'duration': '${25 + (index % 4) * 5} min',
        };
      },
    ),

    'Muscle Gain': List.generate(
      30,
      (index) {
        final workouts = [
          'Upper Body Strength',
          'Lower Body Strength',
          'Core Workout',
          'Rest & Recovery',
          'Full Body Strength',
        ];

        return {
          'workout': workouts[index % workouts.length],
          'duration': '${30 + (index % 4) * 5} min',
        };
      },
    ),

    'Improve Fitness': List.generate(
      30,
      (index) {
        final workouts = [
          'Morning Run',
          'Full Body Workout',
          'Cycling',
          'Rest & Stretch',
          'Cardio Training',
        ];

        return {
          'workout': workouts[index % workouts.length],
          'duration': '${30 + (index % 4) * 5} min',
        };
      },
    ),

    'Flexibility': List.generate(
      30,
      (index) {
        final workouts = [
          'Morning Yoga',
          'Full Body Stretch',
          'Pilates',
          'Relaxation Yoga',
          'Rest & Breathing',
        ];

        return {
          'workout': workouts[index % workouts.length],
          'duration': '${20 + (index % 4) * 5} min',
        };
      },
    ),

    'Stay Healthy': List.generate(
      30,
      (index) {
        final workouts = [
          'Morning Walk',
          'Full Body Workout',
          'Cycling',
          'Yoga & Stretching',
          'Rest & Stretch',
        ];

        return {
          'workout': workouts[index % workouts.length],
          'duration': '${25 + (index % 4) * 5} min',
        };
      },
    ),
  };

  // ==========================================================
  // DIET FOR EACH GOAL
  // ==========================================================

  final Map<String, List<Map<String, dynamic>>> goalMeals = {
    'Weight Loss': [
      {
        'meal': 'Breakfast',
        'food': 'Oats, Eggs & Fruits',
        'calories': '300 kcal',
        'icon': Icons.breakfast_dining,
      },
      {
        'meal': 'Lunch',
        'food': 'Grilled Chicken Salad',
        'calories': '400 kcal',
        'icon': Icons.lunch_dining,
      },
      {
        'meal': 'Snack',
        'food': 'Greek Yogurt & Fruits',
        'calories': '150 kcal',
        'icon': Icons.apple,
      },
      {
        'meal': 'Dinner',
        'food': 'Vegetable Soup & Salad',
        'calories': '350 kcal',
        'icon': Icons.dinner_dining,
      },
    ],

    'Muscle Gain': [
      {
        'meal': 'Breakfast',
        'food': 'Eggs, Oats & Banana',
        'calories': '500 kcal',
        'icon': Icons.breakfast_dining,
      },
      {
        'meal': 'Lunch',
        'food': 'Chicken, Rice & Vegetables',
        'calories': '650 kcal',
        'icon': Icons.lunch_dining,
      },
      {
        'meal': 'Snack',
        'food': 'Protein Shake & Nuts',
        'calories': '350 kcal',
        'icon': Icons.apple,
      },
      {
        'meal': 'Dinner',
        'food': 'Paneer, Rice & Vegetables',
        'calories': '600 kcal',
        'icon': Icons.dinner_dining,
      },
    ],

    'Improve Fitness': [
      {
        'meal': 'Breakfast',
        'food': 'Oatmeal, Banana & Eggs',
        'calories': '400 kcal',
        'icon': Icons.breakfast_dining,
      },
      {
        'meal': 'Lunch',
        'food': 'Grilled Chicken & Rice',
        'calories': '500 kcal',
        'icon': Icons.lunch_dining,
      },
      {
        'meal': 'Snack',
        'food': 'Yogurt & Mixed Fruits',
        'calories': '200 kcal',
        'icon': Icons.apple,
      },
      {
        'meal': 'Dinner',
        'food': 'Brown Rice & Vegetables',
        'calories': '450 kcal',
        'icon': Icons.dinner_dining,
      },
    ],

    'Flexibility': [
      {
        'meal': 'Breakfast',
        'food': 'Fruit Bowl & Oatmeal',
        'calories': '350 kcal',
        'icon': Icons.breakfast_dining,
      },
      {
        'meal': 'Lunch',
        'food': 'Vegetable Rice Bowl',
        'calories': '450 kcal',
        'icon': Icons.lunch_dining,
      },
      {
        'meal': 'Snack',
        'food': 'Yogurt & Fruits',
        'calories': '180 kcal',
        'icon': Icons.apple,
      },
      {
        'meal': 'Dinner',
        'food': 'Vegetable Soup & Rice',
        'calories': '400 kcal',
        'icon': Icons.dinner_dining,
      },
    ],

    'Stay Healthy': [
      {
        'meal': 'Breakfast',
        'food': 'Oatmeal & Banana',
        'calories': '320 kcal',
        'icon': Icons.breakfast_dining,
      },
      {
        'meal': 'Lunch',
        'food': 'Grilled Chicken Salad',
        'calories': '450 kcal',
        'icon': Icons.lunch_dining,
      },
      {
        'meal': 'Snack',
        'food': 'Greek Yogurt & Fruits',
        'calories': '180 kcal',
        'icon': Icons.apple,
      },
      {
        'meal': 'Dinner',
        'food': 'Brown Rice & Vegetables',
        'calories': '390 kcal',
        'icon': Icons.dinner_dining,
      },
    ],
  };

  // ==========================================================
  // GET CURRENT DATA
  // ==========================================================

  List<Map<String, dynamic>> get currentWorkouts {
    return goalWorkouts[selectedGoal]!;
  }

  List<Map<String, String>> get currentPlan {
    return goalPlans[selectedGoal]!;
  }

  List<Map<String, dynamic>> get currentMeals {
    return goalMeals[selectedGoal]!;
  }

  // ==========================================================
  // ACTIVITY
  // ==========================================================

  void addSteps() {
    setState(() {
      steps += 500;
      calories += 30;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('500 steps added! 👟'),
      ),
    );
  }

  void addWater() {
    if (water < 8) {
      setState(() {
        water++;
      });
    }

    if (water == 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Daily water goal completed! 💧'),
        ),
      );
    }
  }

  // ==========================================================
  // FITNESS GOAL
  // ==========================================================

  void showFitnessGoalDialog() {
    final goals = [
      {
        'name': 'Weight Loss',
        'icon': Icons.local_fire_department,
        'description': 'Burn calories and improve cardio',
      },
      {
        'name': 'Muscle Gain',
        'icon': Icons.fitness_center,
        'description': 'Build strength and muscle',
      },
      {
        'name': 'Improve Fitness',
        'icon': Icons.favorite,
        'description': 'Improve stamina and fitness',
      },
      {
        'name': 'Flexibility',
        'icon': Icons.self_improvement,
        'description': 'Improve flexibility and mobility',
      },
      {
        'name': 'Stay Healthy',
        'icon': Icons.health_and_safety,
        'description': 'Maintain a healthy lifestyle',
      },
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            5,
            20,
            30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose Your Fitness Goal',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Your workouts and 30-day plan will change automatically.',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 15),

              ...goals.map(
                (goal) {
                  bool selected =
                      selectedGoal == goal['name'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGoal = goal['name'] as String;
                        completedDays.clear();
                      });

                      Navigator.pop(sheetContext);

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(
                            '${goal['name']} selected! '
                            'Your workout plan has been updated.',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: selected
                            ? Colors.green.shade50
                            : Theme.of(context)
                                .colorScheme
                                .surface,
                        borderRadius:
                            BorderRadius.circular(16),
                        border: Border.all(
                          color: selected
                              ? Colors.green
                              : Colors.grey.shade300,
                          width: selected ? 2 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Colors.green.shade100,
                            child: Icon(
                              goal['icon'] as IconData,
                              color: Colors.green,
                            ),
                          ),

                          const SizedBox(width: 14),

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  goal['name'] as String,
                                  style: const TextStyle(
                                    fontWeight:
                                        FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  goal['description']
                                      as String,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          if (selected)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // WORKOUT TIMER
  // ==========================================================

  void startWorkout(
    Map<String, dynamic> workout,
  ) {
    workoutTimer?.cancel();

    setState(() {
      workoutSeconds = 0;
      timerRunning = true;
    });

    workoutTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }

        if (timerRunning) {
          setState(() {
            workoutSeconds++;
          });
        }
      },
    );

    showWorkoutTimer(workout);
  }

  void pauseWorkout() {
    setState(() {
      timerRunning = false;
    });
  }

  void resumeWorkout() {
    setState(() {
      timerRunning = true;
    });
  }

  void finishWorkout() {
    workoutTimer?.cancel();

    int minutes = (workoutSeconds / 60).ceil();
    int earnedCalories = minutes * 7;

    setState(() {
      calories += earnedCalories;
      steps += minutes * 80;
      timerRunning = false;
      workoutSeconds = 0;
    });

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Workout completed! +$earnedCalories kcal 🔥',
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remaining = seconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remaining.toString().padLeft(2, '0')}';
  }

  void showWorkoutTimer(
    Map<String, dynamic> workout,
  ) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return StreamBuilder<int>(
              stream: Stream.periodic(
                const Duration(milliseconds: 500),
                (value) => value,
              ),
              builder: (context, snapshot) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    25,
                    25,
                    25,
                    35,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 5,
                        width: 45,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        'Workout in Progress',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        workout['name'],
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Container(
                        height: 190,
                        width: 190,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.shade50,
                          border: Border.all(
                            color: Colors.green,
                            width: 8,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            formatTime(workoutSeconds),
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      Text(
                        timerRunning
                            ? 'Workout running...'
                            : 'Workout paused',
                        style: TextStyle(
                          color: timerRunning
                              ? Colors.green
                              : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                if (timerRunning) {
                                  pauseWorkout();
                                } else {
                                  resumeWorkout();
                                }

                                setSheetState(() {});
                              },
                              icon: Icon(
                                timerRunning
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              label: Text(
                                timerRunning
                                    ? 'Pause'
                                    : 'Resume',
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: finishWorkout,
                              icon: const Icon(
                                Icons.check,
                              ),
                              label: const Text('Finish'),
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.green,
                                foregroundColor:
                                    Colors.white,
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // 30 DAY PLAN
  // ==========================================================

  void toggleDay(int day) {
    setState(() {
      if (completedDays.contains(day)) {
        completedDays.remove(day);
      } else {
        completedDays.add(day);
        calories += 50;
      }
    });
  }

  void show30DayPlan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            double progress =
                completedDays.length / 30;

            return SizedBox(
              height:
                  MediaQuery.of(context).size.height *
                      0.88,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      0,
                      20,
                      10,
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Colors.green,
                              size: 30,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                '30-Day Fitness Plan',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        Text(
                          selectedGoal,
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        LinearProgressIndicator(
                          value: progress,
                          minHeight: 10,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '${completedDays.length} of 30 days completed',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  Expanded(
                    child: ListView.builder(
                      padding:
                          const EdgeInsets.all(15),
                      itemCount: currentPlan.length,
                      itemBuilder:
                          (context, index) {
                        int day = index + 1;

                        final plan =
                            currentPlan[index];

                        bool completed =
                            completedDays
                                .contains(day);

                        return Container(
                          margin:
                              const EdgeInsets.only(
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                            color: completed
                                ? Colors.green.shade50
                                : Theme.of(context)
                                    .colorScheme
                                    .surface,
                            borderRadius:
                                BorderRadius.circular(16),
                            border: Border.all(
                              color: completed
                                  ? Colors.green.shade200
                                  : Colors.grey
                                      .shade300,
                            ),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  completed
                                      ? Colors.green
                                      : Colors.green
                                          .shade100,
                              child: completed
                                  ? const Icon(
                                      Icons.check,
                                      color:
                                          Colors.white,
                                    )
                                  : Text(
                                      '$day',
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.green,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                            ),
                            title: Text(
                              'Day $day • ${plan['workout']}',
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                            subtitle:
                                Text(plan['duration']!),
                            trailing: Checkbox(
                              value: completed,
                              activeColor:
                                  Colors.green,
                              onChanged: (_) {
                                toggleDay(day);
                                setSheetState(() {});
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // DASHBOARD
  // ==========================================================

  Widget buildDashboard() {
    double progress = steps / 10000;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          Text(
            'Good Morning, $userName! 👋',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Ready to get fit?',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // GOAL CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.flag,
                  color: Colors.white,
                  size: 40,
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Goal',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        selectedGoal,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${completedDays.length}/30 days completed',
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  onPressed:
                      showFitnessGoalDialog,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // STEP CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surface,
              borderRadius:
                  BorderRadius.circular(22),
            ),
            child: Row(
              children: [
                SizedBox(
                  height: 110,
                  width: 110,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: progress > 1
                            ? 1
                            : progress,
                        strokeWidth: 10,
                        backgroundColor:
                            Colors.green.shade100,
                        valueColor:
                            const AlwaysStoppedAnimation<
                                Color>(
                          Colors.green,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daily Activity',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        '$steps / 10,000 steps',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 12),

                      ElevatedButton(
                        onPressed: addSteps,
                        child:
                            const Text('Add 500 Steps'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              progressBox(
                '🔥',
                '$streak',
                'Day Streak',
              ),
              const SizedBox(width: 12),
              progressBox(
                '🏃',
                '$calories',
                'Calories',
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              progressBox(
                '👟',
                '$steps',
                'Steps',
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: addWater,
                child: progressBox(
                  '💧',
                  '$water',
                  'Glasses',
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Workout",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: const Text('View All'),
              ),
            ],
          ),

          const SizedBox(height: 10),

          workoutCard(currentWorkouts[0]),

          const SizedBox(height: 25),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Today's Diet",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 3;
                  });
                },
                child: const Text('View All'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          mealCard(currentMeals[0]),
        ],
      ),
    );
  }

  // ==========================================================
  // WORKOUT PAGE
  // ==========================================================

  Widget buildWorkouts() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          const Text(
            'My Workouts',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Workouts designed for your $selectedGoal goal',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.flag,
                  color: Colors.green,
                  size: 35,
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Goal',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        selectedGoal,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'Recommended Workouts',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          ...currentWorkouts.map(
            (workout) => Padding(
              padding:
                  const EdgeInsets.only(bottom: 12),
              child: workoutCard(workout),
            ),
          ),

          const SizedBox(height: 15),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: show30DayPlan,
              icon: const Icon(
                Icons.calendar_month,
              ),
              label: const Text(
                'View 30-Day Fitness Plan',
                style: TextStyle(fontSize: 16),
              ),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DIET
  // ==========================================================

  Widget buildDiet() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          const Text(
            'Daily Diet',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Nutrition suggestions for $selectedGoal',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius:
                  BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.restaurant,
                  size: 45,
                  color: Colors.orange,
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daily Nutrition',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Meals supporting your $selectedGoal goal',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          ...currentMeals.map(
            (meal) => Padding(
              padding:
                  const EdgeInsets.only(bottom: 12),
              child: mealCard(meal),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROGRESS
  // ==========================================================

  Widget buildProgress() {
    double progress = steps / 10000;
    double planProgress =
        completedDays.length / 30;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          const Text(
            'My Progress',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            'Tracking progress towards $selectedGoal',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surface,
              borderRadius:
                  BorderRadius.circular(22),
            ),
            child: Column(
              children: [
                const Text(
                  'Daily Step Goal',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                LinearProgressIndicator(
                  value: progress > 1
                      ? 1
                      : progress,
                  minHeight: 12,
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                const SizedBox(height: 12),

                Text(
                  '$steps / 10,000 steps',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .surface,
              borderRadius:
                  BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  '30-Day Plan Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                LinearProgressIndicator(
                  value: planProgress,
                  minHeight: 12,
                  borderRadius:
                      BorderRadius.circular(20),
                  color: Colors.green,
                ),

                const SizedBox(height: 10),

                Text(
                  '${completedDays.length} / 30 days completed',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              progressBox(
                '🔥',
                '$streak',
                'Day Streak',
              ),
              const SizedBox(width: 12),
              progressBox(
                '🏃',
                '$calories',
                'Calories',
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              progressBox(
                '👟',
                '$steps',
                'Steps',
              ),
              const SizedBox(width: 12),
              progressBox(
                '💧',
                '$water',
                'Glasses',
              ),
            ],
          ),

          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: show30DayPlan,
              icon: const Icon(
                Icons.calendar_month,
              ),
              label: const Text(
                'Open 30-Day Plan',
              ),
              style:
                  ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE
  // ==========================================================

  Widget buildProfile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          const SizedBox(height: 20),

          const CircleAvatar(
            radius: 55,
            backgroundColor: Colors.green,
            child: Icon(
              Icons.person,
              size: 65,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            userName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Text(
            'Keep working towards your goals!',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          profileTile(
            Icons.edit,
            'Edit Profile',
            'Change your personal details',
            showEditProfile,
          ),

          profileTile(
            Icons.flag,
            'Fitness Goal',
            selectedGoal,
            showFitnessGoalDialog,
          ),

          profileTile(
            Icons.height,
            'Height',
            height,
            showHeightDialog,
          ),

          profileTile(
            Icons.monitor_weight,
            'Weight',
            weight,
            showWeightDialog,
          ),

          profileTile(
            Icons.local_fire_department,
            'Current Streak',
            '$streak Days',
            showStreakDialog,
          ),

          profileTile(
            Icons.calendar_month,
            '30-Day Plan',
            '${completedDays.length}/30 days completed',
            show30DayPlan,
          ),

          profileTile(
            Icons.settings,
            'Settings',
            'Dark mode, notifications & reminders',
            showSettingsDialog,
          ),

          profileTile(
            Icons.info_outline,
            'About FitTrack',
            'App information',
            showAboutDialog,
          ),

          profileTile(
            Icons.logout,
            'Logout',
            'Sign out of FitTrack',
            logout,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // EDIT PROFILE
  // ==========================================================

  void showEditProfile() {
    final controller =
        TextEditingController(text: userName);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (controller.text
                    .trim()
                    .isNotEmpty) {
                  setState(() {
                    userName =
                        controller.text.trim();
                  });
                }

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // HEIGHT
  // ==========================================================

  void showHeightDialog() {
    final controller =
        TextEditingController(text: height);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Height'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Height',
              hintText: 'Example: 170 cm',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  height = controller.text;
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // WEIGHT
  // ==========================================================

  void showWeightDialog() {
    final controller =
        TextEditingController(text: weight);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Update Weight'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Weight',
              hintText: 'Example: 65 kg',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  weight = controller.text;
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // STREAK
  // ==========================================================

  void showStreakDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            '🔥 Current Streak',
          ),
          content: Text(
            'You currently have a $streak day streak!\n\n'
            'Complete your planned workouts regularly '
            'to keep building your streak.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Great!'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // SETTINGS - DARK MODE
  // ==========================================================

  void showSettingsDialog() {
    bool darkMode = widget.isDarkMode;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 10),
                  Text('Settings'),
                ],
              ),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // DARK MODE
                  SwitchListTile(
                    contentPadding:
                        EdgeInsets.zero,
                    title: const Text(
                      'Dark Mode',
                    ),
                    subtitle: const Text(
                      'Switch between light and dark theme',
                    ),
                    secondary: Icon(
                      darkMode
                          ? Icons.dark_mode
                          : Icons.light_mode,
                    ),
                    value: darkMode,
                    onChanged: (value) {
                      setDialogState(() {
                        darkMode = value;
                      });

                      widget.onThemeChanged(value);
                    },
                  ),

                  const Divider(),

                  // NOTIFICATIONS
                  SwitchListTile(
                    contentPadding:
                        EdgeInsets.zero,
                    title: const Text(
                      'Notifications',
                    ),
                    subtitle: const Text(
                      'Receive workout notifications',
                    ),
                    secondary: const Icon(
                      Icons.notifications_outlined,
                    ),
                    value: notifications,
                    onChanged: (value) {
                      setDialogState(() {
                        notifications = value;
                      });

                      setState(() {});
                    },
                  ),

                  // REMINDERS
                  SwitchListTile(
                    contentPadding:
                        EdgeInsets.zero,
                    title: const Text(
                      'Daily Reminder',
                    ),
                    subtitle: const Text(
                      'Remind me to complete workout',
                    ),
                    secondary: const Icon(
                      Icons.alarm,
                    ),
                    value: reminders,
                    onChanged: (value) {
                      setDialogState(() {
                        reminders = value;
                      });

                      setState(() {});
                    },
                  ),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // ABOUT
  // ==========================================================

  void showAboutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('FitTrack'),
          content: const Text(
            'FitTrack is a fitness tracking application '
            'that helps users choose a fitness goal, '
            'follow personalized workouts, track daily '
            'activity, maintain a streak and follow a '
            '30-day fitness plan.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // LOGOUT
  // ==========================================================

  void logout() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage(
                        onThemeChanged:
                            widget.onThemeChanged,
                        isDarkMode:
                            widget.isDarkMode,
                      );
                    },
                  ),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // REUSABLE UI
  // ==========================================================

  Widget progressBox(
    String emoji,
    String value,
    String label,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surface,
          borderRadius:
              BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 27,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              value,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget workoutCard(
    Map<String, dynamic> workout,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius:
                  BorderRadius.circular(15),
            ),
            child: Icon(
              workout['icon'],
              color: Colors.green,
              size: 30,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  workout['name'],
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  '${workout['duration']} • '
                  '${workout['calories']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 5),

          ElevatedButton(
            onPressed: () =>
                startWorkout(workout),
            child: const Text('Start'),
          ),
        ],
      ),
    );
  }

  Widget mealCard(
    Map<String, dynamic> meal,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius:
                  BorderRadius.circular(15),
            ),
            child: Icon(
              meal['icon'],
              color: Colors.orange,
              size: 28,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  meal['meal'],
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  meal['food'],
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          Text(
            meal['calories'],
            style: const TextStyle(
              color: Colors.orange,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget profileTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          backgroundColor:
              Colors.green.shade50,
          child: Icon(
            icon,
            color: Colors.green,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    workoutTimer?.cancel();
    super.dispose();
  }

  // ==========================================================
  // MAIN BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildDashboard(),
      buildWorkouts(),
      buildProgress(),
      buildDiet(),
      buildProfile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FitTrack',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: pages[selectedIndex],

      bottomNavigationBar:
          NavigationBar(
        selectedIndex: selectedIndex,

        onDestinationSelected:
            (index) {
          setState(() {
            selectedIndex = index;
          });
        },

        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
            ),
            selectedIcon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.fitness_center_outlined,
            ),
            selectedIcon: Icon(
              Icons.fitness_center,
            ),
            label: 'Workout',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.bar_chart_outlined,
            ),
            selectedIcon: Icon(
              Icons.bar_chart,
            ),
            label: 'Progress',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.restaurant_outlined,
            ),
            selectedIcon: Icon(
              Icons.restaurant,
            ),
            label: 'Diet',
          ),

          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
            ),
            selectedIcon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}