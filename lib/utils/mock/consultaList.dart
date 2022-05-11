import '../../models/consultas.dart';

final List<Consulta> consultaListMocked = [
  new Consulta(
    'Dr. José Alex', 
    'Cardiologista', 
    'myClinic, Lagoa Nova, Natal',
    'alex.jpg',
    DateTime.now().add(Duration(days: 15)),
    60,
    'Pendente'
  ),  
  new Consulta(
    'Dr. Fabricio Cruz', 
    'Dentista', 
    'myClinic, Lagoa Nova, Natal',
    'fabricio.jpg',
    DateTime.now().subtract(Duration(days: 15)),
    50,
    'Finalizada'
  ),   
];
