import 'dart:convert';


class VisualItem {
  VisualItem({
    required  this.id,
    required  this.title,
    required  this.picture,
    required  this.date,
    required  this.description,
    required  this.status,
  });

  String id;
  String title;
  String picture;
  String date;
  String description;
  String status;

  factory VisualItem.fromJson(Map<String, dynamic> json) => VisualItem(
    id: json["id"],
    title: json["title"],
    picture: json["picture"],
    date: json["date"],
    description: json["description"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "picture": picture,
    "date": date,
    "description": description,
    "status": status,
  };
}
VisualItem visualItemFromJson(String str) => VisualItem.fromJson(json.decode(str));

String visualItemToJson(VisualItem data) => json.encode(data.toJson());
