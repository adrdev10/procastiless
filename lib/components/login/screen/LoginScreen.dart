import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/dashboard/screen/dashboardscreen.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/widgets/avatarselection.dart';
import 'package:procastiless/widgets/toploginscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
            if (state is LoggedIn) {
              if (state.accountUser?.avatarUrl == "") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AvatarSelector();
                    },
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Dashboard();
                    },
                  ),
                );
              }
            }
          }, child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40),
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  LoginScreenTop(),
                  Positioned(
                    bottom: 100,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          elevation: MaterialStateProperty.all(0),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ))),
                      onPressed: () {
                        //Call auth with google signin
                        context
                            .read<LoginBloc>()
                            .add(new SignUpWithGoogleAuthEvent());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * .6,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            gradient: LinearGradient(
                              colors: [Color(0xff7E33B8), Color(0xffEE5A3A)],
                            )),
                        child: Text('''LET'\S GET STARTED'''),
                      ),
                    ),
                  ),
                  if (state is InProcessOfLogin) ...[
                    Center(child: CircularProgressIndicator())
                  ],
                  Positioned(
                    bottom: 50,
                    child: Row(
                      children: [
                        Text(
                          'don\'t want an account',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.apply(color: Colors.black),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.read<LoginBloc>().add(new SignInEvent());
                          },
                          child: Text('Proceed'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}
