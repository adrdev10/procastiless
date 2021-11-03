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
            size: 30,
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
                top: -80,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.white),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .55,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create new project',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              ?.apply(color: Color(0xff243C51)),
                        ),
                        SizedBox(
                          height: 50,
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
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .5,
                left: 20,
                child: Text(
                  'Project description',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.apply(color: Colors.grey),
                ),
              ),
            ],
          )),
    );
  }
}
