// ignore_for_file: non_constant_identifier_names, camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../sql_helper.dart';

class list_expenses_controller extends GetxController {

  late List<Map<String, dynamic>> data=<Map<String, dynamic>>[].obs;
  Map<String, double> dataMap = {};
  RxDouble total_expense=0.0.obs;
  RxString salleryctr="0".obs;
  Rx<TextEditingController> sallery_controller = TextEditingController().obs;

  late List<Map<String, dynamic>> month_data=<Map<String, dynamic>>[].obs;
  late List<Map<String, dynamic>> july_data=<Map<String, dynamic>>[].obs;
  late List<Map<String, dynamic>> aug_data=<Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _refreshJournals();
  }

  _refreshJournals() async {
     data = await SQLHelper.getItems();
     julydata(DateTime.now().month.toString());
     myfunction(DateTime.now().month.toString());
     update();
  }

  mydatas()  async {
    data = await SQLHelper.getItems();
    update();
    dataMap.clear();
    dataMap=myfunction(DateTime.now().month.toString());
    julydata(DateTime.now().month.toString());
  }

  Map<String, double> myfunction(String month)
  {
    total_expense.value=0.0;
    dataMap.clear();
    int mymonth=int.parse(month);

    if(mymonth<=9) {
      month="0$month";
    }
    for(var i=0;i<data.length;i++) {
      if(data[i]['date'].toString().substring(5,7)==month){
        print("Month="+data[i]['date'].toString().substring(5,7).toString());
        dataMap[data[i]['catagory'].toString()]=double.parse(data[i]['price']);
        total_expense.value+=double.parse(data[i]['price']);
      }
    }
    return dataMap;
  }
  int myexpensereturn(String month)
  {
    total_expense.value=0.0;
    print("${data.length} length");
    int mymonth=int.parse(month);
    if(mymonth<=9) {
      month="0$month";
    }
    for(var i=0;i<data.length;i++)
    {
      if(data[i]['date'].toString().substring(5,7)==month){
        total_expense.value+=double.parse(data[i]['price']);
      }
    }
    return total_expense.toInt();
  }

  List<Map<String, dynamic>> julydata(String month)
  {
    int mymonth=int.parse(month);
    if(mymonth<=9) {
      month="0$month";
    }
    july_data.clear();
    for(var i=0;i<data.length;i++) {
      if(data[i]['date'].toString().substring(5,7)==month){
        july_data.add(data[i]);
      }
    }
    update();
    return july_data;
  }
  mydelete(int id)
  async {
    await SQLHelper.deleteItem(id);
    _refreshJournals();
    update();
  }
}