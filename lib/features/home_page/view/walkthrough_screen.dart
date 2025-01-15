import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A walkthrough page that displays a series of images to introduce users to the app.
///
/// The walkthrough adapts to the language settings of the device and shows either
/// German or English images accordingly.
class MyWalkthroughPage extends StatefulWidget {
  /// Constructor for the walkthrough page.
  const MyWalkthroughPage({super.key});

  /// List of walkthrough images in German.
  static const List<String> walkthroughImages_DE = [
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

  /// List of walkthrough images in English.
  static const List<String> walkthroughImages_EN = [
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

/// The state class for [MyWalkthroughPage].
///
/// Manages the page navigation and controls which images are displayed based
/// on the language settings of the device.
class _MyWalkthroughPageState extends State<MyWalkthroughPage> {
  /// Controls the page view for navigating through the walkthrough images.
  final PageController _pageController = PageController();

  /// Tracks the current page index in the walkthrough.
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Check the current locale of the device to determine the language.
    final isGerman = Localizations.localeOf(context).languageCode == 'de';

    // Select the appropriate set of walkthrough images based on the language.
    final walkthroughImages = isGerman
        ? MyWalkthroughPage.walkthroughImages_DE
        : MyWalkthroughPage.walkthroughImages_EN;

    return Scaffold(
      appBar: AppBar(
        /// A close button to exit the walkthrough.
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('App Walkthrough'),
        centerTitle: true,
      ),
      /// The main body of the walkthrough, which includes the image slider and navigation buttons.
      body: KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (event) {
          // Handle arrow key navigation for desktop users.
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
            // The page view displaying the walkthrough images.
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
            // Dots indicator showing the current position in the walkthrough.
            _buildDotsIndicator(walkthroughImages.length),
            // Navigation buttons for desktop users.
            if (!_isTouchDevice()) _buildDesktopNavigationButtons(walkthroughImages),
          ],
        ),
      ),
    );
  }

  /// Checks if the device is a touch device based on screen size.
  ///
  /// Returns `true` if the device is considered a touch device.
  bool _isTouchDevice() {
    return MediaQuery.of(context).size.shortestSide < 600;
  }

  /// Builds a dots indicator to show the current position in the walkthrough.
  ///
  /// [imageCount] - The total number of images in the walkthrough.
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

  /// Builds navigation buttons for desktop users.
  ///
  /// [walkthroughImages] - The list of walkthrough images to navigate through.
  Widget _buildDesktopNavigationButtons(List<String> walkthroughImages) {
    return Positioned(
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Button to navigate to the previous page.
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _navigatePreviousPage,
          ),
          /// Button to navigate to the next page.
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () => _navigateNextPage(walkthroughImages),
          ),
        ],
      ),
    );
  }

  /// Navigates to the next page in the walkthrough.
  ///
  /// [walkthroughImages] - The list of walkthrough images to navigate through.
  void _navigateNextPage(List<String> walkthroughImages) {
    if (_currentPage < walkthroughImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Navigates to the previous page in the walkthrough.
  void _navigatePreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
