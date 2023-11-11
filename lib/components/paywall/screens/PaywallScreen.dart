import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/paywall/bloc/PaywallBloc.dart';
import 'package:procastiless/components/paywall/bloc/PaywallEvents.dart';
import 'package:procastiless/components/paywall/bloc/PaywallState.dart';
import 'package:procastiless/components/paywall/models/Offer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PaywallScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PaywallScreenState();
}

class PaywallScreenState extends State<PaywallScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<PaywallBloc>().add(new GetPaywallOfferEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final title = "Procrastiless ";
    final postTitle = "Super+";
    final description =
        "Make your Procrastiless experience even better with different fun features that will speed up your goals to the roofs";

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Positioned(
                child: Center(
                  child: Container(
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 220,
                top: 20,
                child: Container(
                  child: Text(
                    postTitle,
                    style: TextStyle(fontSize: 24, color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              SizedBox(height: 60),
              Expanded(
                child: BlocBuilder<PaywallBloc, PaywallState>(
                  builder: (context, state) {
                    if (state is PaywallOfferLoaded) {
                      return Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: state.offers.length,
                              itemBuilder: (context, index) {
                                return buildOfferPage(state.offers[index]);
                              },
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: _pageController, // PageController
                            count: state.offers.length, // Number of pages
                            effect: JumpingDotEffect(
                              dotColor: Color.fromARGB(255, 182, 205, 227),
                              activeDotColor: Color.fromARGB(255, 25, 130, 227),
                              spacing: 5,
                              dotHeight: 10,
                              dotWidth: 10,
                            ), // Your preferred effect
                          ),
                        ],
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              // Optional: Add page indicators here
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOfferPage(Offer offer) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.all(5.5),
              child: Container(
                child: Text("${offer.name}"),
              ),
            ),
          ),
          for (var content in offer.bulletInfo)
            Padding(
              padding: EdgeInsets.all(5.5),
              child: Container(
                child: Text("• $content"),
              ),
            ),
          FilledButton(
            onPressed: () => {}, // Implement your logic
            child:
                Text(" \$${offer.price / 100}"), // Format price directly here
          ),
        ],
      ),
    );
  }
}
