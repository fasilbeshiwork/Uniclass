import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(this.emailTextController, this.passwordTextController, this.nameTextController, this.parentAction);

  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final TextEditingController nameTextController;

  final ValueChanged<List<dynamic>> parentAction;

  @override
  State<StatefulWidget> createState() => _SignUpForm();
}

enum RoleEnum { student, teacher }

class _SignUpForm extends State<SignUpForm> with AutomaticKeepAliveClientMixin<SignUpForm> {
  RoleEnum _userRole = RoleEnum.student;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(13.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: 360,
            child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none, icon: Icon(Icons.mail), labelText: 'Email', hintText: 'Type your email'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Email is required';
                } else {
                  return null;
                }
              },
              controller: widget.emailTextController,
            ),
          ),
          Divider(),
          SizedBox(
            width: 360,
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(border: InputBorder.none, icon: Icon(Icons.lock), labelText: 'Password', hintText: 'Type password'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Password is required';
                } else {
                  return null;
                }
              },
              controller: widget.passwordTextController,
            ),
          ),
          Divider(),
          SizedBox(
            width: 360,
            child: TextFormField(
              decoration: InputDecoration(border: InputBorder.none, icon: Icon(Icons.account_circle), labelText: 'Name', hintText: 'Type Name'),
              validator: (String value) {
                if (value.trim().isEmpty) {
                  return 'Name is required';
                } else {
                  return null;
                }
              },
              controller: widget.nameTextController,
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.grey,
              ),
              Radio(
                value: RoleEnum.student,
                groupValue: _userRole,
                onChanged: (RoleEnum value) {
                  setState(() {
                    _passDataToParent('role', 'Student');
                    _userRole = value;
                  });
                },
              ),
              new GestureDetector(
                onTap: () {
                  setState(() {
                    _passDataToParent('role', 'Student');
                    _userRole = RoleEnum.student;
                  });
                },
                child: Text('Student'),
              ),
              SizedBox(
                width: 20,
              ),
              Radio(
                value: RoleEnum.teacher,
                groupValue: _userRole,
                onChanged: (RoleEnum value) {
                  setState(() {
                    _passDataToParent('role', 'Teacher');
                    _userRole = value;
                  });
                },
              ),
              new GestureDetector(
                onTap: () {
                  setState(() {
                    _passDataToParent('role', 'Teacher');
                    _userRole = RoleEnum.teacher;
                  });
                },
                child: Text('Teacher'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _passDataToParent(String key, dynamic value) {
    List<dynamic> addData = List<dynamic>();
    addData.add(key);
    addData.add(value);
    widget.parentAction(addData);
  }

  @override
  bool get wantKeepAlive => true;
}
