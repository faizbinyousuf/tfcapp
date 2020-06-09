class Customer {
  static const tblCustomer = 'customer';
  static const colId = 'id';
  static const colName = 'name';
  static const colCrateSmall = 'crateSmall';
  static const colCrateMedium = 'crateMedium';
  static const colCrateMarked = 'crateMarked';

  Customer({this.id, this.name, this.crateSmall,this.crateMedium,this.crateMarked});
  int id;
  String name;
  int crateSmall;
  int crateMedium;
  int crateMarked;

//convert obj to map
  Customer.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
    crateSmall = map[colCrateSmall];
    crateMedium = map[colCrateMedium];
    crateMarked = map[colCrateMarked];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colName: name, colCrateSmall: crateSmall,colCrateMedium:crateMedium,colCrateMarked:crateMarked};
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
