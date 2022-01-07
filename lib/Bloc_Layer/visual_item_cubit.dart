import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:visual_notes_app/Data/Models/Visual_item.dart';
import 'package:visual_notes_app/Data/Repo/DatabaseRepo.dart';

part 'visual_item_state.dart';

class VisualItemCubit extends Cubit<VisualItemState> {
  final DatabaseRepo databaseRepo;
  List<VisualItem>visualItems=[];
  VisualItemCubit(this.databaseRepo) : super(VisualItemInitial());

  Future<List<VisualItem>> retrieveItems() async {
    visualItems=await databaseRepo.retrieveItems();
    emit(VisualItemLoaded(visualItems));
    return visualItems;
  }
  Future<void> insertItem(VisualItem visualItem) async {
    await databaseRepo.insertItem(visualItem);
    emit(VisualItemInserted());
    await retrieveItems();
  }
  Future<void> deleteItem(String id) async {
    await databaseRepo.deleteItem(id);
    emit(VisualItemDeleted());
    await retrieveItems();
  }
  Future<void> updateItem (Map<String, dynamic> row ,id) async {
    await databaseRepo.updateItem(row,id);
    emit(VisualItemUpdated());
    await retrieveItems();
  }
}


