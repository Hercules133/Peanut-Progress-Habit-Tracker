import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyWalkthroughPage extends StatefulWidget {
  const MyWalkthroughPage({super.key});

  static const List<String> walkthroughImagesDE = [
    'assets/images/Bild1_DE.jpg',
    'assets/images/Bild2_DE.jpg',
    'assets/images/Bild3_DE.jpg',
    'assets/images/Bild4_DE.jpg',
    'assets/images/Bild5_DE.jpg',
    'assets/images/Bild6_DE.jpg',
    'assets/images/Bild7_DE.jpg',
    'assets/images/Bild8_DE.jpg',
    'assets/images/Bild9_DE.jpg',
    'assets/images/Bild10_DE.jpg',
    'assets/images/Bild11_DE.jpg',
    'assets/images/Bild12_DE.jpg',
    'assets/images/Bild13_DE.jpg',
    'assets/images/Bild14_DE.jpg',
    'assets/images/Bild15_DE.jpg',
    'assets/images/Bild16_DE.jpg',
    'assets/images/Bild17_DE.jpg',
    'assets/images/Bild18_DE.jpg',
    'assets/images/Bild19_DE.jpg',
    'assets/images/Bild20_DE.jpg',
    'assets/images/Bild21_DE.jpg',
  ];

  static const List<String> walkthroughImagesEN = [
    'assets/images/Bild1_EN.jpg',
    'assets/images/Bild2_EN.jpg',
    'assets/images/Bild3_EN.jpg',
    'assets/images/Bild4_EN.jpg',
    'assets/images/Bild5_EN.jpg',
    'assets/images/Bild6_EN.jpg',
    'assets/images/Bild7_EN.jpg',
    'assets/images/Bild8_EN.jpg',
    'assets/images/Bild9_EN.jpg',
    'assets/images/Bild10_EN.jpg',
    'assets/images/Bild11_EN.jpg',
    'assets/images/Bild12_EN.jpg',
    'assets/images/Bild13_EN.jpg',
    'assets/images/Bild14_EN.jpg',
    'assets/images/Bild15_EN.jpg',
    'assets/images/Bild16_EN.jpg',
    'assets/images/Bild17_EN.jpg',
    'assets/images/Bild18_EN.jpg',
    'assets/images/Bild19_EN.jpg',
    'assets/images/Bild20_EN.jpg',
    'assets/images/Bild21_EN.jpg',
  ];

  @override
  State<MyWalkthroughPage> createState() => _MyWalkthroughPageState();
}

class _MyWalkthroughPageState extends State<MyWalkthroughPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Überprüfen der aktuellen Spracheinstellung
    final isGerman = Localizations.localeOf(context).languageCode == 'de';

    // Wähle den passenden Satz von Bildern aus
    final walkthroughImages = isGerman
        ? MyWalkthroughPage.walkthroughImagesDE
        : MyWalkthroughPage.walkthroughImagesEN;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('App Walkthrough'),
        centerTitle: true,
      ),
      body: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          if (event is KeyDownEvent) {
            if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
              _navigateNextPage(walkthroughImages);
            } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _navigatePreviousPage();
            }
          }
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: walkthroughImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(walkthroughImages[index]),
                );
              },
            ),
            _buildDotsIndicator(walkthroughImages.length),
            if (!_isTouchDevice())
              _buildDesktopNavigationButtons(walkthroughImages),
          ],
        ),
      ),
    );
  }

  bool _isTouchDevice() {
    return MediaQuery.of(context).size.shortestSide < 600;
  }

  Widget _buildDotsIndicator(int imageCount) {
    return Positioned(
      bottom: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          imageCount,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: _currentPage == index ? 12.0 : 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: _currentPage == index ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNavigationButtons(List<String> walkthroughImages) {
    return Positioned(
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _navigatePreviousPage,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => _navigateNextPage(walkthroughImages),
          ),
        ],
      ),
    );
  }

  void _navigateNextPage(List<String> walkthroughImages) {
    if (_currentPage < walkthroughImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigatePreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
