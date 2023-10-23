import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/dashboard/screen/dashboardscreen.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';

class AvatarSelector extends StatefulWidget {
  AvatarSelector();
  @override
  State<StatefulWidget> createState() => AvatarSelectorState();
}

class AvatarSelectorState extends State<AvatarSelector>
    with SingleTickerProviderStateMixin {
  int? selectedAvatar;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  AnimationController? animation;
  late Animation sizeAnimation;
  CarouselController? carouselController;

  @override
  void initState() {
    super.initState();
    // Rebuilding the screen when animation goes ahead
    //For single time
    //controller.forward()
    animation = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1800));
    sizeAnimation = Tween<double>(begin: 10, end: 20).animate(animation!);
    animation?.repeat();
    carouselController = CarouselController();
    animation?.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {},
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: Color(0xff243C51),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Time to pick your Procraimon',
                    style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Colors.white,
                        fontSizeFactor: 2.8,
                        fontWeightDelta: 50),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'This action is irrivertable. Once you pick your avatar you can not change it',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.apply(color: Colors.white, fontSizeFactor: 1.0),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    Positioned(
                      top: 60,
                      left: MediaQuery.of(context).size.width * .06 +
                          (-sizeAnimation.value),
                      child: GestureDetector(
                          onTap: () {
                            print("Hello");
                            carouselController
                                ?.animateToPage(selectedAvatar! + 1);
                          },
                          child: Icon(Icons.keyboard_arrow_left_rounded,
                              size: 60)),
                    ),
                    Positioned(
                      top: 60,
                      right: MediaQuery.of(context).size.width * .06 +
                          -sizeAnimation.value,
                      child: Icon(Icons.keyboard_arrow_right_rounded, size: 60),
                    ),
                    CarouselSlider(
                      carouselController: carouselController,
                      items: [
                        Image.asset('assets/images/char2.png'),
                        Image.asset(
                          'assets/images/char1.png',
                          height: 100,
                        ),
                        Image.asset('assets/images/char3.png'),
                      ],
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            selectedAvatar = index;
                          },
                          enableInfiniteScroll: false,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          initialPage: 1,
                          disableCenter: false),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                  return GestureDetector(
                    onTap: () async {
                      if (state is LoggedIn) {
                        if (selectedAvatar == 0) {
                          state.accountUser?.avatarUrl =
                              'https://firebasestorage.googleapis.com/v0/b/procastiless.appspot.com/o/Group.png?alt=media&token=d835bde2-e773-4307-8b7b-886d601ba123&_gl=1*ecdhs9*_ga*OTc3MjI4NzQxLjE2OTYzMDUyNDU.*_ga_CW55HF8NVT*MTY5Njk3ODk4Mi42LjEuMTY5Njk3OTYxNi41NC4wLjA.';
                        } else if (selectedAvatar == 1) {
                          state.accountUser?.avatarUrl =
                              'https://firebasestorage.googleapis.com/v0/b/procastiless.appspot.com/o/g10.png?alt=media&token=9ae4dc36-2eb2-4fb6-bb1b-8b876d30894a&_gl=1*1xuh4zl*_ga*OTc3MjI4NzQxLjE2OTYzMDUyNDU.*_ga_CW55HF8NVT*MTY5Njk3ODk4Mi42LjEuMTY5Njk3OTY0NS4yNS4wLjA.';
                        } else {
                          state.accountUser?.avatarUrl =
                              'https://firebasestorage.googleapis.com/v0/b/procastiless.appspot.com/o/icon-vezt-character-map_4.png?alt=media&token=52d2bb03-f2dd-4ada-b0e0-aeffe93172d1&_gl=1*1gcc0in*_ga*OTc3MjI4NzQxLjE2OTYzMDUyNDU.*_ga_CW55HF8NVT*MTY5Njk3ODk4Mi42LjEuMTY5Njk3OTY2MC4xMC4wLjA.';
                        }
                      }
                      if ((state as LoggedIn).auth.currentUser?.uid != null) {
                        await firestore
                            .collection('users')
                            .doc(state.auth.currentUser!.uid)
                            .update({
                          'avatarUrl': state.accountUser?.avatarUrl,
                        });
                      }
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dashboard()));
                    },
                    child: Image.asset('assets/images/next.png'),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
