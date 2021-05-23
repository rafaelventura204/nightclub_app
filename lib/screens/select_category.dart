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
                  addUserCategory();
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
                    Text('$index'),
                    Text(defaultListCategory.elementAt(index).nameCategory),
                    Text('${defaultListCategory.elementAt(index).idCategory}'),
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
