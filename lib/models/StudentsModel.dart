class StudentsModel {
  final int id;
  final String fName;
  final String lName;
  final String major;
  final int age;
  final DateTime birthDate;
  final String imageUrl;

  StudentsModel({
    required this.id,
    required this.fName,
    required this.lName,
    required this.major,
    required this.age,
    required this.birthDate,
    required this.imageUrl,
  });

  // Factory constructor to parse JSON
  factory StudentsModel.fromJson(Map<String, dynamic> json) {
    return StudentsModel(
      id: json['id'],
      fName: json['f_Name'],
      lName: json['l_Name'],
      major: json['major'],
      age: json['age'],
      birthDate: DateTime.parse(json['birthDate']),
      imageUrl: json['imageURl'],
    );
  }

  // Method to convert model to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_Name': fName,
      'l_Name': lName,
      'major': major,
      'age': age,
      'birthDate': birthDate.toIso8601String(),
      'imageURl': imageUrl,
    };
  }
}
