import 'package:flutter/material.dart';
import 'package:malesin/commons/style.dart';

class AssignmentItem extends StatelessWidget {
  AssignmentItem(
      {Key? key,
      required this.mapel,
      required this.title,
      required this.status,
      required this.desc,
      required this.dl})
      : super(key: key);

  String mapel, title, status, desc, dl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${mapel} - ${title}",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 10,
                      color: textDanger,
                    ),
                  )
                ],
              ),
              Text(
                desc,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    dl,
                    style: TextStyle(
                      fontSize: 10,
                      color: textDanger,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
