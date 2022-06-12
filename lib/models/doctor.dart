class Doctor {
  String? id;
  String name;
  String last_name;
  String speciality;
  String address;
  int? rating;
  String? avatarUrl;

  Doctor(
    {
      this.id,
      required this.name,
      required this.last_name,
      required this.speciality,
      required this.address,
      this.avatarUrl,
      this.rating
    }
  );

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      name: json['name'],
      last_name: json['last_name'],
      speciality: json['speciality'],
      address: 'Local',
      avatarUrl: json['avatar'],
    );
  }
}
