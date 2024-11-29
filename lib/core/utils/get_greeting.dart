String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return 'Good Morning!';
    } else if (hour >= 12 && hour < 18) {
      return 'Hello!';
    } else if (hour >= 18 && hour < 22) {
      return 'Good Evening!';
    } else {
      return 'Good Night!';
    }
  }