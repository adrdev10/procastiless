import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procastiless/components/login/bloc/login_block.dart';
import 'package:procastiless/components/login/bloc/login_event.dart';
import 'package:procastiless/components/login/bloc/login_state.dart';

class BottomSheetContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    // INFO: Provider using LoginBloc -> WaitingToLogin()
    // INFO: Initial part of the app. Do you
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(WaitingToLogin()),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<LoginBloc>().add(new SignInEvent());
                },
                child: Text("Log in with Google"),
              ),
            ],
          );
        },
      ),
    );
  }
}
