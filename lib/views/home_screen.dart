import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_exam/helpers/hive_helpers/hive_helpers.dart';
import 'package:todo_exam/models/hive_data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HiveDataModel> modelData = [];
  List<HiveDataModel> shortedModelData = [];

  //Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //name
  String? name;
  TextEditingController nameController = TextEditingController();
  //description
  String? description;
  TextEditingController descriptionController = TextEditingController(); //date
  //date
  DateTime? date;
  TextEditingController dateController = TextEditingController();
  // time
  TimeOfDay? time;
  TextEditingController timeController = TextEditingController();
  //priority
  int? priority;
  TextEditingController priorityController = TextEditingController();
  //status
  bool status = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    modelData = await HiveHelpers.getData();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO APP"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Task name",
                              ),
                              controller: nameController,
                              onSaved: (value) {
                                name = value;
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Enter the Task name...!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Task description",
                              ),
                              controller: descriptionController,
                              onSaved: (value) {
                                description = value;
                              },
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Enter the Task description...!";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              controller: dateController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Pick date...";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: date == null ? "Pick Date" : "$date",
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      date = (await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime.now()))!;

                                      dateController.text =
                                          "${date!.day} / ${date!.month} / ${date!.year}";
                                    },
                                    icon: Icon(Icons.calendar_month)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              readOnly: true,
                              controller: timeController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Pick Time...";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: time == null ? "Pick Time" : "$time",
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      time = (await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ));
                                      timeController.text =
                                          time!.format(context);
                                      print(timeController.text);
                                    },
                                    icon: Icon(Icons.timelapse_rounded)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter Todo priority ",
                              ),
                              controller: priorityController,
                              validator: (val) {
                                if (val == null) {
                                  return "Enter priority...!";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (newValue) {
                                priority = int.parse(newValue!);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Status :",
                                  style: TextStyle(fontSize: 20),
                                ),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      void Function(void Function()) setState) {
                                    return Switch(
                                        value: status,
                                        onChanged: (val) {
                                          setState(() {
                                            status = !status;
                                          });
                                        });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton.outlined(
                                          onPressed: () async {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Text(
                                                    "Data cleared Successfully"),
                                              ),
                                            );
                                            nameController.clear();
                                            descriptionController.clear();
                                            dateController.clear();
                                            priorityController.clear();
                                            timeController.clear();
                                            name = null;
                                            description = null;
                                            time = null;
                                            date = null;
                                            status = false;
                                            priority = null;

                                            await getData();
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.clear_rounded),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton.filled(
                                          onPressed: () async {
                                            if (formKey.currentState!
                                                    .validate() &&
                                                date != null) {
                                              formKey.currentState!.save();
                                              HiveDataModel data =
                                                  HiveDataModel(
                                                      name: name!,
                                                      description: description!,
                                                      date: date!,
                                                      time: timeController.text,
                                                      priority: priority!,
                                                      status: status);
                                              HiveHelpers.addData(data);
                                              nameController.clear();
                                              descriptionController.clear();
                                              dateController.clear();
                                              priorityController.clear();
                                              timeController.clear();
                                              name = null;
                                              description = null;
                                              time = null;
                                              date = null;
                                              status = false;
                                              priority = null;
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: Text(
                                                      "Data added Successfully"),
                                                ),
                                              );

                                              await getData();
                                              Navigator.pop(context);
                                            }
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
      body: modelData.isEmpty
          ? Center(
              child: Text("No Data Found...!"),
            )
          : ListView.builder(
              itemCount: modelData.length,
              itemBuilder: (context, index) {
                modelData.sort(
                  (a, b) {
                    return a.priority.compareTo(b.priority);
                  },
                );
                log("${modelData[index].priority}");
                return GestureDetector(
                  //update
                  onDoubleTap: () async {
                    nameController.text = modelData[index].name;
                    descriptionController.text = modelData[index].description;
                    timeController.text = modelData[index].time;
                    date = modelData[index].date;
                    dateController.text =
                        "${date!.day} / ${date!.month} / ${date!.year}";
                    priority = modelData[index].priority;
                    priorityController.text = priority.toString();
                    status = modelData[index].status;
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              key: formKey,
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Enter Task name",
                                        ),
                                        controller: nameController,
                                        onSaved: (value) {
                                          name = value;
                                        },
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Enter the Task name...!";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Enter Task description",
                                        ),
                                        controller: descriptionController,
                                        onSaved: (value) {
                                          description = value;
                                        },
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return "Enter the Task description...!";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: dateController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: date == null
                                              ? "Pick Date"
                                              : "$date",
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                date = (await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(2000),
                                                    lastDate: DateTime.now()))!;

                                                dateController.text =
                                                    "${date!.day} / ${date!.month} / ${date!.year}";
                                              },
                                              icon: Icon(Icons.calendar_month)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: timeController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: time == null
                                              ? "Pick Time"
                                              : "$time",
                                          suffixIcon: IconButton(
                                              onPressed: () async {
                                                time = (await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ));

                                                timeController.text =
                                                    time!.format(context);
                                              },
                                              icon: Icon(
                                                  Icons.timelapse_rounded)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        textInputAction: TextInputAction.done,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Enter Todo priority ",
                                        ),
                                        controller: priorityController,
                                        validator: (val) {
                                          if (val == null) {
                                            return "Enter priority...!";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onSaved: (newValue) {
                                          priority = int.parse(newValue!);
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Status :",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          StatefulBuilder(
                                            builder: (BuildContext context,
                                                void Function(void Function())
                                                    setState) {
                                              return Switch(
                                                  value: status,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      status = !status;
                                                    });
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    //update button
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton.icon(
                                            label: Text("Update"),
                                            onPressed: () async {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState!.save();
                                                HiveDataModel data =
                                                    HiveDataModel(
                                                        name: name!,
                                                        description:
                                                            description!,
                                                        date: date as DateTime,
                                                        time:
                                                            timeController.text,
                                                        priority: priority!,
                                                        status: status);
                                                await HiveHelpers.updateData(
                                                    index, data);
                                                nameController.clear();
                                                descriptionController.clear();
                                                dateController.clear();
                                                timeController.clear();
                                                priorityController.clear();
                                                name = null;
                                                description = null;
                                                time = null;
                                                date = null;
                                                priority = null;
                                                status = false;
                                              }
                                              await getData();
                                              setState(() {});
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.update_sharp),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
                  //delete
                  onLongPress: () async {
                    await HiveHelpers.deleteData(index);
                    await getData();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Data Deleted Successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text(
                          modelData[index].name,
                          style: TextStyle(
                              decoration: modelData[index].status == true
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough),
                        ),
                        subtitle: Text("${modelData[index].priority}"),
                        // trailing: ,
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
