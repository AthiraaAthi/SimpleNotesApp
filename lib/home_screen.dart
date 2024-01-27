import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:self_hive/home_screen_widget.dart';
import 'package:self_hive/model/my_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController edittitleController = TextEditingController();
  TextEditingController editdesController = TextEditingController();
  TextEditingController editdateController = TextEditingController();
  var box = Hive.box<MyModel>("MyHive");
  var keyList = [];

  @override
  void initState() {
    keyList = box.keys.toList();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("My Notes", style: GoogleFonts.salsa(color: Colors.black)),
      ),
      body: ListView.builder(
        itemCount: keyList.length,
        itemBuilder: (context, index) => HomeScreenWidget(
          title: box.get(keyList[index])!.title,
          description: box.get(keyList[index])!.description,
          date: box.get(keyList[index])!.date,
          onDeleteTap: () {
            box.delete(keyList.removeAt(index));
            setState(() {});
          },
          onEditTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, insetState) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: edittitleController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "Title"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: editdesController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "Description"),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: editdateController,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        print("picked Date:$pickedDate");
                                        String formattedDate =
                                            DateFormat("yyyy-MM-dd")
                                                .format(pickedDate);
                                        print("formatted Date:$formattedDate");
                                        setState(() {
                                          editdateController.text =
                                              formattedDate;
                                        });
                                      }
                                    },
                                    icon: Icon(Icons.calendar_month),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "Date"),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            IconButton(
                              onPressed: () {
                                box.put(
                                    keyList[index],
                                    MyModel(
                                        title: edittitleController.text,
                                        description: editdesController.text,
                                        date: editdateController.text));
                                setState(() {});
                                keyList = box.keys.toList();
                                print("edited keylist:- $keyList");
                                edittitleController.clear();
                                editdesController.clear();
                                editdateController.clear();
                                Navigator.pop(context);
                                if (edittitleController.text.isEmpty ||
                                    editdesController.text.isEmpty ||
                                    editdateController.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      "you're not filling all ?",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    backgroundColor: Colors.white,
                                    action: SnackBarAction(
                                        label: "Ok",
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ));
                                }
                              },
                              icon: Icon(
                                Icons.done,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: " title"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: desController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: " description"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: " Date",
                          suffixIcon: IconButton(
                            onPressed: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));
                              if (pickedDate != null) {
                                print("picked Date:$pickedDate");
                                String formattedDate =
                                    DateFormat("yyyy-MM-dd").format(pickedDate);
                                print("formatted Date:$formattedDate");
                                setState(() {
                                  dateController.text = formattedDate;
                                });
                              } else {
                                SnackBar(
                                  content: Text("Select Date"),
                                );
                              }
                            },
                            icon: Icon(Icons.calendar_month),
                          ),
                        ),
                        //readOnly: true,
                        // onTap: () async {
                        //   DateTime? pickedDate = await showDatePicker(
                        //       context: context,
                        //       initialDate: DateTime.now(),
                        //       firstDate: DateTime(2000),
                        //       lastDate: DateTime(2101));
                        //   if (pickedDate != null) {
                        //     print("picked Date:$pickedDate");
                        //     String formattedDate =
                        //         DateFormat("yyyy-MM-dd").format(pickedDate);
                        //     print("formatted Date:$formattedDate");
                        //     setState(() {
                        //       dateController.text = formattedDate;
                        //     });
                        //   } else {
                        //     SnackBar(
                        //       content: Text("Select Date"),
                        //     );
                        //   }
                        // },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     Container(
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           color: Color.fromARGB(255, 199, 77, 69),
                      //           borderRadius: BorderRadius.circular(10)),
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //     Container(
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           color: Color.fromARGB(255, 126, 168, 231),
                      //           borderRadius: BorderRadius.circular(10)),
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //     Container(
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           color: Color.fromARGB(255, 100, 226, 115),
                      //           borderRadius: BorderRadius.circular(10)),
                      //     ),
                      //     SizedBox(
                      //       width: 15,
                      //     ),
                      //     Container(
                      //       height: 50,
                      //       width: 50,
                      //       decoration: BoxDecoration(
                      //           color: Color.fromARGB(255, 158, 85, 218),
                      //           borderRadius: BorderRadius.circular(10)),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      IconButton(
                          onPressed: () {
                            box.add(MyModel(
                                title: titleController.text.trim(),
                                description: desController.text.trim(),
                                date: dateController.text.trim()));

                            keyList = box.keys.toList();
                            setState(() {});
                            titleController.clear();
                            dateController.clear();
                            desController.clear();
                            Navigator.pop(context);
                            if (titleController.text.isEmpty ||
                                desController.text.isEmpty ||
                                dateController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  "you're not filling all ?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.white,
                                action: SnackBarAction(
                                    label: "Ok",
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ));
                            }
                          },
                          icon: Icon(
                            Icons.done,
                            size: 35,
                          ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 35,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
