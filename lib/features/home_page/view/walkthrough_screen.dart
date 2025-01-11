import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyWalkthroughPage extends StatefulWidget {
  const MyWalkthroughPage({super.key});

  static const List<String> walkthroughImages = [
    'assets/images/Bild1.jpg',
    'assets/images/Bild2.jpg',
    'assets/images/Bild3.jpg',
    'assets/images/Bild4.jpg',
    'assets/images/Bild5.jpg',
    'assets/images/Bild6.jpg',
    'assets/images/Bild7.jpg',
    'assets/images/Bild8.jpg',
    'assets/images/Bild9.jpg',
    'assets/images/Bild10.jpg',
    'assets/images/Bild11.jpg',
    'assets/images/Bild12.jpg',
    'assets/images/Bild13.jpg',
    'assets/images/Bild14.jpg',
  ];

  @override
  State<MyWalkthroughPage> createState() => _MyWalkthroughPageState();
}

class _MyWalkthroughPageState extends State<MyWalkthroughPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
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
              _navigateNextPage();
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
              itemCount: MyWalkthroughPage.walkthroughImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child:
                      Image.asset(MyWalkthroughPage.walkthroughImages[index]),
                );
              },
            ),
            _buildDotsIndicator(),
            if (!_isTouchDevice()) _buildDesktopNavigationButtons(),
          ],
        ),
      ),
    );
  }

  bool _isTouchDevice() {
    return MediaQuery.of(context).size.shortestSide < 600;
  }

  Widget _buildDotsIndicator() {
    return Positioned(
      bottom: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          MyWalkthroughPage.walkthroughImages.length,
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

  Widget _buildDesktopNavigationButtons() {
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
            onPressed: _navigateNextPage,
          ),
        ],
      ),
    );
  }

  void _navigateNextPage() {
    if (_currentPage < MyWalkthroughPage.walkthroughImages.length - 1) {
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
