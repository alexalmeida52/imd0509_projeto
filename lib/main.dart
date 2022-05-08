import 'package:flutter/material.dart';
import 'package:imd0509_projeto/screens/available_doctors.dart';
import 'package:imd0509_projeto/screens/login.dart';

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
        AppRoutes.HOME: (ctx) => MyHomePage(title: 'gfds',),
        AppRoutes.AVAILABLE_DOCTORS: (ctx) => AvailableDoctors(),
        AppRoutes.LOGIN: (ctx) => Login()
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
    AvailableDoctors(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex)
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
