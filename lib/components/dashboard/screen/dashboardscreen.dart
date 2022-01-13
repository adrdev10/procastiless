import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/calendar/calendarscreen.dart';
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

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: AddProjectButton(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              iconSize: 22,
              elevation: 999,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentPageSelected,
              selectedLabelStyle:
                  TextStyle(color: Color(0xff65ACEB), fontSize: 10),
              unselectedItemColor: Color(0xff65ACEB),
              unselectedFontSize: 10,
              items: [
                BottomNavigationBarItem(
                  label: 'Overview',
                  activeIcon: getShaderMask(Icons.house_rounded),
                  icon: Icon(Icons.house_rounded, color: Color(0xff65ACEB)),
                ),
                BottomNavigationBarItem(
                    activeIcon: getShaderMask(Icons.calendar_today_rounded),
                    label: 'Calendar',
                    icon: Icon(
                      Icons.calendar_today_rounded,
                      color: Color(0xff65ACEB),
                    )),
                BottomNavigationBarItem(
                    activeIcon: getShaderMask(Icons.analytics),
                    label: 'Analytics',
                    icon: Icon(
                      Icons.analytics,
                      color: Color(0xff65ACEB),
                    )),
                BottomNavigationBarItem(
                    activeIcon: getShaderMask(Icons.person),
                    label: 'Account',
                    icon: Icon(
                      Icons.person,
                      color: Color(0xff65ACEB),
                    )),
              ],
              onTap: (index) {
                setState(() {
                  currentPageSelected = index;
                });
              },
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                if (currentPageSelected == 0) ProjectScreen(),
                if (currentPageSelected == 1) CalendarScreen(),
                if (currentPageSelected == 3) Center(child: tempWdiget),
              ],
            ));
      },
    );
  }

  getShaderMask(IconData icon) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(colors: <Color>[
          Color(0xff65ACEB),
          Color(0xff007AE5),
        ], tileMode: TileMode.clamp)
            .createShader(bounds);
      },
      child: Icon(
        icon,
        size: 30,
        color: Color(0xff007AE5),
      ),
    );
  }
}
