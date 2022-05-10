import 'package:flutter/material.dart';
import 'package:imd0509_projeto/components/available_doctors_list.dart';

import '../utils/app_routes.dart';

class AvailableDoctors extends StatefulWidget {
  @override
  State<AvailableDoctors> createState() => _AvailableDoctorsState();
}

class _AvailableDoctorsState extends State<AvailableDoctors> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(242, 242, 242, 1),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                contentPadding: EdgeInsets.all(18.0),
                label: Text('Nome do profissional', style: TextStyle(color: Colors.black.withOpacity(0.3), fontWeight: FontWeight.bold),),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(0)
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Médicos disponíveis', 
              style: TextStyle(
                color: Color.fromRGBO(28, 45, 62, 1),
                fontSize: 26
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AvailableDoctorsList()
          ],
        ),
      ),
    );
  }
}
