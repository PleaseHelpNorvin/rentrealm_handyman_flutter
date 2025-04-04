import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'auth/login.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome!"),
      ),
      body: Padding(padding: EdgeInsets.all(10), child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                Padding( padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/rentrealm_logo_cropped.png', // Make sure this path is correct and the asset is declared in pubspec.yaml.
                        width: 300,
                        height: 200,
                      ),
                      Center(
                        child: Text(
                          'Rent Realm : Handy Man!',
                          style: TextStyle(
                            fontSize: 28,  // Slightly larger font size
                            fontWeight: FontWeight.bold,
                            color: Colors.black,  // Set text color
                            height: 1.5,  // Add line spacing for better readability
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                // Second page with the text screen.
               Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,  // Center content vertically
                    children: [
                      Center(
                        child: Text(
                          'Welcome to our App!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 40), // Add space between title and instruction
                      Center(
                        child: Text(
                          'To become a freelance handyman to Rent Realm, please reach out to the landlord or admin to apply.',
                          style: TextStyle(
                            fontSize: 18,  // Slightly smaller for instruction text
                            color: Colors.blueGrey,  // Lighter color for instructions
                            height: 1.5,  // Add line spacing for better readability
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                // Third page with the button

              ],
            ),
          ),
          // Page indicator (dots)
          SmoothPageIndicator(
            controller: _pageController,
            count: 2, // Number of pages in the PageView
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              spacing: 16,
              dotColor: Colors.grey,
              activeDotColor: Colors.blue,
            ),
          ),

          SizedBox(height: 10),
        Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add smooth transition to LoginScreen
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => LoginScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); // Start from right side
                        const end = Offset.zero; // End at the center
                        const curve = Curves.easeInOut; // Smooth curve

                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(position: offsetAnimation, child: child); // Slide in transition
                      },
                    ));
                  },
                  child: Text('Login'),
                ),
              ),
            ),

        ],

      ),),
    );
  }
}
