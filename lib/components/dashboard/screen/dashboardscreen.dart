import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/screen/projectscreen.dart';
import 'package:procastiless/widgets/addprojectbutton.dart';

class Dashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int currentPageSelected = 0;
  @override
  Widget build(BuildContext context) {
    var tempWdiget = Container(
      child: ElevatedButton(
        child: Text('Sign out'),
        onPressed: () {
          context.read<LoginBloc>().add(new LogOutEvent());
          Navigator.popUntil(context, ModalRoute.withName('/login'));
        },
      ),
    );

    return Scaffold(
      floatingActionButton: AddProjectButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        iconSize: 28,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPageSelected,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            label: '',
            activeIcon: getShaderMask(Icons.dashboard),
            icon: Icon(Icons.dashboard, color: Colors.grey),
          ),
          BottomNavigationBarItem(
              activeIcon: getShaderMask(Icons.calendar_today_sharp),
              label: '',
              icon: Icon(
                Icons.calendar_today_sharp,
                color: Colors.grey,
              )),
          BottomNavigationBarItem(
              activeIcon: getShaderMask(
                Icons.account_box_rounded,
              ),
              label: '',
              icon: Icon(
                Icons.account_box_rounded,
                color: Colors.grey,
              )),
          BottomNavigationBarItem(
              activeIcon: getShaderMask(Icons.insights),
              label: '',
              icon: Icon(
                Icons.insights,
                color: Colors.grey,
              )),
        ],
        onTap: (index) {
          setState(() {
            currentPageSelected = index;
          });
        },
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Stack(
            alignment: Alignment.center,
            children: [
              if (currentPageSelected == 0) ProjectScreen(),
              tempWdiget
            ],
          );
        },
      ),
    );
  }

  getShaderMask(IconData icon) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(colors: <Color>[
          Color(0xff7E33B8),
          Color(0xffEE5A3A),
        ], tileMode: TileMode.clamp)
            .createShader(bounds);
      },
      child: Icon(
        icon,
        size: 35,
        color: Colors.grey,
      ),
    );
  }
}
