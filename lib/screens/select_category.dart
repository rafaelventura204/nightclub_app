import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  
  getCategories() async {
    PostgreSQLConnection connection;
    DBconnect dBconnect = DBconnect();
    Queries queries = Queries();

    connection = await dBconnect.dbConnect();

    List<List<dynamic>> results = await connection
        .query(queries.getCategoryQuery());

    for (final row in results) {      
      print(row);
    }

  }
  List<String> elements = [
    "Uno",
    "Due",
    "Tre",
    "Quatro",
    "Cinque",
    "Uno",
    "Due",
    "Tre",
    "Quatro",
    "Cinque",
    "Uno",
    "Due",
    "Tre",
    "Quatro",
    "Cinque",
    "Uno",
    "Due",
    "Tre",
    "Quatro",
    "Cinque",
    "Uno",
    "Due",
    "Tre",
    "Quatro",
    "Cinque",
    "Uno",
    "Due",
    "Tre",
    "boooo",
    "Cinque"
  ];
  List<int> _selectedItems = List<int>();

  @override
  Widget build(BuildContext context) {
    getCategories();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Seleziona categorie'),
          backgroundColor: Colors.purple[300],
        ),
        body: ListView.builder(
          itemCount: 31,
          itemBuilder: (context, index) {
            return Container(
              color: (_selectedItems.contains(index))
                  ? Colors.blue.withOpacity(0.5)
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
                title: Text(elements.elementAt(index)),
              ),
            );
          },
        ),
      ),
    );
  }
}
