import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/booking_provider.dart';
import '../../providers/events_state.dart';
import '../../providers/user_provider.dart';
import '../widgets/book_widgets/date_checker.dart';
import '../widgets/book_widgets/date_picker_widget.dart';

class BookPage extends StatefulWidget {
  final DocumentReference unitRef;
  const BookPage({Key key, this.unitRef}) : super(key: key);
  @override
  _BookPageState createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _controller = CalendarController();

  @override
  Widget build(BuildContext context) {
    final eventState = Provider.of<EventState>(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF0077b6),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF0077b6),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Color(0xFF0077b6),
                child: TableCalendar(
                  calendarController: _controller,
                  events: eventState.events,
                  weekendDays: [DateTime.friday, DateTime.saturday],
                  availableGestures: AvailableGestures.horizontalSwipe,
                  headerStyle: HeaderStyle(
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                      formatButtonTextStyle:
                          const TextStyle(color: Colors.white),
                      titleTextStyle: const TextStyle(color: Colors.white)),
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: const TextStyle(color: Color(0xFF023e8a)),
                      weekdayStyle: const TextStyle(color: Colors.white)),
                  calendarStyle: CalendarStyle(
                    weekdayStyle: const TextStyle(color: Colors.white),
                    weekendStyle: const TextStyle(color: Color(0xFF023e8a)),
                    outsideWeekendStyle:
                        const TextStyle(color: Color(0xFF001233)),
                    todayColor: Colors.amber[400],
                    markersColor: Color(0xFF001233),
                    selectedColor: Colors.amber[800],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: Container(
                  height: height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(color: Color(0xFF023E8A)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 1,
                              child: DatePicker(
                                pickType: 'From',
                                scaffoldkey: scaffoldKey,
                                unitRef: widget.unitRef,
                              )),
                          Expanded(
                              flex: 1,
                              child: DatePicker(
                                pickType: 'To',
                                scaffoldkey: scaffoldKey,
                                unitRef: widget.unitRef,
                              ))
                        ],
                      ),
                      DateChecker(),
                      RaisedButton(
                        color: Color(0xFF023E8A),
                        textColor: Color(0xFFCAF0F8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        visualDensity: VisualDensity(
                            horizontal: VisualDensity.maximumDensity),
                        onPressed: () {
                          final state = context.read<BookState>();
                          state.checkIfAvailable(
                              context.read<UserProvider>().user.phoneNumber,
                              widget.unitRef,
                              scaffoldKey,
                              context);
                          state.endDate = null;
                          state.startDate = null;
                        },
                        child: Text('استمرار'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
