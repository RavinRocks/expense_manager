import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:myexpense_manager/add_expense.dart';
import 'package:myexpense_manager/controller/list_expenses_controller.dart';
import 'package:myexpense_manager/expenses_chart.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super .key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyExpense Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Expanse Manager'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String salary = "00";

  final dashboard_controller = Get.put(list_expenses_controller());
  late List<Map<String, dynamic>> month_data = <Map<String, dynamic>>[].obs;
  double petrol = 0.0;

  var curr_month = DateTime.now().month.toString();
  TextEditingController sallery_controller = TextEditingController();

  Map<String, double> dataMap = {"hello": 0.0};
  Map<String, double> dataMapjuly = {};

  final colorList = <Color>[
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.lightGreenAccent,
    Colors.orangeAccent,
    Colors.redAccent,
    Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: dashboard_controller,
        builder: (dashboard_controller) {
          return Scaffold(
            appBar: AppBar(
              leading: Icon(Icons.home),
              backgroundColor: Colors.white,
              titleSpacing: 0,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: Text(
                widget.title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        onTap: () => Get.to(expenses_chart()),
                        child: Card(
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          elevation: 45,
                          color: Colors.grey,
                          shadowColor: Colors.black,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            height: 70,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //SizedBox(height: 10,),
                                const Text("Monthly Spending",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                    "${dashboard_controller.total_expense.toDouble()} Rs",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.greenAccent)),
                                const SizedBox(
                                  height: 10,
                                ),
                                /* const Text("100 Rs Less than Last Month",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300)),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 20,
                      margin: const EdgeInsets.all(10),
                      color: Theme.of(context).highlightColor,
                      shadowColor: Colors.black,
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Card(
                                    elevation: 20,
                                    color: Colors.white,
                                    shadowColor: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () => Get.to(expenses_chart()),
                                        child: Text(
                                          "BALANCE  \n${int.parse(salary) - dashboard_controller.total_expense.toInt()} Rs",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 20,
                                    color: Colors.white,
                                    shadowColor: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "SALARY \n${salary} Rs",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.dialog(Dialog(
                                          shadowColor: Colors.black,
                                          backgroundColor: Colors.white,
                                          elevation: 45,
                                          child: Container(
                                            height: 140,
                                            child: Column(children: [
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller: sallery_controller,
                                                  decoration: const InputDecoration(
                                                    labelText: "Enter Amount",
                                                    hintStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TextButton(
                                                  onPressed: () async {
                                                    SharedPreferences prefs =  await SharedPreferences.getInstance();
                                                    prefs.setString('salary', sallery_controller.text);
                                                    dashboard_controller.salleryctr.value = sallery_controller.text;
                                                    Get.back();
                                                    _loadCounter();
                                                    setState(() {});
                                                  },
                                                  child: Card(
                                                      shadowColor: Colors.black,
                                                      color: Colors.white,
                                                      elevation: 4,
                                                      child: Container(
                                                          height: 20,
                                                          width: 50,
                                                          child: const Text(
                                                            "Set",
                                                            textAlign: TextAlign.center,
                                                          ))))
                                            ]),
                                          ),
                                        ));
                                      },
                                      child: const Text(
                                        "SET SALARY",
                                        style: TextStyle(color: Colors.greenAccent),
                                      ))
                                ],
                              ))),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("1");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("1");

                                setState(() {});
                              },
                              child: const Text("Jan")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("2");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("2");

                                setState(() {});
                              },
                              child: const Text("Feb")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("3");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("3");

                                setState(() {});
                              },
                              child: const Text("March")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("4");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("4");

                                setState(() {});
                              },
                              child: const Text("April")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("5");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("5");

                                setState(() {});

                              },
                              child: const Text("May")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("6");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("6");

                                setState(() {});
                              },
                              child: const Text("June")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("7");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("7");

                                setState(() {});
                              },
                              child: const Text("July")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("8");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("8");

                                setState(() {});
                              },
                              child: const Text("Aug")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data = dashboard_controller.julydata("9");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("9");

                                setState(() {});
                              },
                              child: const Text("Sep")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data =
                                    dashboard_controller.julydata("10");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("10");

                                setState(() {});
                              },
                              child: const Text("oct")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data =
                                    dashboard_controller.julydata("11");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("11");

                                setState(() {});
                              },
                              child: const Text("Nov")),
                          TextButton(
                              onPressed: () {
                                if (month_data.isNotEmpty) month_data.clear();
                                month_data =
                                    dashboard_controller.julydata("12");

                                if (dataMap.isNotEmpty) dataMap.clear();
                                dataMap = dashboard_controller.myfunction("12");

                                setState(() {});
                              },
                              child: const Text("Dec")),
                        ],
                      ),
                    ),

                    // const Text("Change Month"),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: dataMap.isNotEmpty
                          ? PieChart(
                        dataMap: dataMap,
                        animationDuration:
                        const Duration(milliseconds: 1800),
                        // chartLegendSpacing: 15,
                        chartRadius:
                        MediaQuery.of(context).size.width / 3,
                        colorList: colorList,
                        initialAngleInDegree: 0,
                        chartType: ChartType.ring,
                        ringStrokeWidth: 20,
                        centerText: "Spendings",
                        legendOptions: const LegendOptions(
                          showLegendsInRow: false,
                          legendPosition: LegendPosition.right,
                          showLegends: true,
                          legendTextStyle: TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValueBackground: false,
                          showChartValues: true,
                          chartValueStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.bold),
                          showChartValuesInPercentage: false,
                          showChartValuesOutside: true,
                          decimalPlaces: 0,
                        ),
                      )
                          : const Text(
                        "First Set Your Salary \nThen Add a Expences",
                        style: TextStyle(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 45),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ListView.builder(
                          itemCount: month_data.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).highlightColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(5),
                                child: Container(
                                  margin:
                                  const EdgeInsets.fromLTRB(0, 0, 45, 0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.greenAccent,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        margin: const EdgeInsets.all(10),
                                        child: Column(
                                          children: [
                                            Text(
                                              month_data[index]["catagory"].toString(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).cardColor,
                                          borderRadius:
                                          BorderRadius.circular(10),
                                        ),
                                        margin: const EdgeInsets.all(5),
                                        child: Column(
                                          children: [
                                            Text(
                                              month_data[index]["price"].toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                month_data[index]["date"].toString().substring(0, 10),
                                                style: const TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            InkWell(
                                                onTap: () {
                                                  dashboard_controller.mydelete(month_data[index]['id']);
                                                },
                                                child: const Text("Delete"))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: Container(
              child: FloatingActionButton(
                mini: true,
                onPressed: () {
                  Get.to(add_expense())
                      ?.then((value) => dashboard_controller.mydatas());
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.pink,
                ),
              ),
            ),

            /* drawer: Drawer(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    'assets/icon.png',
                    height: 100,
                    width: 100,
                  ),
                  ListTile(
                    title: const Text(
                      "My EP",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Settings",
                        style: TextStyle(),
                      ),
                    ),
                    leading: const Icon(Icons.settings),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    title: const Text("About"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: const Icon(Icons.account_balance_outlined),
                  ),
                ],
              ),
            ),*/
          );
        });
  }

  @override
  void initState() {
    super.initState();
    print("curr_mont=$curr_month");
    month_data = dashboard_controller.julydata(curr_month);
    dataMap = dashboard_controller.myfunction(curr_month);
    _loadCounter();
  }

  void _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    salary = prefs.getString('salary') ?? "00";
    setState(() {});
  }
}
