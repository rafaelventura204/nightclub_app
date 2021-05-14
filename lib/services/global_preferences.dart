import 'package:bar_pub/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalPreferences {
  MyUser myUser = MyUser();
  String finalNameUser;
  List<String> categoriesElement;

  //create user object base on Postgress
  MyUser _createdUser(String nameUser) {
    return nameUser != null ? MyUser(nameUser: nameUser) : null;
  }

  /* U S E R*/
  addStringToSF(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name_user', value);
    myUser = _createdUser(value);
    print("${prefs.getString('name_user')}[LOGIN->global_preferences]");
  }

  getStringValuesSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic stringValue = prefs.getString('name_user');
    finalNameUser = stringValue;
    //myUser.nameUser = finalNameUser;
    //return stringValue;
  }

  removeSF() async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();
    userPreferences.remove('name_user');
  }

  String getNameUser() {
    getStringValuesSF();
    return finalNameUser;
  }

  /* C A T E G O R Y  U S E R*/
  addCategoriestoSF(List<String> elements) async {
    final SharedPreferences categories = await SharedPreferences.getInstance();
    categories.setString('categories', elements.toString());
  }

  getCategoriesSF() async {
    final SharedPreferences categories = await SharedPreferences.getInstance();
    dynamic elementsValue = categories.getString('categories');

    return elementsValue;
    /*categoriesElement = elementsValue;
    for (var item in elementsValue) {
      print('$item [globla_preferences]');
    }*/
  }

  /*List<String> getCategories() {
    getCategoriesSF();
    return categoriesElement;
  }*/
}
