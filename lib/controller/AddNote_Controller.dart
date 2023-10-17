import 'package:get/get.dart';
class AddNote_Controller extends GetxController
{
  int myindexes=0.obs.toInt();
  String catagory_text="Select Catagory".obs.toString();

  @override
  void onInit() {
    super.onInit();
  }

  updateIndex(int ind)
  {myindexes=ind;
    update();}

  int returnindex()
  {update();
    return myindexes;}

  updatecatagory_text(String text)
  {catagory_text=text;}
}