import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visual_notes_app/Bloc_Layer/visual_item_cubit.dart';
import 'package:visual_notes_app/Data/LocalStorage/VisualItemStorage.dart';
import 'package:visual_notes_app/Data/Models/Visual_item.dart';
import 'package:visual_notes_app/Data/Repo/DatabaseRepo.dart';
import 'package:visual_notes_app/Screens/AddItem.dart';
import 'package:visual_notes_app/Screens/HomeScreen.dart';
import 'package:visual_notes_app/Screens/ItemDetails.dart';

class AppRouter {
  late DatabaseRepo databaseRepo;

  late VisualItemCubit _visualItemCubit;

  AppRouter() {
    databaseRepo = DatabaseRepo(DatabaseHandler());
    _visualItemCubit = VisualItemCubit(databaseRepo);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) =>
                BlocProvider(
                  create: (BuildContext context) => _visualItemCubit,
                  child: homeScreen(),
                ));
      case 'Item_details':
        final Item = settings.arguments as VisualItem;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
                create: (BuildContext context) => _visualItemCubit,
                child: ItemDetails(Item)
            ));
      case 'AddItem':
        final Item = settings.arguments as VisualItem?;
        return MaterialPageRoute(
            builder: (_) =>BlocProvider(
          create: (BuildContext context) => _visualItemCubit,
          child: AddItem(Item),
                ));
    }
  }
}
