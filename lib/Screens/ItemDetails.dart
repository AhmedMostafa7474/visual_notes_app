import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visual_notes_app/Data/Models/Visual_item.dart';

class ItemDetails extends StatefulWidget {
  VisualItem item;
  ItemDetails(this.item);

  @override
  _ItemDetailsState createState() => _ItemDetailsState(item);
}

class _ItemDetailsState extends State<ItemDetails> {
  VisualItem item;

  _ItemDetailsState(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                item.id
                , style: TextStyle(color: Colors.white),
              ),
              background: Hero(
                tag: item.id,
                child:item.picture.contains("assets")?Image.asset(item.picture,fit: BoxFit.cover,): Image.file(File(item.picture),fit: BoxFit.cover,),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.all(12.0),
              color: Colors.grey[900],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Title : ", style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),),
                      Text(item.title, style: TextStyle(color: Colors.white70,
                          fontSize: 15),),
                    ],
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    children: [
                      Text("Date : ", style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                      Text(item.date, style: TextStyle(color: Colors.white70,
                          fontSize: 15)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text("Status : ", style: TextStyle(color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                      Text(item.status, style: TextStyle(color: Colors.white70,
                          fontSize: 15)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text("Description : ", style: TextStyle(color: Colors
                          .white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Text(item.description, style: TextStyle(color: Colors
                            .white70,
                            fontSize: 15)),
                      ),
                    ],
                  ),
                  TextButton(onPressed: () async {
                    Navigator.pushNamed(context, "AddItem",arguments: item);
                  }, child: Text("Update",style: TextStyle(color:Colors.white),),style: TextButton.styleFrom(
                      backgroundColor: Colors.blue
                  )),
                ],
              ),
            ),
            Container(color: Colors.grey[900], height: 250)
          ],))
        ],
      ),
    );
  }
}
