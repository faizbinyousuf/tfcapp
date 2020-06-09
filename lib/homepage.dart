import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfcapp/database_helper.dart';
import 'package:tfcapp/secondpage.dart';

import './customer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Customer _customer = Customer();
  DatabaseHelper _dbHelper;
  final _formKey = GlobalKey<FormState>();
  int sum = 0;
  @override
  void initState() {
    super.initState();
    _dbHelper = DatabaseHelper.instance;
    _refreshCustomerList();
  }

  _refreshCustomerList() async {
    List<Customer> x = await _dbHelper.queryAll();
    setState(() {
      _customersList = x;
    });
  }

  List<Customer> _customersList = [];
  final _ctrlName = TextEditingController();
  final _ctrlSmallCrate = TextEditingController();
  final _ctrlMediumCrate = TextEditingController();
  final _ctrlMarkedCrate = TextEditingController();
  var x = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              elevation: 3,
              onPressed: () async {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ManagePage()))
                    .whenComplete(_refreshCustomerList);
              },
              child: Text('Manage Crates'),
              color: Colors.blueGrey[900],
              textColor: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.blueGrey[900],
        title: Center(
          child: Text(
            'TFC App',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[_form(), _list()],
        ),
      ),
    );
  }

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _ctrlName,
                decoration: InputDecoration(labelText: 'Cust Name'),
                validator: (val) =>
                    (val.length == 0 ? 'Name is mandatory' : null),
                onSaved: (val) => setState(() => _customer.name = val),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _ctrlSmallCrate,
                decoration: InputDecoration(labelText: ' Small Crates taken'),
                validator: (val) =>
                    (val.isEmpty ? 'Enter 0 if no crates taken' : null),
                onSaved: (val) =>
                    setState(() => _customer.crateSmall = int.parse(val)),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _ctrlMediumCrate,
                decoration: InputDecoration(labelText: 'Medium Crates taken'),
                validator: (val) =>
                    (val.isEmpty ? 'Enter 0 if no crates taken' : null),
                onSaved: (val) =>
                    setState(() => _customer.crateMedium = int.parse(val)),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _ctrlMarkedCrate,
                decoration: InputDecoration(labelText: 'Marked Crates taken'),
                validator: (val) =>
                    (val.isEmpty ? 'Enter 0 if no crates taken' : null),
                onSaved: (val) =>
                    setState(() => _customer.crateMarked = int.parse(val)),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: _onSubmit,
                  child: Text('Submit'),
                  color: Colors.blueGrey[900],
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

//  _nextPage(){
//
//
//    Navigator.push(this.context, MaterialPageRoute(builder: (context){
//      return UpdatePage();
//    }));
//  }
  _onSubmit() async {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_customer.id == null)
        await _dbHelper.insert(_customer);
      else
        await _dbHelper.update(_customer);
      //form.reset();
      _resetForm();
      await _refreshCustomerList();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _ctrlName.clear();
      _ctrlSmallCrate.clear();
      _ctrlMediumCrate.clear();
      _ctrlMarkedCrate.clear();
      _customer.id = null;
    });
  }

  _list() => Expanded(
        child: Card(
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: Scrollbar(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 400,
                      height: 130,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _customersList[index].name.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, bottom: 2),
                                child: Text(
                                  'Small Crates:         ${_customersList[index].crateSmall}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, top: 2, bottom: 2),
                                child: Text(
                                  'Medium Crates:     ${_customersList[index].crateMedium}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 2),
                                child: Text(
                                  'Marked Crates:      ${_customersList[index].crateMarked}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                              icon: Icon(Icons.delete,
                              color: Colors.blueGrey,),
                              onPressed: () async {
                                await _dbHelper
                                    .delete(_customersList[index].id);
                                _resetForm();
                                _refreshCustomerList();
                              }),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blueGrey[900],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                );
              },
              itemCount: _customersList.length,
            ),
          ),
        ),
      );
  _showForEdit(index) {
    setState(() {
      print('old crate count is $x');

      _customer = _customersList[index];
      _ctrlName.text = _customersList[index].name;
    });
  }
}
