import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:peanutprogress/core/utils/routes.dart';

/// A stateful widget that represents the splash screen of the app.
///
/// This screen is displayed once per day when the app is launched. It shows a motivational
/// quote and automatically navigates to the home screen after a delay.
class MySplashScreen extends StatefulWidget {
  /// Constructor for the MySplashScreen widget.
  const MySplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

/// The state class for the splash screen widget.
///
/// This class manages the animation and handles the logic to show the splash screen
/// only once per day.
class SplashScreenState extends State<MySplashScreen> with SingleTickerProviderStateMixin {
  /// Controller for the fade-in animation of the splash screen.
  late AnimationController _animationController;

  /// List of motivational quotes displayed on the splash screen.
  final List<String> _quotes = [
    "The secret of getting ahead is getting started. - Mark Twain",
    "Success is not final, failure is not fatal: It is the courage to continue that counts. - Winston Churchill",
    "The only way to do great work is to love what you do. - Steve Jobs",
    "Don’t watch the clock; do what it does. Keep going. - Sam Levenson",
    "Hardships often prepare ordinary people for an extraordinary destiny. - C.S. Lewis",
    "Success usually comes to those who are too busy to be looking for it. - Henry David Thoreau",
    "Don’t count the days, make the days count. - Muhammad Ali",
    "The best way to predict the future is to create it. - Peter Drucker",
    "Believe you can and you're halfway there. - Theodore Roosevelt",
    "Don’t wait. The time will never be just right. - Napoleon Hill",
    "You miss 100% of the shots you don’t take. - Wayne Gretzky",
    "Act as if what you do makes a difference. It does. - William James",
    "Quality is not an act, it is a habit. - Aristotle",
    "It always seems impossible until it's done. - Nelson Mandela",
    "The future depends on what you do today. - Mahatma Gandhi",
    "The harder you work for something, the greater you'll feel when you achieve it.",
    "Dream bigger. Do bigger.",
    "The only limit to our realization of tomorrow will be our doubts of today. - Franklin D. Roosevelt",
    "Your limitation—it’s only your imagination.",
    "Push yourself, because no one else is going to do it for you.",
    "Great things never come from comfort zones.",
    "Dream it. Wish it. Do it.",
    "Do something today that your future self will thank you for.",
    "Little things make big days.",
    "Success doesn’t just find you. You have to go out and get it.",
    "The harder you work, the luckier you get.",
    "Don’t stop when you’re tired. Stop when you’re done.",
    "Wake up with determination. Go to bed with satisfaction.",
    "Do what you can with all you have, wherever you are. - Theodore Roosevelt",
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for the fade-in effect.
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    // Show the splash screen only once per day.
    _showSplashScreen();
  }

  /// Shows the splash screen and navigates to the home screen based on the
  /// stored date in shared preferences.
  Future<void> _showSplashScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;

    /// Check if the splash screen was already shown today.
    if (prefs.getString('lastOpenedDate') != today) {
      prefs.setString('lastOpenedDate', today);
      Future.delayed(
        const Duration(seconds: 4),
            () {
          if (mounted) {
            Navigator.pushReplacementNamed(context, Routes.home);
          }
        },
      );
    } else {
      if (mounted) {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
    }
  }

  /// Returns a random quote from the list of quotes.
  String getRandomQuote() {
    return _quotes[(DateTime.now().millisecondsSinceEpoch % _quotes.length)];
  }

  @override
  void dispose() {
    // Dispose of the animation controller to free resources.
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: FadeTransition(
        opacity: _animationController,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display a random motivational quote in the center of the screen.
                Text(
                  getRandomQuote(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
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