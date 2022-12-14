import 'package:flutter/material.dart';
import 'package:nike_snkrs_clone/features/form-validation/sign_up_view.dart';

class WelcomeView extends StatefulWidget {
  WelcomeView({super.key});

  final List<Widget> viewItems = [
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/snkrs-logo-red.png",
          height: 125,
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Welcome to Nike SNKRS. Your ultimate sneaker destination.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/welcome-page-slot-1.png",
          height: 200,
        ),
        const SizedBox(height: 20),
        const Text(
          "Purchase Quickly",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Buy sneakers in seconds, directly within the app. Store all your info to expedite the process.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/welcome-page-slot-2.png",
          height: 180,
        ),
        const SizedBox(height: 20),
        const Text(
          "Stay a Step Ahead",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Set notifications for upcoming releases. Share news, photos and videos with friends.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/welcome-page-slot-3.png",
          height: 200,
        ),
        const SizedBox(height: 20),
        const Text(
          "Get The Story",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Learn about the inspiration, benefits and heritage of featured sneakers straight from the source.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/welcome-page-slot-4.png",
          height: 180,
        ),
        const SizedBox(height: 20),
        const Text(
          "Enter The Draw",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            "Easily submit your entry into a randomised selection system to purchase key releases.",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  ];

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  int _currentPageView = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Flexible(
              child: PageView(
                controller: _controller,
                onPageChanged: (value) {
                  setState(() {
                    _currentPageView = value;
                  });
                },
                children: widget.viewItems,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.viewItems.length; i++)
                      Container(
                        height: 8,
                        width: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 3.5),
                        decoration: BoxDecoration(
                          color: (i == _currentPageView)
                              ? Colors.black
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith(
                          (states) => 0,
                        ),
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white,
                        ),
                        foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(double.infinity, 60),
                        ),
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * 0.03),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          builder: (context) => DraggableScrollableSheet(
                            expand: false,
                            initialChildSize: 0.92,
                            maxChildSize: 0.92,
                            minChildSize: 0.5,
                            builder: (context, scrollController) =>
                                SingleChildScrollView(
                              controller: scrollController,
                              child: const SignUpView(),
                            ),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith(
                          (states) => 0,
                        ),
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black,
                        ),
                        foregroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                        ),
                        minimumSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(double.infinity, 60),
                        ),
                      ),
                      child: Text("Join Now"),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
