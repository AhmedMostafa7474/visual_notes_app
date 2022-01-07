part of 'visual_item_cubit.dart';

@immutable
abstract class VisualItemState {}

class VisualItemInitial extends VisualItemState {}
class VisualItemLoaded extends VisualItemState {
  final List<VisualItem> visualItem;
  VisualItemLoaded(this.visualItem);

}
class VisualItemInserted extends VisualItemState {}
class VisualItemDeleted extends VisualItemState {}
class VisualItemUpdated extends VisualItemState {}