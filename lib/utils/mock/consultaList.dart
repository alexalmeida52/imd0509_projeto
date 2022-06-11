import '../../models/consultas.dart';

final List<Consulta> consultaListMocked = [
  new Consulta(
    name: 'Dr. José Alex', 
    speciality: 'Cardiologista', 
    address: 'myClinic, Lagoa Nova, Natal',
    avatarUrl: 'alex.jpg',
    data: DateTime.now().add(Duration(days: 15)),
    valor: 260,
    status: 'Confirmado'
  ), 
  new Consulta(
   name: 'Dr. Elias Anderson', 
   speciality: 'Urologista', 
   address: 'myClinic, Lagoa Nova, Natal',
   avatarUrl: 'elias.jpg',
   data: DateTime.now().add(Duration(days: 18)),
   valor: 360,
   status: 'Pendente'
  ), 
  new Consulta(
    name: 'Dr. Karla Moura', 
    speciality: 'Nutricionista', 
    address: 'myClinic, Lagoa Nova, Natal',
    avatarUrl: 'karla.jpg',
    data: DateTime.now().add(Duration(days: 25)),
    valor: 160,
    status: 'Pendente'
  ),  
  new Consulta(
    name: 'Dr. Fabricio Cruz', 
    speciality: 'Dentista', 
    address: 'myClinic, Lagoa Nova, Natal',
    avatarUrl: 'fabricio.jpg',
    data: DateTime.now().subtract(Duration(days: 15)),
    valor: 150,
    status: 'Finalizada'
  ),   
  new Consulta(
    name: 'Dr. Victor Pinheiro', 
    speciality: 'Terapia', 
    address: 'myClinic, Lagoa Nova, Natal',
    avatarUrl: 'victor.jpg',
    data: DateTime.now().subtract(Duration(days: 25)),
    valor: 249.99,
    status: 'Finalizada'
  ),   
  new Consulta(
    name:'Dr. Leonardo Mauricio', 
    speciality: 'Neurologista', 
    address: 'myClinic, Lagoa Nova, Natal',
    avatarUrl: 'leo.jpg',
    data: DateTime.now().subtract(Duration(days: 15)),
    valor: 450,
    status: 'Finalizada'
  ),   
];
