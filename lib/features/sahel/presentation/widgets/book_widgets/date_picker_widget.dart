import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sahel/features/sahel/providers/booking_provider.dart';

class DatePicker extends StatelessWidget {
  final String pickType;
  final DocumentReference unitRef;
  final GlobalKey<ScaffoldState> scaffoldkey;
  const DatePicker({Key key, this.pickType, this.scaffoldkey, this.unitRef})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final dateProvider = Provider.of<BookState>(context);
    final startDate = dateProvider.startDate?.toString()?.substring(1, 10);
    final endDate = dateProvider.endDate?.toString()?.substring(1, 10);
    return Container(
      height: (height * 0.1),
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: Text(
                '$pickType',
                style: TextStyle(color: Color(0xFF0096C7)),
              )),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: InkWell(
                onTap: () async => await dateProvider.pickDate(
                  context,
                  pickType == 'From' ? true : false,
                  scaffoldkey,
                ),
                child: Container(
                  width: width * 0.4,
                  color: Colors.black12,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: Text(
                      pickType == 'From' ? (startDate ?? '') : (endDate ?? ''),
                      style: TextStyle(color: Color(0xFF023e8a)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
