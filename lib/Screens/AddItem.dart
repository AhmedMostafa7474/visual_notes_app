import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visual_notes_app/Bloc_Layer/visual_item_cubit.dart';
import 'package:visual_notes_app/Data/Models/Visual_item.dart';

import '../Utility.dart';

class AddItem extends StatefulWidget {
  VisualItem? item;
  AddItem(this.item);

  @override
  _AddItemState createState() => _AddItemState(item);
}

class _AddItemState extends State<AddItem> {
  var uuid = Uuid();
  late TextEditingController Idcontroller;
  late TextEditingController Titlecontroller;
  late TextEditingController Datecontroller;
  late TextEditingController Statuscontroller;
  late TextEditingController Descriptioncontroller;
   File? _image;
  final ImagePicker _picker = ImagePicker();
  String imgString="";
  VisualItem? item;
  _AddItemState(this.item);

  @override
  void initState() {
    // TODO: implement initState
    Idcontroller = TextEditingController();
    Titlecontroller = TextEditingController();
    Datecontroller = TextEditingController();
    Statuscontroller = TextEditingController();
    Descriptioncontroller = TextEditingController();
    if(item!=null)
      {
        Idcontroller.text=item!.id;
        Titlecontroller.text=item!.title;
        Statuscontroller.text=item!.status;
        Descriptioncontroller.text=item!.description;
        Datecontroller.text=item!.date;
        _image=File(item!.picture);
      }
    super.initState();
  }

  Column TextFieldForm(title, controller, IconData icon) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 15.0),
        ),
        TextField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: title,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screen.height * 0.1,
                    horizontal: screen.width * 0.1),
                child: Column(children: [
                  Center(
                    child: Text("Item Form"),
                  ),
                  SizedBox(height: 20.0),
                  TextFieldForm(
                      "ID", Idcontroller, CupertinoIcons.profile_circled),
                  SizedBox(
                    height: 12,
                  ),
                  TextFieldForm(
                      "Title", Titlecontroller, CupertinoIcons.profile_circled),
                  SizedBox(
                    height: 12,
                  ),
                  TextFieldForm(
                      "Date", Datecontroller, CupertinoIcons.profile_circled),
                  SizedBox(
                    height: 12,
                  ),
                  TextFieldForm(
                      "Status", Statuscontroller, CupertinoIcons.profile_circled),
                  SizedBox(
                    height: 12,
                  ),
                  TextFieldForm("Description", Descriptioncontroller,
                      CupertinoIcons.profile_circled),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text("Photo : ",style: TextStyle(
                        color: Colors.black,fontSize: 20
                      ),),
                      SizedBox(width: 20,),
                      InkWell(
                          child: Center(
                            child:_image!=null? Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: FileImage(_image!) ,
                                    fit: BoxFit.fill,),
                              ),
                            ):Icon(Icons.add_a_photo,size: 35,),
                          ),
                          onTap: () async {
                            final PickedFile? image =
                                await _picker.getImage(source: ImageSource.camera);
                            var img = File(image!.path);
                             //imgString = Utility.base64String(img.readAsBytesSync());

                            Directory dir = await getApplicationDocumentsDirectory();
                            final String path = dir.path;
                            var newimage=await img.copy("$path/${uuid.v4()}.jpg");
                            setState(() {
                              _image = newimage;
                            });
                          }),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Center(
                      child: SizedBox(
                          height: 50,
                          width: 150,
                          child: TextButton(
                              child: Text("Add/Update",style: TextStyle(color: Colors.white),),
                              style: TextButton.styleFrom(
                                  backgroundColor: CupertinoColors.activeBlue),
                              onPressed: () async {
                                if (Idcontroller.text.isEmpty ||
                                    Descriptioncontroller.text.isEmpty ||
                                    Titlecontroller.text.isEmpty ||
                                    Datecontroller.text.isEmpty ||
                                    Statuscontroller.text.isEmpty ) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Check Info !")));
                                } else {
                                  if(item==null) {
                                    await BlocProvider.of<VisualItemCubit>(
                                        context)
                                        .insertItem(VisualItem(
                                        id: Idcontroller.text,
                                        title: Titlecontroller.text,
                                        picture: _image!.path,
                                        date: Datecontroller.text,
                                        description:
                                        Descriptioncontroller.text,
                                        status: Statuscontroller.text));
                                  }
                                  else
                                    {
                                      await BlocProvider.of<VisualItemCubit>(context).updateItem(VisualItem(
                                          id: Idcontroller.text,
                                          title: Titlecontroller.text,
                                          picture: _image!.path,
                                          date: Datecontroller.text,
                                          description:
                                          Descriptioncontroller.text,
                                          status: Statuscontroller.text).toJson(), Idcontroller.text);
                                    }
                                  Navigator.pushNamed(context, "/");
                                }
                              })))
                ]))));
  }
}
