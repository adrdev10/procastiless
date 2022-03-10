import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:procastiless/components/project/data/project.dart';

class SingleProjectScreen extends StatefulWidget {
  Project? project;
  SingleProjectScreen(this.project);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SingleProjectScreenState();
  }
}

class SingleProjectScreenState extends State<SingleProjectScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.project!.name!;
    description.text = widget.project!.description!;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print(title.text);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: Color(0xff243C51),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: TextStyle(fontSize: 25, color: Color(0xff243C51)),
              controller: title,
              decoration: InputDecoration.collapsed(
                hintText: "",
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("Progress "),
                Text("${widget.project!.progress! / 100}%")
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 120,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: MediaQuery.of(context).size.width * .9,
              height: 14.5,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: LinearProgressIndicator(
                  color: Color(0xff243C51),
                  backgroundColor: Color(0xff5686b0),
                  value: (widget.project!.progress!) / 100,
                  minHeight: 13,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: 13, color: Color(0xffa5a9ad)),
              controller: description,
              decoration: InputDecoration.collapsed(
                hintText: "",
                border: InputBorder.none,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deadline",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xffa5a9ad)),
                        ),
                        Text(
                          DateFormat.yMMMd()
                              .format(widget.project!.deadline!.toDate()),
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.task_alt_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xffa5a9ad)),
                        ),
                        if (widget.project!.progress! < 100)
                          Text("In Progress")
                        else
                          Text("Finished")
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
