import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _ifsc = TextEditingController();
  TextEditingController _accountNumber = TextEditingController();
  final FocusScopeNode _node = FocusScopeNode();

  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraints) {
        Future<void> _submit() async {
          if (!_formKey.currentState.validate()) {
            // Invalid!
            return;
          }
          _formKey.currentState.save();
          setState(() {
            _isLoading = true;
          });
          try {
            await users.add({
              "fullName": _name.text,
              "email": _email.text,
              "phoneNumber": _phone.text,
              "accountNumber": _accountNumber.text,
              "ifsc": _ifsc.text,
            });
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Information added to firebase"),
            ));
          } catch (error) {
            _showErrorDialog(error.toString());
          }

          setState(() {
            _node.unfocus();
            _email.clear();
            _name.clear();
            _phone.clear();
            _ifsc.clear();
            _accountNumber.clear();
            _isLoading = false;
          });
        }

        return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            color: Colors.lightGreen[200],
            padding: constraints.maxWidth < 500
                ? EdgeInsets.zero
                : const EdgeInsets.all(30.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 30.0, horizontal: 25.0),
                constraints: BoxConstraints(
                  maxWidth: 500,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Form(
                  key: _formKey,
                  child: FocusScope(
                    node: _node,
                    child: Card(
                      semanticContainer: false,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 5,
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                              child: Text(
                                "Welcome!",
                                style: GoogleFonts.openSans(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Text(
                                "Enter the information",
                                style: GoogleFonts.openSans(
                                    color: Color(0xFF575563),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: _node.nextFocus,
                              controller: _name,
                              validator: (value) =>
                                  (value.isEmpty) ? "Please Enter value" : null,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                              ),
                              decoration: kinputDecoration.copyWith(
                                labelText: "Name",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: _node.nextFocus,
                              controller: _email,

                              // ignore: missing_return
                              validator: (value) {
                                if (!(value.contains("@")) &&
                                    value.isNotEmpty) {
                                  return 'Please enter a valid email address';
                                }
                                if (value == null || value.isEmpty) {
                                  return 'Please enter email address';
                                }
                              },
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                              ),
                              decoration: kinputDecoration.copyWith(
                                labelText: "Email Address",
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: _node.nextFocus,
                              controller: _phone,
                              validator: (value) =>
                                  (value.isEmpty) ? "Please Enter value" : null,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                              ),
                              decoration: kinputDecoration.copyWith(
                                labelText: "Phone",
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              onEditingComplete: _node.nextFocus,
                              controller: _accountNumber,
                              validator: (value) =>
                                  (value.isEmpty) ? "Please Enter value" : null,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                              ),
                              decoration: kinputDecoration.copyWith(
                                labelText: "Account Number",
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              onEditingComplete: _node.nextFocus,
                              controller: _ifsc,
                              validator: (value) =>
                                  (value.isEmpty) ? "Please Enter value" : null,
                              style: GoogleFonts.openSans(
                                fontSize: 14,
                              ),
                              decoration: kinputDecoration.copyWith(
                                labelText: "IFSC Code",
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 15, bottom: 8),
                              child: _isLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                          color:
                                              Theme.of(context).primaryColor))
                                  : MaterialButton(
                                      color: Theme.of(context).primaryColor,
                                      height: 55,
                                      minWidth:
                                          MediaQuery.of(context).size.width -
                                              75,
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          _submit();
                                        }
                                      },
                                      child: Text(
                                        "Submit Info",
                                        style: GoogleFonts.openSans(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    )),
                          // SizedBox(
                          //   height: 32,
                          // ),
                          // Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          MaterialButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
