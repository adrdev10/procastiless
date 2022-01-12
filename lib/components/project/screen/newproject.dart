import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:procastiless/components/project/bloc/project_bloc.dart';
import 'package:procastiless/components/project/bloc/project_event.dart';
import 'package:procastiless/components/project/bloc/project_state.dart';
import 'package:procastiless/components/project/data/project.dart';

class NewProject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewProjectState();
}

class NewProjectState extends State<NewProject>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _colorTween;
  TextEditingController? textEditingControllerName;
  TextEditingController? textEditingControllerTime;
  TextEditingController? textEditingControllerDesc;
  String? inputTime;
  String? name;
  String? projectDesc;
  String? datePicked;
  DateTime? datePickedInTime;
  Color? appBarColor = Colors.white;
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true);
  List<bool> _selections = List.generate(3, (index) => false);
  List<Color> colors = [
    Color(0xffE4C864),
    Color(0xff64C6E4),
  ];
  ScrollPhysics physicsPage = NeverScrollableScrollPhysics();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingControllerName = TextEditingController();
    textEditingControllerTime = TextEditingController();
    textEditingControllerDesc = TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _colorTween = ColorTween(begin: Colors.white, end: Color(0xff243C51))
        .animate(_animationController);
    pageController.addListener(() {
      setState(() {
        print(pageController.offset);
        if (pageController.offset > MediaQuery.of(context).size.height * .5) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var firstPage = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color(0xff243C51),
      child: Stack(
        children: [
          Positioned(
            top: -90,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60), color: Colors.white),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .50,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .08,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Text(
                        'Create new project',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            ?.apply(color: Color(0xff243C51)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter Project Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.grey),
                    ),
                    TextField(
                      style: TextStyle(color: Colors.blue),
                      onSubmitted: (text) {
                        setState(() {
                          name = text;
                          if ((textEditingControllerTime?.text != null ||
                                  textEditingControllerTime?.text != "") &&
                              (datePicked != null || datePicked != "") &&
                              (textEditingControllerName != null ||
                                  textEditingControllerName!.text != "")) {
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut);
                          } else {
                            physicsPage = NeverScrollableScrollPhysics();
                          }
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: textEditingControllerName,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Project Deadline',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${datePicked ?? ""}'),
                        GestureDetector(
                          onTap: () async {
                            var dateSelected = await showDatePicker(
                                context: context,
                                initialDate: new DateTime.now(),
                                firstDate: DateTime(DateTime.now().year - 5),
                                lastDate: DateTime(DateTime.now().year + 5),
                                builder: (context, widget) {
                                  return Theme(
                                      data:
                                          ThemeData(primaryColor: Colors.blue),
                                      child: widget!);
                                });
                            setState(() {
                              datePickedInTime = dateSelected;
                              datePicked = dateSelected != null
                                  ? DateFormat.yMMMMEEEEd().format(dateSelected)
                                  : "";
                              if ((textEditingControllerName?.text != null ||
                                      textEditingControllerName?.text != "") &&
                                  (datePicked != null || datePicked != "") &&
                                  _selections
                                      .any((element) => element == true)) {
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 600),
                                    curve: Curves.easeInOut);
                              } else {
                                physicsPage = NeverScrollableScrollPhysics();
                              }
                            });
                          },
                          child: Container(
                            width: 55,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              gradient: LinearGradient(
                                colors: [Color(0xff3378B8), Color(0xff7E33B8)],
                              ),
                            ),
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .15),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * .45,
              left: 20,
              child: Row(
                children: [
                  ToggleButtons(
                      renderBorder: false,
                      onPressed: (index) {
                        setState(() {
                          for (var i = 0; i < _selections.length; i++) {
                            if (i == index) {
                              _selections[i] = true;
                            } else {
                              _selections[i] = false;
                            }
                          }
                          if ((textEditingControllerName?.text != null ||
                                  textEditingControllerName?.text != "") &&
                              (_selections.any((element) => element == true)) &&
                              (textEditingControllerTime?.text != null ||
                                  textEditingControllerTime?.text != "")) {
                            physicsPage = BouncingScrollPhysics();
                            pageController.animateToPage(1,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOutExpo);
                          } else {
                            physicsPage = NeverScrollableScrollPhysics();
                          }
                        });
                      },
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: 35,
                          width: 75,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red),
                          child: Center(
                            child: Text(
                              "HIGH",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: 35,
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffE4C864),
                          ),
                          child: Center(
                            child: Text(
                              'MEDIUM',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          height: 35,
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff64C6E4),
                          ),
                          child: Center(
                              child: Text(
                            'LOW',
                            style: TextStyle(color: Colors.white),
                          )),
                        )
                      ],
                      isSelected: _selections)
                ],
              )),
        ],
      ),
    );
    return AnimatedBuilder(
      animation: _colorTween,
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: _colorTween.value,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 28,
                color: Colors.blue,
              ),
            ),
          ),
          body: PageView(
            physics: physicsPage,
            controller: pageController,
            scrollDirection: Axis.vertical,
            children: [
              firstPage,
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xff243C51),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project description',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.grey, fontSizeDelta: 3),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(color: Colors.white),
                        controller: textEditingControllerDesc,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                    ),
                    BlocBuilder<ProjectBloc, ProjectBaseState>(
                      builder: (context, state) {
                        return Center(
                          child: ElevatedButton(
                            onPressed: () {
                              var priority = "";
                              if (_selections[0]) priority = 'HIGH';
                              if (_selections[1]) priority = 'MEDIUM';
                              if (_selections[2]) priority = 'LOW';
                              Project project = Project(
                                  Timestamp.fromDate(
                                    datePickedInTime!,
                                  ),
                                  textEditingControllerDesc?.text,
                                  textEditingControllerName?.text,
                                  priority,
                                  "",
                                  0);
                              context
                                  .read<ProjectBloc>()
                                  .add(new CreateProjectEvent(project));
                              Navigator.pop(context);
                            },
                            child: Text("Create project"),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
