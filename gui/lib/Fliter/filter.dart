import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gui/dibzznotifier.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
   CollectionReference? items;
  var db = FirebaseFirestore.instance;

   FilterPage({super.key}){
     items = db.collection('dibs');
  }

  @override
  State<StatefulWidget> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
 
  
   
  
  var index = 0;
  var currentCategories = "Tvs";
  List<String> categories = ["Tvs", "Furniture", "Appliances", "Couches"];
  TextEditingController rangeController = TextEditingController();

  void goToSettings() {
    setState(() {
      index = 1;
    });
  }

  void goToItems() {
    setState(() {
      index = 0;
    });
  }

  List<String> getCategories() {
    categories = Provider.of<DibzzNotifier>(context, listen: false).categories;
    return categories;
  }

  String getCurrentCategory() {
    return Provider.of<DibzzNotifier>(context, listen: false).currentCategory;
  }

  Widget getWidget() {
    if (index == 0) {
      return Column(children: [
     StreamBuilder(
              stream: widget.items!.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Hang on");
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) =>  ListTile(
                              title: Text(snapshot.data!.docs[index]["name"]),
                              subtitle: Text(snapshot.data!.docs[index]["category"] + ", " + 
                              snapshot.data!.docs[index]["description"] + ", "+ 
                              snapshot.data!.docs[index]["lat"].toString() + ", " +
                              snapshot.data!.docs[index]["long"].toString()),
                            )));
              },
            )]);
    } else {
      currentCategories = getCurrentCategory();
      categories = getCategories();
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: ElevatedButton(
              onPressed: goToItems, 
              child: const Text("Go Back"))),
          Flexible(
            child: TextField(
              decoration: const InputDecoration(label: Text("Range"), hintText: "in Miles"),
              
              controller: rangeController,
            )
          ),
          Row(
            children: [
              const Text("Select Category:"),
              DropdownButton<String>(
                value: currentCategories, //the default string that is shown
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    Provider.of<DibzzNotifier>(context, listen: false).currentCategory = value!;
                  });
                },
                items: categories.map<DropdownMenuItem<String>>((String value) { //displays all the categories
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              )
            ],
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getWidget();
  }
}



