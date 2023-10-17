import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'controller/list_expenses_controller.dart';

class expenses_chart extends StatefulWidget {
  expenses_chart({Key? key}) : super(key: key);

  @override
  State<expenses_chart> createState() => _expenses_chartState();
}

class _expenses_chartState extends State<expenses_chart> {
  final dashboard_controller = Get.put(list_expenses_controller());

  late List<ExpenseData> myexp_data2;

  List<ExpenseData> mychartdata() {
    final List<ExpenseData> myexp_data = [
      ExpenseData("JAN", dashboard_controller.myexpensereturn("1")),
      ExpenseData("FEB", dashboard_controller.myexpensereturn("2")),
      ExpenseData("MARCH", dashboard_controller.myexpensereturn("3")),
      ExpenseData("APRIL", dashboard_controller.myexpensereturn("4")),
      ExpenseData("MAY", dashboard_controller.myexpensereturn("5")),
      ExpenseData("JUNE", dashboard_controller.myexpensereturn("6")),
      ExpenseData("JULY", dashboard_controller.myexpensereturn("7")),
      ExpenseData("AUG", dashboard_controller.myexpensereturn("8")),
      ExpenseData("SEPT", dashboard_controller.myexpensereturn("9")),
      ExpenseData("OCT", dashboard_controller.myexpensereturn("10")),
      ExpenseData("NOV", dashboard_controller.myexpensereturn("11")),
      ExpenseData("DEC", dashboard_controller.myexpensereturn("12")),
    ];
    return myexp_data;
  }

  @override
  void initState() {
    super.initState();
    myexp_data2 = mychartdata();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: dashboard_controller,
        builder: (dashboard_controller) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Chart"),
            ),
            body: Column(
              children: [
                SfCartesianChart(
                  legend: const Legend(isVisible: true),
                  title: ChartTitle(text: "Expenses"),
                  series: <ChartSeries>[
                    StackedBarSeries<ExpenseData, String>(
                        name: "Months",
                        markerSettings: const MarkerSettings(isVisible: true),
                        dataSource: myexp_data2,
                        xValueMapper: (ExpenseData exp, _) =>
                            exp.monthly_expense,
                        yValueMapper: (ExpenseData exp, _) =>
                            exp.total_spending),
                  ],
                  primaryXAxis: CategoryAxis(),
                ),
              ],
            ),
          );
        });
  }
}
class ExpenseData {
  ExpenseData(this.monthly_expense, this.total_spending);
  String monthly_expense;
  int total_spending;
}