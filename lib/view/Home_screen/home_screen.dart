import 'package:flutter/material.dart';
import 'package:localstorage/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await HomeScreenController.getAllEmployee();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _CustomBottomSheet(context);
        },
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                title: Text(HomeScreenController.EmployeeDataList[index]["name"]
                    .toString()),
                subtitle: Text(HomeScreenController.EmployeeDataList[index]
                        ['designation']
                    .toString()),
              ),
          separatorBuilder: (context, index) => Divider(),
          itemCount: HomeScreenController.EmployeeDataList.length),
    );
  }

  Future<dynamic> _CustomBottomSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController designationController = TextEditingController();
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 500,
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black))),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: designationController,
                  decoration: InputDecoration(
                      hintText: 'Designation',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black))),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"))),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              await HomeScreenController.addEmployee(
                                name: nameController.text,
                                designation: designationController.text,
                              );
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: Text("Save")))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
