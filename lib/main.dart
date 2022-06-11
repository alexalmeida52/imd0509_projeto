import 'package:flutter/material.dart';
import 'package:imd0509_projeto/controllers/doctor_controller.dart';
import 'package:imd0509_projeto/models/doctor.dart';
import 'package:imd0509_projeto/views/components/main_drawer.dart';
import 'package:imd0509_projeto/views/screens/available_doctors.dart';
import 'package:imd0509_projeto/views/screens/create_schedule.dart';
import 'package:imd0509_projeto/views/screens/listaConsulta.dart';
import 'package:imd0509_projeto/views/screens/login.dart';
import 'package:imd0509_projeto/views/screens/manage_doctors.dart';
import 'package:imd0509_projeto/views/screens/profile_doctor.dart';
import 'package:provider/provider.dart';

import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myHealth',
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (ctx) => MyHomePage(title: 'myHealth',),
        AppRoutes.AVAILABLE_DOCTORS: (ctx) => AvailableDoctors(),
        AppRoutes.CREATE_SCHEDULE: (ctx) => CreateSchedule(),
        AppRoutes.LOGIN: (ctx) => Login(),
        AppRoutes.PROFILE_DOCTOR: (ctx) => ProfileDoctor(),
        AppRoutes.LISTA_CONSULTA: (ctx) => ConsultaMedica(),
        AppRoutes.GERRENCIAR_PROFISSIONAIS: (ctx) => ManageDoctors()
      },
      theme: ThemeData().copyWith(
          colorScheme: ThemeData()
          .colorScheme
          .copyWith(
              primary: Color.fromRGBO(65, 188, 89, 1),
              secondary: Color.fromRGBO(28, 45, 62, 1)
          ),
          textTheme: ThemeData().textTheme.copyWith(
            headline6: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 14
              )
            )
          ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    ChangeNotifierProvider(
      create: (context) => DoctorController(), 
      child: AvailableDoctors()
    ),
    ConsultaMedica(),
    Text(
      'Agendar',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getScreenName(int index) {
    switch (index) {
      case 0:
        return 'PESQUISAR';
      case 1:
        return 'MINHAS CONSULTAS';
      default:
        return 'DESCONHECIDO';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          title: Text(getScreenName(_selectedIndex), style: TextStyle(fontSize: 30),),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(65, 188, 89, 1),
          fixedColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Pesquisar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt),
              label: 'Consultas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        body: Center(
            child: _widgetOptions.elementAt(_selectedIndex)
            ), // This trailing comma makes auto-formatting nicer for build methods.
        drawer: MainDrawer()
      );
  }
}
