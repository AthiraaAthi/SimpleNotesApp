import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:self_hive/model/my_model.dart';

class HomeScreenWidget extends StatelessWidget {
  var box = Hive.box<MyModel>("MyHive");
  HomeScreenWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      this.onEditTap,
      this.onDeleteTap});
  final String title;
  final String description;
  final String date;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: onEditTap,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          )),
                      IconButton(
                          onPressed: onDeleteTap,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                description,
                style: GoogleFonts.salsa(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    date,
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
