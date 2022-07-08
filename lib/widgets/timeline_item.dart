import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malesin/commons/style.dart';
import 'package:malesin/data/bloc/schedule/schedule_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineItem extends StatelessWidget {
  TimelineItem(
      {required this.title,
      required this.time,
      required this.isFirst,
      required this.isLast,
      this.id = 0,
      this.isDelete = false,
      Key? key})
      : super(key: key);
  String title = "", time = "";
  int id;
  bool isFirst = true, isLast = false, isDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TimelineTile(
        alignment: TimelineAlign.start,
        isFirst: isFirst,
        isLast: isLast,
        afterLineStyle: LineStyle(
          thickness: 1,
        ),
        beforeLineStyle: LineStyle(
          thickness: 1,
        ),
        indicatorStyle: IndicatorStyle(
          width: 16,
          height: 16,
          color: primaryColor,
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    time,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              (isDelete)
                  ? InkWell(
                      onTap: () {
                        _showDeleteDialog(context, id);
                      },
                      child: Icon(
                        Icons.delete_outline,
                        color: textDanger,
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _showDeleteDialog(context, id) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Konfirmasi',
          style: Theme.of(context).textTheme.headline4,
        ),
        content: Text(
          "Apakah anda yakin ingin menghapus ?",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'Tutup'),
            },
            child: const Text(
              'Tutup',
              style: TextStyle(color: textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => {
              context.read<ScheduleBloc>().add(deleteSchedule(id)),
              Navigator.pop(context, "Hapus"),
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Berhasil menghapus jadwal !"))),
              context.read<ScheduleBloc>().add(getScheduleList()),
            },
            child: const Text(
              'Hapus',
              style: TextStyle(color: textDanger),
            ),
          ),
        ],
      );
    },
  );
}
