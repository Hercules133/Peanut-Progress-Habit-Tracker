import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:streaks/data/models/colorscheme.dart';

Color orangelike = const Color.fromRGBO(228, 102, 33, 1.0); // #E46621
Color peanutlike = const Color.fromRGBO(216, 154, 88, 1.0); // #D89A58
Color skinlike = const Color.fromRGBO(237, 164, 127, 1.0); // #EDA47F
Color brownlike = const Color.fromRGBO(123, 45, 5, 1.0); // #7B2D05
Color whitelike = const Color.fromRGBO(252, 241, 204, 1.0); // #FCF1CC
Color saddlebrown = const Color.fromRGBO(81, 45, 17, 1.0);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Peanut Progress',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Meditation',
      'description': 'Meditiere jeden Tag 10 Minuten.',
      'category': 'Sport',
      'completed': false,
    },
    {
      'title': 'Lese ein Fachbuch',
      'description': 'Lese 10 Seiten aus Fachbüchern.',
      'category': 'Studium',
      'completed': false,
    },
    {
      'title': 'Pumpen',
      'description': 'Gehe jeden Tag für mind. 1 Stunden ins Fitnessstudio.',
      'category': 'Fitness',
      'completed': false,
    },
  ];
  String _sortBy = 'Alle';

  @override
  void initState() {
    super.initState();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return "Guten Morgen";
    } else if (hour >= 12 && hour < 18) {
      return "Guten Tag";
    } else if (hour >= 18 && hour < 24) {
      return "Guten Abend";
    } else {
      return "Gute Nacht";
    }
  }

  void _showHabits() {}

  void _filterOption() {
    setState(() {
      // Placeholder logic for filtering tasks based on the selected category
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        title: Text(
          '${_getGreeting()} Muhammed',
          style: const TextStyle(
            color: Colors.white, // Title color
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        backgroundColor: saddlebrown, // Background color
        toolbarHeight: 60.0, // Height of the app bar
        centerTitle: true, // This centers the title
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/LogoPeanutProgress.png', // Path to the project logo
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: saddlebrown,
              ),
              child: const Text(
                'Peanut Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            new ListTile(
              title: const Text('Homepage'),
              onTap: () {
                // Soll zur Homepage navigieren;
              },
            ),
            new ListTile(
              title: const Text('Habits'),
              onTap: () {
                // Soll zur Habitsübersicht navigieren;
              },
            ),
            new ListTile(
              title: const Text('Statistiken'),
              onTap: () {
                // Soll zu Statistiken navigieren;
              },
            ),
            new ListTile(
              title: const Text('Einstellungen'),
              onTap: () {
                // Soll zu Einstellungen navigieren;
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: saddlebrown, // Body background color
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildSortOption('Alle'),
                          _buildSortOption('Studium'),
                          _buildSortOption('Arbeit'),
                          _buildSortOption('Sport'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        // eine category variable soll irgendwo gesetzt werden
                      });
                      _filterOption();
                    },
                    tooltip: 'Search for habits!',
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: peanutlike,
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    child: ListTile(
                      title: Text(
                        _tasks[index]['title'],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _tasks[index]['description'],
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          _tasks[index]['completed'] ? Icons.check_circle : Icons.circle_outlined,
                          color: _tasks[index]['completed'] ? Colors.green : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _tasks[index]['completed'] = !_tasks[index]['completed'];
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortOption(String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        selected: _sortBy == label,
        onSelected: (bool selected) {
          setState(() {
            _sortBy = label;
          });
          _showHabits();
        },
        backgroundColor: peanutlike,
        selectedColor: peanutlike,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
