import 'package:clinic_app/models/appointments_model.dart';
import 'package:clinic_app/models/users_model.dart';
import 'package:clinic_app/providers.dart';
import 'package:clinic_app/services/user_services.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/all.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;

  Map<DateTime, List> _events = {};
  List<Appointment> _selectedEvents = [];

  @override
  void initState() {
    _calendarController = CalendarController();
    _selectedEvents = List<Appointment>();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    loadEvents();

    super.initState();
  }

  loadEvents() async {
    final uid = FirebaseAuth.instance.currentUser.uid;
    _events = await context.read(appointmentRepository).getEvents(uid);
    setState(() {});
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {});
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    _selectedEvents = List<Appointment>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [Colors.blueGrey[100], Colors.blueGrey[700]]),
            ),
          ),
          Positioned(
            right: 20,
            top: 200,
            child: Image.asset(
              'assets/images/logo.png',
              color: Colors.black12,
              height: 700,
            ),
          ),
          Positioned(
            top: 25,
            left: 5,
            child: IconButton(
                icon: Icon(FontAwesomeIcons.chevronCircleLeft,
                    size: 25, color: Colors.blueGrey[500]),
                onPressed: () => Navigator.of(context).pop()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(14),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TableCalendar(
                      calendarController: _calendarController,
                      events: _events,
                      initialCalendarFormat: CalendarFormat.twoWeeks,
                      formatAnimation: FormatAnimation.slide,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      availableGestures: AvailableGestures.all,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month',
                        CalendarFormat.week: 'Week',
                        CalendarFormat.twoWeeks: '2 weeks',
                      },
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: true,
                        weekendStyle:
                            TextStyle().copyWith(color: Colors.red[600]),
                        holidayStyle:
                            TextStyle().copyWith(color: Colors.blue[800]),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekendStyle:
                            TextStyle().copyWith(color: Colors.blue[600]),
                      ),
                      headerStyle: HeaderStyle(
                        centerHeaderTitle: true,
                        formatButtonVisible: true,
                      ),
                      builders: CalendarBuilders(
                        selectedDayBuilder: (context, date, _) {
                          return FadeTransition(
                            opacity: Tween(begin: 0.0, end: 1.0)
                                .animate(_animationController),
                            child: Container(
                              margin: const EdgeInsets.all(4.0),
                              padding:
                                  const EdgeInsets.only(top: 5.0, left: 6.0),
                              color: Colors.blueGrey[200],
                              width: 100,
                              height: 100,
                              child: Text(
                                '${date.day}',
                                style: TextStyle().copyWith(fontSize: 16.0),
                              ),
                            ),
                          );
                        },
                        todayDayBuilder: (context, date, _) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                            color: Colors.blueGrey[100],
                            width: 100,
                            height: 100,
                            child: Text(
                              '${date.day}',
                              style: TextStyle().copyWith(fontSize: 16.0),
                            ),
                          );
                        },
                        markersBuilder: (context, date, events, holidays) {
                          final children = <Widget>[];

                          if (events.isNotEmpty) {
                            children.add(
                              Positioned(
                                right: 1,
                                bottom: 1,
                                child: _buildEventsMarker(date, events),
                              ),
                            );
                          }

                          if (holidays.isNotEmpty) {
                            children.add(
                              Positioned(
                                right: -2,
                                top: -2,
                                child: _buildHolidaysMarker(),
                              ),
                            );
                          }

                          return children;
                        },
                      ),
                      onDaySelected: (date, events, holidays) {
                        _animationController.forward(from: 0.0);
                        List<Appointment> lista;
                        if (events.isNotEmpty) {
                          lista = events;
                        }
                        setState(() {
                          _selectedEvents = lista;
                        });

                        _onDaySelected(date, events, holidays);
                      },
                      onVisibleDaysChanged: _onVisibleDaysChanged,
                      onCalendarCreated: _onCalendarCreated,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                (_selectedEvents == null || _selectedEvents.isEmpty)
                    ? Text('No appointments', style: TextStyle(fontSize: 15))
                    : Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return Divider(
                              thickness: 1,
                            );
                          },
                          itemCount: _selectedEvents.length,
                          itemBuilder: (context, index) {
                            return Consumer(
                              builder: (context, watch, child) {
                                final getPatient = watch(
                                    getUserByIdFutureProvider(
                                        _selectedEvents[index].idPatient));

                                return getPatient.when(
                                  loading: () => Container(),
                                  error: (error, stack) =>
                                      BuildAppointmentDetailError(error),
                                  data: (myUser) => BuildAppointmentDetail(
                                      myUser, _selectedEvents[index]),
                                );
                              },
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.black
            : _calendarController.isToday(date)
                ? Colors.yellow[300]
                : Colors.blue[400],
      ),
      width: 18.0,
      height: 18.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 10.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }
}

class BuildAppointmentDetail extends StatelessWidget {
  final MyUser myUser;
  final Appointment appointment;
  const BuildAppointmentDetail(this.myUser, this.appointment);
  @override
  Widget build(BuildContext context) {
    String hora = formatDate(appointment.date, [HH, ':', nn]);
    return Stack(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/appointment-detail',
                arguments: appointment.idAppointment);
          },
          title: Text(
            '${myUser.firstName} ${myUser.lastName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${appointment.reason}'),
              (appointment.completed)
                  ? Text(
                      'Closed',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.red,
                      ),
                    )
                  : Text('')
            ],
          ),
          trailing: Text('$hora'),
        ),
      ],
    );
  }
}

class BuildAppointmentDetailError extends StatelessWidget {
  final String error;
  const BuildAppointmentDetailError(this.error);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$error'),
    );
  }
}

class BuildAppointmentDetailLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
