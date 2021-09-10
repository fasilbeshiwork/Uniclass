import 'package:flutter/material.dart';
import 'package:uniclass/SignUp/signupform.dart';
import 'package:uniclass/Database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uniclass/userscreen/userscreen.dart';

class SignUpWithMail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpWithMail();
}

class _SignUpWithMail extends State<SignUpWithMail> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _nameTextController = TextEditingController();

  Map<String, dynamic> _userDataMap = Map<String, dynamic>();

  PageController _pageController = PageController();

  String _nextText = 'Next';
  Color _nextColor = Colors.green[800];

  _updateMyTitle(List<dynamic> data) {
    setState(() {
      _userDataMap[data[0]] = data[1];
    });
  }

  _setIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
  }

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    _query();
    _userDataMap['role'] = 'Student';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 10, bottom: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey[400]),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create Account',
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: 400,
                    height: 400,
                    child: PageView(
                      onPageChanged: (int page) {
                        print('the pageView page is $page');
                        if (page == 2) {
                          setState(() {
                            _nextText = 'Submit';
                            _nextColor = Colors.blue[900];
                          });
                        } else {
                          setState(() {
                            _nextText = 'Next';
                            _nextColor = Colors.green[800];
                          });
                        }
                      },
                      controller: _pageController,
                      children: <Widget>[
                        SignUpForm(_emailTextController, _passwordTextController, _nameTextController, _updateMyTitle)
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Cancel',
                                  style: TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                            textColor: Colors.black,
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              print('email: ${_emailTextController.text}');
                              print('password: ${_passwordTextController.text}');

                              print('_userDataMap $_userDataMap');
                              Navigator.pop(context);
                            _query();
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  _nextText,
                                  style: TextStyle(fontSize: 28),
                                ),
                              ],
                            ),
                            textColor: Colors.white,
                            color: _nextColor,
                            padding: EdgeInsets.all(10),
                            onPressed: () {
                              if (_pageController.page.toInt() == 2) {
                                print('last page');
                                _insert();
                                _setIsLogin();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => UserScreen()),
                                );
                              } else {
                                _pageController.animateToPage(_pageController.page.toInt() + 1, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  // Button onPressed methods

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: _nameTextController.text,
      DatabaseHelper.columnRole: _userDataMap['role'],
      DatabaseHelper.columnEmail: _emailTextController.text,
      DatabaseHelper.columnPassword: _passwordTextController.text,
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) {
      print(row);
      return null;
    });
  }
}
