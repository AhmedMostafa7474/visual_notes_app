import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes_app/Bloc_Layer/visual_item_cubit.dart';
import 'package:visual_notes_app/Data/LocalStorage/VisualItemStorage.dart';
import 'package:visual_notes_app/Data/Models/Visual_item.dart';

import '../Utility.dart';

class homeScreen extends StatefulWidget {
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  late DatabaseHandler handler;
  List<VisualItem> allItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initializeDB().whenComplete(() async {
      setState(() {});
      await BlocProvider.of<VisualItemCubit>(context).updateItem(
          VisualItem(
              id: "01",
              title: "Passed test",
              picture: "assets/Firstnote.jpg",
              date: "10/24/2019 12:01 PM",
              description:
              "Chair matches highlight and weight requirements",
              status: "Closed").toJson(),"01"
      );
    });
    Load();
  }

  @override
  void dispose() {
    BlocProvider.of<VisualItemCubit>(context).close();
    super.dispose();
  }

  Future<void> Load() async {
    await BlocProvider.of<VisualItemCubit>(context).retrieveItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "AddItem");
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Visual Items"),
        leading: Icon(Icons.home),
      ),
      body: BlocBuilder<VisualItemCubit, VisualItemState>(
        builder: (BuildContext context, state) {
          if (state is VisualItemLoaded) {
            allItems = (state).visualItem;
            if (allItems.isEmpty) {
              allItems.add(VisualItem(
                  id: "01",
                  title: "Passed test",
                  picture: "assets/Firstnote.jpg",
                  date: "10/24/2019 12:01 PM",
                  description:
                      "Chair matches highlight and weight requirements",
                  status: "Closed"));
            }
            return GridView.builder(
              itemCount: allItems.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 0.7,
                  mainAxisSpacing: 0.4),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, "Item_details",arguments: allItems[index]);
                  },
                  child: GridTile(
                    child: Hero(
                      tag: allItems[index].id,
                      child: Container(
                            height: 400,
                            width: 180,
                            //margin: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child:allItems[index].picture.contains("assets")?Image.asset(allItems[index].picture,fit: BoxFit.cover,):Image.file(File(allItems[index].picture),fit:BoxFit.cover)),
                      ),
                    footer: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          color: Colors.black54,
                          child: Text(
                            "ID : ${allItems[index].id}",
                            style: TextStyle(
                                height: 1.3,
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () async {
                        Navigator.pushNamed(context, "Item_details",arguments: allItems[index]);
                      }, child: Text("Details",style: TextStyle(color:Colors.white),),style: TextButton.styleFrom(
                          backgroundColor: Colors.blue
                      )),
                        SizedBox(width: 15,),
                      TextButton(onPressed: () async {
                        await BlocProvider.of<VisualItemCubit>(context).deleteItem(allItems[index].id);
                      }, child: Text("Remove",style: TextStyle(color:Colors.white),),style: TextButton.styleFrom(
                          backgroundColor: Colors.red
                      )),
                    ],
                  )
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
        },
      ),
    );
  }
}
