import 'package:flutter/material.dart';
import 'package:malesin/commons/navigation.dart';
import 'package:malesin/commons/style.dart';
import 'package:malesin/data/bloc/assignment/assignment_bloc.dart';
import 'package:malesin/data/models/assignment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailAssignmentScreen extends StatefulWidget {
  static String routeName = "/detailAssignment";

  final Assignment data;
  const DetailAssignmentScreen({Key? key, required this.data})
      : super(key: key);

  @override
  State<DetailAssignmentScreen> createState() => _DetailAssignmentScreenState();
}

class _DetailAssignmentScreenState extends State<DetailAssignmentScreen> {
  void deleteAssignment(id) {}

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.data.mapel} - ${widget.data.title}",
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () =>
                                  _showDeleteDialog(context, widget.data.id),
                              child: Icon(
                                Icons.delete_outline,
                                color: textDanger,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          widget.data.status,
                          style: const TextStyle(color: textDanger),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Text(
                          widget.data.dl,
                          style: const TextStyle(color: textDanger),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      widget.data.desc,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              top: 32,
              child: InkWell(
                onTap: () => Navigation.back(),
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
            Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      _showCompleteDialog(context, widget.data.id);
                    },
                    child: const Text("Tandai Selesai"),
                  ),
                )),
          ],
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
              context.read<AssignmentBloc>().add(deleteAssignment(id)),
              Navigator.pop(context, "Hapus"),
              Navigation.back(),
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Berhasil menghapus tugas !"))),
              context.read<AssignmentBloc>().add(getAssignment()),
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

Future<void> _showCompleteDialog(context, id) {
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
          "Apakah tugas telah selesai ?",
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
              context.read<AssignmentBloc>().add(deleteAssignment(id)),
              Navigator.pop(context, "Selesai"),
              Navigation.back(),
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Berhasil menyelesaikan tugas !"))),
              context.read<AssignmentBloc>().add(getAssignment()),
            },
            child: const Text(
              'Selesai',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      );
    },
  );
}
