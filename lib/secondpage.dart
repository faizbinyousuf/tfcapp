import 'package:flutter/material.dart';
import 'package:tfcapp/customer.dart';
import './database_helper.dart';

class ManagePage extends StatefulWidget {
  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  DatabaseHelper dbHelper;
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper.instance;
    getCustomerList();
  }

  final _formKey = GlobalKey<FormState>();
  List<Customer> customerList;
  Customer _customer;

  getCustomerList() async {
    List<Customer> x = await dbHelper.queryAll();
    setState(() {
      customerList = x;
    });
  }

  final ctrlSmall = TextEditingController();
  final ctrlMedium = TextEditingController();
  final ctrlMarked = TextEditingController();
  final ctrlSmallReturn = TextEditingController();
  final ctrlMediumReturn = TextEditingController();
  final ctrlMarkedReturn = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Crates'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButtonFormField<Customer>(
                    elevation: 1,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    hint: Text('Customer Name'),
                    value: _customer,
                    onChanged: (Customer value) {
                      setState(() {
                        _customer = value;
                        //ctrl.text = _customer.crateCount.toString();
                      });
                    },
                    items: customerList
                            ?.map((user) => DropdownMenuItem<Customer>(
                                  child: Text(user.name),
                                  value: user,
                                ))
                            ?.toList() ??
                        [],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    //key: _formKey,
                    keyboardType: TextInputType.number,
                    controller: ctrlSmall,
                    decoration: InputDecoration(
                      hintText: 'Small Crates',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                    //validator: (val) =>  (val.isEmpty ? 'Enter 0 if no crates taken' : null),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrlMedium,
                    decoration: InputDecoration(
                      hintText: 'Medium Crates',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrlMarked,
                    decoration: InputDecoration(
                      hintText: 'Marked Crates',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueGrey[900],
                  textColor: Colors.white,
                  child: Text('Out'),
                  onPressed: _out,
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.teal,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrlSmallReturn,
                    decoration: InputDecoration(
                      hintText: 'Small Crates',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrlMediumReturn,
                    decoration: InputDecoration(
                      hintText: 'Medium Crates',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrlMarkedReturn,
                    decoration: InputDecoration(
                      hintText: 'Marked Crates',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueGrey[900],
                  textColor: Colors.white,
                  child: Text('Return'),
                  onPressed: _return,
                ),
              ],
            ),
          ),
        ],
      ),
      // Navigator.pop(context,true)
    );
  }

  _out() async {
    var dbSmall = _customer.crateSmall;
    var dbMed = _customer.crateMedium;
    var dbMark = _customer.crateMarked;
    var newsc = int.parse(ctrlSmall.text);
    var newmdc = int.parse(ctrlMedium.text);
    var newmrc = int.parse(ctrlMarked.text);
    _customer.crateSmall = dbSmall + newsc;
    _customer.crateMedium = dbMed + newmdc;
    _customer.crateMarked = dbMark + newmrc;

    await dbHelper.update(_customer);
    resetForm();
  }

  _return() async {
    var dbSmall = _customer.crateSmall;
    var dbMed = _customer.crateMedium;
    var dbMark = _customer.crateMarked;
    var retSmall = int.parse(ctrlSmallReturn.text);
    var retMed = int.parse(ctrlMediumReturn.text);
    var retMark = int.parse(ctrlMarkedReturn.text);
    _customer.crateSmall = dbSmall - retSmall;
    _customer.crateMedium = dbMed - retMed;
    _customer.crateMarked = dbMark - retMark;

    await dbHelper.update(_customer);
    resetForm();
  }

  resetForm() {
    setState(() {
      ctrlSmall.clear();
      ctrlMedium.clear();
      ctrlMarked.clear();
      //_customer.id = null;
      ctrlSmallReturn.clear();
      ctrlMediumReturn.clear();
      ctrlMarkedReturn.clear();
    });
  }
}
