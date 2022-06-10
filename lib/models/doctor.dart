class Doctor {
  String name;
  String speciality;
  String address;
  int? rating;
  String? avatarUrl;

  Doctor({required this.name, required this.speciality, required this.address, this.avatarUrl, this.rating});

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      name: json['name'],
      speciality: json['speciality'],
      address: 'Local',
      avatarUrl: json['avatar'],
    );
  }
}
