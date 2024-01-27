import 'package:hive_flutter/adapters.dart';
part 'my_model.g.dart';

@HiveType(typeId: 1)
class MyModel {
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String date;

  MyModel({required this.title, required this.description, required this.date});
}
