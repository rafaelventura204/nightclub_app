import 'package:bar_pub/services/load_data_user.dart';
import 'package:bar_pub/services/wrapper.dart';
import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  List<int> _selectedItems = List<int>();
  LoadDataUser loadDataUser = LoadDataUser();

  addUserCategory() {
    for (int i = 0; i < _selectedItems.length; i++) {
      int tmpId =
          defaultListCategory.elementAt(_selectedItems.elementAt(i)).idCategory;
      loadDataUser.loadUserCategoryToDB(finalName, tmpId);
    }
    loadDataUser.getUserCategoryFromDB(finalName);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  addUserCategory();
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black),
              ),
              Text(
                'Seleziona categoria',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
          backgroundColor: Colors.purple[300],
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return Divider(
              height: 5,
            );
          },
          itemCount: defaultListCategory.length,
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      defaultListCategory.elementAt(index).nameCategory,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
