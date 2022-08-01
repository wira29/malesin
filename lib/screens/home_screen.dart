import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:malesin/commons/navigation.dart';
import 'package:malesin/commons/style.dart';
import 'package:malesin/data/bloc/assignment/assignment_bloc.dart';
import 'package:malesin/data/bloc/schedule/schedule_bloc.dart';
import 'package:malesin/data/models/assignment.dart';
import 'package:malesin/screens/detail_assignment_screen.dart';

import '../widgets/assignment_item.dart';
import '../widgets/timeline_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cMapel = TextEditingController(),
      cTitle = TextEditingController(),
      cDesc = TextEditingController(),
      cDl = TextEditingController();

  @override
  void initState() {
    loadData();

    super.initState();
  }

  void loadData() {
    DateTime now = DateTime.now();
    context.read<ScheduleBloc>().add(getSchedule(now.weekday - 1));
    context.read<AssignmentBloc>().add(getAssignment());
  }

  void submitAssignment() {
    context.read<AssignmentBloc>().add(insertAssignment(Assignment.toInsert(
        mapel: cMapel.text,
        title: cTitle.text,
        desc: cDesc.text,
        status: "belum",
        dl: cDl.text)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "malesin.",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                          Text(
                            "atur tugasmu agar tidak terlewat",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    Text(
                      "Jadwal Hari Ini",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: BlocBuilder<ScheduleBloc, ScheduleState>(
                        builder: (context, state) {
                          if (state is ScheduleLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ScheduleNoData) {
                              return Center(
                                child: Container(
                                  child: Image.asset('assets/noSchedule.png', width: 150, height: 150,),
                                ),
                              );
                          }else if (state is ScheduleSingleData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: state.schedule
                                  .asMap()
                                  .entries
                                  .map(
                                    (entries) => TimelineItem(
                                        title: entries.value.title,
                                        time:
                                            "${entries.value.start} - ${entries.value.end}",
                                        isFirst:
                                            (entries.key == 0) ? true : false,
                                        isLast: (entries.key ==
                                                state.schedule.length - 1)
                                            ? true
                                            : false),
                                  )
                                  .toList(),
                            );
                          } else {
                            return const Center(
                              child: Text("Error..."),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Tugas",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: BlocBuilder<AssignmentBloc, AssignmentState>(
                          builder: (context, state) {
                            if (state is AssignmentLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is AssignmentNoData) {
                              return Center(
                                child: Container(
                                  child: Image.asset('assets/noAssignment.png', width: 150, height: 150,),
                                ),
                              );
                            } else if (state is AssignmentData) {
                              return ListView.builder(
                                padding: const EdgeInsets.only(top: 0),
                                itemCount: state.assignment.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigation.intentWithData(
                                          DetailAssignmentScreen.routeName,
                                          state.assignment[index]);
                                    },
                                    child: AssignmentItem(
                                        mapel: state.assignment[index].mapel,
                                        title: state.assignment[index].title,
                                        desc: state.assignment[index].desc,
                                        status: state.assignment[index].status,
                                        dl: state.assignment[index].dl),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text("Error..."),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 30,
              child: GestureDetector(
                onTap: () => _showInsertAssignmentDialog(
                    context, cMapel, cTitle, cDesc, cDl, submitAssignment),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _showInsertAssignmentDialog(
    context, cMapel, cTitle, cDesc, cDl, submitAssignment) {
  void clearController() {
    cMapel.clear();
    cTitle.clear();
    cDesc.clear();
    cDl.clear();
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Tambah Tugas',
          style: Theme.of(context).textTheme.headline4,
        ),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: cMapel,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'mapel...',
                    labelText: 'Mapel',
                  ),
                ),
                TextFormField(
                  controller: cTitle,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'tugas...',
                    labelText: 'Tugas',
                  ),
                ),
                TextFormField(
                  controller: cDesc,
                  style: const TextStyle(color: Colors.black),
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'deskripsi...',
                    labelText: 'Deskripsi',
                  ),
                ),
                DateTimeField(
                  controller: cDl,
                  style: const TextStyle(color: Colors.black),
                  format: DateFormat("dd-MM-yyyy"),
                  decoration: const InputDecoration(
                    hintText: 'batas tanggal...',
                    labelText: 'Batas Tanggal',
                  ),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'Tutup'),
              clearController(),
            },
            child: const Text('Tutup'),
          ),
          TextButton(
            onPressed: () => {
              submitAssignment(),
              Navigator.pop(context, 'Simpan'),
              context.read<AssignmentBloc>().add(getAssignment()),
              clearController(),
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  );
}
