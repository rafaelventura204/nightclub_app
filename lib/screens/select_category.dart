import 'package:bar_pub/services/global_preferences.dart';
import 'package:bar_pub/services/load_data_user.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<int> _selectedItems = List<int>();
  GlobalPreferences gPref = GlobalPreferences();

  stampaCategory() {
    List<String> tmp = List<String>();
    for (var item in _selectedItems) {
      print(listCategory.elementAt(item));
      tmp.add(listCategory.elementAt(item).toString());
    }
    gPref.addCategoriestoSF(tmp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  stampaCategory();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.check, color: Colors.white),
              ),
              Text('Seleziona categorie')
            ],
          ),
          backgroundColor: Colors.purple[300],
        ),
        body: ListView.builder(
          itemCount: 31,
          itemBuilder: (context, index) {
            return Container(
              color: (_selectedItems.contains(index))
                  ? Colors.purple.withOpacity(0.5)
                  : Colors.transparent,
              child: ListTile(
                onTap: () {
                  if (_selectedItems.contains(index)) {
                    setState(() {
                      _selectedItems.removeWhere((val) => val == index);
                    });
                  }
                },
                onLongPress: () {
                  if (!_selectedItems.contains(index)) {
                    setState(() {
                      _selectedItems.add(index);
                    });
                  }
                },
                title: Text(listCategory
                    .elementAt(index)
                    .replaceAll("[", "")
                    .replaceAll("]", "")),
              ),
            );
          },
        ),
      ),
    );
  }
}
