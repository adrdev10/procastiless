import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
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
        return BlocProvider<ProjectBloc>(
            create: (context) => ProjectBloc(ProjectLoadingState(), state),
            child: Scaffold(
                floatingActionButton: AddProjectButton(),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
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
                      icon: Icon(Icons.dashboard, color: Color(0xff65ACEB)),
                    ),
                    BottomNavigationBarItem(
                        activeIcon: getShaderMask(Icons.calendar_today_sharp),
                        label: '',
                        icon: Icon(
                          Icons.calendar_today_sharp,
                          color: Color(0xff65ACEB),
                        )),
                    BottomNavigationBarItem(
                        activeIcon: getShaderMask(
                          Icons.account_box_rounded,
                        ),
                        label: '',
                        icon: Icon(
                          Icons.account_box_rounded,
                          color: Color(0xff65ACEB),
                        )),
                    BottomNavigationBarItem(
                        activeIcon: getShaderMask(Icons.insights),
                        label: '',
                        icon: Icon(
                          Icons.insights,
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
                    if (currentPageSelected == 1) Center(child: tempWdiget)
                  ],
                )));
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
        size: 35,
        color: Color(0xff007AE5),
      ),
    );
  }
}
