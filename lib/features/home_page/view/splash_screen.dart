import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/core/utils/routes.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MySplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
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
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();
    _showSplashScreen();
  }

  Future<void> _showSplashScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;

    if (prefs.getString('lastOpenedDate') != today) {
      prefs.setString('lastOpenedDate', today);
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pushReplacementNamed(context, Routes.home);
      });
    } else {
      Navigator.pushReplacementNamed(context, Routes.home);
    }
  }

  String getRandomQuote() {
    return _quotes[(DateTime.now().millisecondsSinceEpoch % _quotes.length)];
  }

  @override
  void dispose() {
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