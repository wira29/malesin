import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:malesin/commons/style.dart';
import 'package:malesin/data/bloc/schedule/schedule_bloc.dart';
import 'package:malesin/data/models/listSchedule.dart';
import 'package:malesin/data/models/schedule.dart';
import 'package:malesin/widgets/timeline_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:select_form_field/select_form_field.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  void initState() {
    context.read<ScheduleBloc>().add(getScheduleList());
    print(cDay.text);
    super.initState();
  }

  void submitSchedule() {
    context.read<ScheduleBloc>().add(insertSchedule(Schedule.toInsert(
        title: cTitle.text,
        start: cStart.text,
        end: cEnd.text,
        day: (cDay.text != "") ? int.parse(cDay.text) : 0)));
  }

  TextEditingController cDay = TextEditingController(),
      cTitle = TextEditingController(),
      cStart = TextEditingController(),
      cEnd = TextEditingController();

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
                      "Jadwal",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: BlocBuilder<ScheduleBloc, ScheduleState>(
                        builder: (context, state) {
                          if (state is ScheduleLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is ScheduleData) {
                            return ListView.builder(
                              itemBuilder: (BuildContext context, int index) =>
                                  MyExpandableWidget(state.scheduleList[index],
                                      index, state.scheduleList),
                              itemCount: state.scheduleList.length,
                            );
                          } else {
                            return const Center(
                              child: Text("Error..."),
                            );
                          }
                        },
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
                onTap: () {
                  _showInsertScheduleDialog(
                      context, cDay, cTitle, cStart, cEnd, submitSchedule);
                },
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

class MyExpandableWidget extends StatelessWidget {
  final List<ListSchedule> data;
  final int idx;
  final ListSchedule listSchedule;
  final List<String> month = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu"
  ];

  MyExpandableWidget(this.listSchedule, this.idx, this.data);

  @override
  Widget build(BuildContext context) {
    if (listSchedule.schedules.length <= 0) {
      return ListTile(title: Text(month[listSchedule.idList]));
    } else {
      return ExpansionTile(
        key: PageStorageKey<ListSchedule>(listSchedule),
        title: Text(month[listSchedule.idList],
            style: Theme.of(context).textTheme.headline4),
        children: listSchedule.schedules
            .asMap()
            .entries
            .map<Widget>(
                (entry) => showMapel(entry, data[idx].schedules.length))
            .toList(),
      );
    }
  }
}

showMapel(MapEntry entry, int length) {
  Schedule schedule = entry.value;
  int idx = entry.key;
  return Padding(
    padding: const EdgeInsets.only(left: 32),
    child: TimelineItem(
      title: schedule.title,
      time: "${schedule.start} - ${schedule.end}",
      isFirst: (idx == 0) ? true : false,
      isLast: (idx == length - 1) ? true : false,
      id: schedule.id,
      isDelete: true,
    ),
  );
}

Future<void> _showInsertScheduleDialog(
    context, cDay, cTitle, cStart, cEnd, submitSchedule) {
  void clearController() {
    cDay.clear();
    cTitle.clear();
    cStart.clear();
    cEnd.clear();
  }

  final List<Map<String, dynamic>> _days = [
    {
      'value': '0',
      'label': 'Senin',
      'textStyle': TextStyle(color: Colors.black),
    },
    {
      'value': '1',
      'label': 'Selasa',
      'textStyle': TextStyle(color: Colors.black),
    },
    {
      'value': '2',
      'label': 'Rabu',
      'textStyle': TextStyle(color: Colors.black),
    },
    {
      'value': '3',
      'label': 'Kamis',
      'textStyle': TextStyle(color: Colors.black),
    },
    {
      'value': '4',
      'label': 'Jumat',
      'textStyle': TextStyle(color: Colors.black),
    },
    {
      'value': '5',
      'label': 'Sabtu',
      'textStyle': TextStyle(color: Colors.black),
    },
  ];

  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Tambah Jadwal',
          style: Theme.of(context).textTheme.headline4,
        ),
        content: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                SelectFormField(
                  onChanged: (val) => cDay.text = val,
                  style: const TextStyle(color: Colors.black),
                  initialValue: "0",
                  items: _days,
                  decoration: const InputDecoration(
                    hintText: 'hari...',
                    labelText: 'Hari',
                  ),
                ),
                TextFormField(
                  controller: cTitle,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: 'mapel...',
                    labelText: 'Mapel',
                  ),
                ),
                DateTimeField(
                  controller: cStart,
                  style: const TextStyle(color: Colors.black),
                  format: DateFormat("HH:mm"),
                  decoration: const InputDecoration(
                    hintText: 'mulai...',
                    labelText: 'Mulai',
                  ),
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
                  },
                ),
                DateTimeField(
                  controller: cEnd,
                  style: const TextStyle(color: Colors.black),
                  format: DateFormat("HH:mm"),
                  decoration: const InputDecoration(
                    hintText: 'selesai...',
                    labelText: 'Selesai',
                  ),
                  onShowPicker: (context, currentValue) async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.convert(time);
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
              submitSchedule(),
              Navigator.pop(context, 'Simpan'),
              context.read<ScheduleBloc>().add(getScheduleList()),
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Berhasil menambahkan jadwal !"))),
              clearController(),
            },
            child: const Text('Simpan'),
          ),
        ],
      );
    },
  );
}
