import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myexpense_manager/sql_helper.dart';
import 'controller/AddNote_Controller.dart';

class add_expense extends StatefulWidget {
  @override
  _add_expenseState createState() {
    return _add_expenseState();
  }
}

class _add_expenseState extends State<add_expense> {

  static const routeNamed = "/addexpe";
  AddNote_Controller _addNote_Controller = Get.put(AddNote_Controller());
  final TextEditingController price_controller = TextEditingController();
  DateTime? mydate = DateTime.now();
  String myCatagory = "null";

  @override
  void initState() {
    super.initState();
  }

  Future<void> _addItem() async {
    await SQLHelper.createItem(myCatagory, price_controller.text, mydate.toString());
    Navigator.pop(context);
  }

  Widget myfun() {
    return Container(
      child: IconButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            barrierLabel: "showGeneralDialog",
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.0),
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  child: Container(
                    height: 210,
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.greenAccent,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  myCatagory = "Credit Card Bill";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.cabin),
                                    Text("Credit Card Bill")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myCatagory = "Petrol";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.propane_tank),
                                    Text("Petrol")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myCatagory = "Mobile Recharge";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.mobile_friendly),
                                    Text("Mobile Recharge")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.orangeAccent,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  myCatagory = "Shopping";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.shopping_basket_sharp),
                                    Text("Shopping")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myCatagory = "Medical";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.medical_information),
                                    Text("Medical")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myCatagory = "Insurance";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.policy),
                                    Text("Insurance")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: Colors.greenAccent,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  myCatagory = "Light Bill";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.lightbulb_circle),
                                    Text("Light Bill")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myCatagory = "Gas Bill";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.gas_meter),
                                    Text("Gas Bill")
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  myCatagory = "Other";
                                  _addNote_Controller.updatecatagory_text(myCatagory);
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: const Column(
                                  children: [
                                    Icon(Icons.other_houses_outlined),
                                    Text("Other")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: _addNote_Controller,
        builder: (_addNote_Controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Add Expense"),
            ),
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _addNote_Controller.catagory_text.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        myfun(),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: price_controller,
                    decoration: const InputDecoration(
                      hintText: " Enter Amount:",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(10),
                  child: CalendarTimeline(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(const Duration(days: 140)),
                    lastDate: DateTime.now().add(const Duration(days: 131)),
                    onDateSelected: (date) => mydate = date,
                    leftMargin: 20,
                    shrink: true,
                    showYears: true,
                    monthColor: Colors.white,
                    dayColor: Colors.white,
                    activeDayColor: Colors.white,
                    activeBackgroundDayColor: Colors.redAccent[100],
                    dotsColor: const Color(0xFF333A47),
                    //  selectableDayPredicate: (date) => date.day != 23,
                    locale: 'en_ISO',
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent),
                  child: TextButton(
                      onPressed: () {},
                      child: InkWell(
                          onTap: () {
                            if (myCatagory != "null" &&
                                price_controller.text.isNotEmpty) {
                              _addItem();
                            } else {
                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter All Data"+mydate.toString()+" "+myCatagory+" "+price_controller.text,)));
                              Get.showSnackbar(const GetSnackBar(
                                  title: "Enter Valid Details",
                                  message: "No Data Found"));
                            }
                            setState(() {});
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ))),
                )
              ],
            ),
          );
        });
  }
}
