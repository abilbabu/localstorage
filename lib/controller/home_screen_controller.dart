import 'package:sqflite/sqflite.dart';

class HomeScreenController {
  static late Database myDatabase;
 static List<Map> EmployeeDataList =[];
  // mydatabase can be used ina a all funct while  declaring it global && late is used to mydatabase not null value in future
  static Future initDb() async {
    // oPen database
    myDatabase = await openDatabase("employeeData.Db", version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Employee (id INTEGER PRIMARY KEY, name TEXT, designation TEXT)');
    });
  }

  static Future addEmployee({required String name,required String designation}) async {
    await myDatabase.rawInsert(
        'INSERT INTO Employee (name, designation) VALUES(?, ?)',
        [name,designation]);
    getAllEmployee();
  }

  static Future getAllEmployee() async {
    EmployeeDataList =
        await myDatabase.rawQuery('SELECT * FROM Employee');
    print(EmployeeDataList);
  }

  removeEmployee() {}

  updateEmployee() {}
}
