import 'package:acman_app/model/activity.dart';
import 'package:flutter/material.dart';

class NewActivityPage extends StatelessWidget {

  final Activity activity;

  NewActivityPage(this.activity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(activity.caption),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: new NetworkImage(
                    this.activity.backgroundIconUrl,
                  ),
                  fit: BoxFit.cover
              ),
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: ListView(

            children: <Widget>[
              ListTile(
                  title: MyActivityForm(
                      activity: this.activity
                  )
              )
            ],
          ),
        )
    );
  }
}

class MyActivityForm extends StatefulWidget {
  Activity activity;
  MyActivityForm({Key key, this.activity}) : super(key: key);
  @override
  _MyActivityFormState createState() => _MyActivityFormState();
}

class _MyActivityFormState extends State<MyActivityForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final captionController = TextEditingController();
  final startDateController = TextEditingController();

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2016),
        lastDate: new DateTime(2019)
    );
    return picked.toString();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    captionController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    captionController.text = widget.activity.caption;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: captionController,
          decoration: InputDecoration(
            fillColor: Colors.white,
              filled: true,
              hintText: 'Что будем делать?',
            enabledBorder: OutlineInputBorder()
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          minLines: 3,
          onChanged: (text) => widget.activity.caption = text,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
        )
      ],
    );
  }
}