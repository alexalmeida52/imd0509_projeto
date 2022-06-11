class Consulta {
  String name;
  String speciality;
  String address;
  int? rating;
  String? avatarUrl;
  DateTime data;
  double valor;
  String status;

  Consulta({ required this.name, required  this.speciality, required this.address, this.avatarUrl, required this.data, required this.valor, required this.status, this.rating});

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      name: json['name'],
      speciality: json['speciality'],
      address: 'Local',
      avatarUrl: json['avatar'],
      data: json['data'],
      valor: json['valor'],
      status: json['status'],
    );
  }
}