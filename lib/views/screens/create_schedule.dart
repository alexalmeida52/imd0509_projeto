import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/consult_controller.dart';
import 'package:imd0509_projeto/models/consultas.dart';
import 'package:imd0509_projeto/models/doctor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateSchedule extends StatefulWidget {
  
  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  final now = DateTime.now();
  late BookingService mockBookingService;
  Doctor? doctor = null;

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay
    mockBookingService = BookingService(
        serviceName: 'Mock Service',
        serviceDuration: 30,
        bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
        bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
    Consulta consulta = new Consulta(data: newBooking.bookingStart, doctor: doctor!);
    Provider.of<ConsultController>(context, listen: false).addConsult(consulta);
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    DateTime first = now;
    DateTime second = now.add(Duration(minutes: 55, hours: 2));
    DateTime third = now.subtract(Duration(minutes: 240));
    DateTime fourth = now.subtract(Duration(minutes: 500));
    converted
        .add(DateTimeRange(start: first, end: now.add(Duration(minutes: 60))));
    converted.add(
        DateTimeRange(start: second, end: second.add(Duration(minutes: 23))));
    converted.add(
        DateTimeRange(start: third, end: third.add(Duration(minutes: 15))));
    converted.add(
        DateTimeRange(start: fourth, end: fourth.add(Duration(minutes: 50))));
    return converted;
  }

  @override
  Widget build(BuildContext context) {
    ScrollPhysics physics = const BouncingScrollPhysics();
    doctor = ModalRoute.of(context)?.settings.arguments as Doctor;
    return Scaffold(
      appBar: AppBar(title: Text('Agendar consulta ${doctor!.name}')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Text(
            'Selecione data e horário',
            style:
                TextStyle(color: Color.fromRGBO(28, 45, 62, 1), fontSize: 26),
          ),
          Expanded(
            child: BookingCalendar(
              bookingService: mockBookingService,
              convertStreamResultToDateTimeRanges: convertStreamResultMock,
              getBookingStream: getBookingStreamMock,
              uploadBooking: uploadBookingMock,
              bookedSlotText: 'Indisponível',
              selectedSlotText: 'Selecionado',
              availableSlotText: 'Disponível',
              bookingButtonText: 'Agendar',
              gridScrollPhysics: physics,
            ),
          )
        ]),
      ),
    );
  }
}
