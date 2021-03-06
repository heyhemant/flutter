import 'dart:async';
import 'package:book_darshan/module/temple.dart';
import 'package:book_darshan/services/Appointments.dart';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class form extends StatelessWidget {
  String _details;
  String _email;
  String _now;
  String _name;
  String _mob;
  int _members;
  String _date;
  final String temple;
  form({this.temple});
  String _add;
  String _pincode;
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name of Family Head'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildemail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Enter Your Email Address'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _builadd() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _add = value;
      },
    );
  }

  Widget _buildmembers() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }
        return null;
      },
      onSaved: (String value) {
        _members = value as int;
      },
    );
  }

  Widget _buildmob() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone number'),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _mob = value;
      },
    );
  }

  Widget _buildpincode() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Pincode'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pin Code is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _pincode = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final temples = Provider.of<List<Temple>>(context);
    return StreamBuilder<Temple>(
        stream: null,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 15.0),
                  child: Text(
                    'Book Temple',
                    style: Theme.of(context).textTheme.display1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black),
                  ),
                )),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _buildName(),
                      DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2100),
                        icon: Icon(Icons.event),
                        dateLabelText: 'Date',
                        onChanged: (val) => _date = val,
                        validator: (val) {
                          _date = val;
                          return null;
                        },
                        onSaved: (String val) {
                          _date = val;
                          _now = DateTime.now().toString();
                        },
                      ),
                      _builadd(),
                      _buildmob(),
                      _buildemail(),
                      _buildpincode(),
                      SizedBox(height: 100),
                      RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        onPressed: () async {
                          // ignore: await_only_futures
                          await Timer(Duration(seconds: 3), () {
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                            _formKey.currentState.save();
                            Appointments(ref: _date)
                                .book(_name, _date, _add, _mob, _email, temple);
                            //Send to API
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
