class Patient {
  String name;
  String last_name;
  String gender;
  String birthday;
  String email;
  String phone;
  String password;
  //String? avatarUrl;

  Patient({required this.name, required this.last_name, required this.gender,required this.email, required this.birthday, required this.password, required this.phone});
  factory Patient.fromJson(Map<String, dynamic> json){
    return Patient( 
      name: json['name'],
      last_name: json['last_name'],
      gender: json['gender'],
      email: json['email'],
      password: json['password'],
      birthday: json['birthday'],
      phone: json['phone']
    );
  }
}
