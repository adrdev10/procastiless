import 'package:flutter/material.dart';

class NewProject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewProjectState();
}

class NewProjectState extends State<NewProject> {
  TextEditingController? textEditingControllerName;
  TextEditingController? textEditingControllerTime;
  TextEditingController? textEditingControllerDesc;
  String? inputTime;
  String? name;
  String? projectDesc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingControllerName = TextEditingController();
    textEditingControllerTime = TextEditingController();
    textEditingControllerDesc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xff243C51),
          child: Stack(
            children: [
              Positioned(
                top: -90,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white),
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
                          onSubmitted: (text) {
                            setState(() {
                              name = text;
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
                        GestureDetector(
                          onTap: () async {
                            await showDatePicker(
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
                                left: MediaQuery.of(context).size.width * .75),
                            child: Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * .5,
                  left: 20,
                  child: Row(
                    children: [],
                  )),
            ],
          )),
    );
  }
}
