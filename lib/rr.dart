//ListTile(
//
//
//leading: Icon(
//Icons.account_circle,
//color: Colors.blueGrey,
//size: 40.0,
//),
//title: Text(
//_customersList[index].name.toUpperCase(),
//textAlign: TextAlign.left,
//style: TextStyle(
//color: Colors.blueGrey,
//fontWeight: FontWeight.bold),
//),
//subtitle: Text('''
//                      Small: ${_customersList[index].crateSmall}
//                      Medium: ${_customersList[index].crateMedium}
//                      Marked: ${_customersList[index].crateMarked}
//                      ''',textAlign: TextAlign.left,),
//onTap: () {
////                        x = _customersList[index].crateSmall;
////                        _showForEdit(index, x);
//},
//isThreeLine: true,
//trailing: IconButton(
//icon: Icon(
//Icons.delete,
//color: Colors.blueGrey,
//),
//onPressed: () async {
//await _dbHelper.delete(_customersList[index].id);
//_resetForm();
//_refreshCustomerList();
//}),
//),
//Divider(
//color: Colors.grey,
//thickness: 1.5,
//height: 5.0,
//),