import '../../models/consultas.dart';

final List<Consulta> consultaListMocked = [
  new Consulta(
    'Dr. José Alex', 
    'Cardiologista', 
    'myClinic, Lagoa Nova, Natal',
    'alex.jpg',
    DateTime.now().add(Duration(days: 15)),
    260,
    'Confirmado'
  ), 
  new Consulta(
    'Dr. Elias Anderson', 
    'Urologista', 
    'myClinic, Lagoa Nova, Natal',
    'elias.jpg',
    DateTime.now().add(Duration(days: 18)),
    360,
    'Pendente'
  ), 
  new Consulta(
    'Dr. Karla Moura', 
    'Nutricionista', 
    'myClinic, Lagoa Nova, Natal',
    'karla.jpg',
    DateTime.now().add(Duration(days: 25)),
    160,
    'Pendente'
  ),  
  new Consulta(
    'Dr. Fabricio Cruz', 
    'Dentista', 
    'myClinic, Lagoa Nova, Natal',
    'fabricio.jpg',
    DateTime.now().subtract(Duration(days: 15)),
    150,
    'Finalizada'
  ),   
  new Consulta(
    'Dr. Victor Pinheiro', 
    'Terapia', 
    'myClinic, Lagoa Nova, Natal',
    'victor.jpg',
    DateTime.now().subtract(Duration(days: 25)),
    249.99,
    'Finalizada'
  ),   
  new Consulta(
    'Dr. Leonardo Mauricio', 
    'Neurologista', 
    'myClinic, Lagoa Nova, Natal',
    'leo.jpg',
    DateTime.now().subtract(Duration(days: 15)),
    450,
    'Finalizada'
  ),   
];
