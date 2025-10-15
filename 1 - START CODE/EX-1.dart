enum Skill { FLUTTER, DART, OTHER }

class Address {
  final String street;
  final String city;
  final String zipCode;

  const Address({
    required this.street,
    required this.city,
    required this.zipCode,
  });

  @override
  String toString() => '$street, $city ($zipCode)';
}

class Employee {
  final String _name;
  final double _baseSalary;
  final List<Skill> _skills;
  final Address _address;
  final int _yearsOfExperience;

  Employee({
    required String name,
    required double baseSalary,
    required List<Skill> skills,
    required Address address,
    required int yearsOfExperience,
  }) : _name = name,
       _baseSalary = baseSalary,
       _skills = List.unmodifiable(skills),
       _address = address,
       _yearsOfExperience = yearsOfExperience;

  Employee.mobileDeveloper({
    required String name,
    required Address address,
    required int yearsOfExperience,
  }) : this(
         name: name,
         baseSalary: 40000,
         skills: [Skill.FLUTTER, Skill.DART],
         address: address,
         yearsOfExperience: yearsOfExperience,
       );

  Employee.junior({required String name, required Address address})
    : this(
        name: name,
        baseSalary: 40000,
        skills: [Skill.OTHER],
        address: address,
        yearsOfExperience: 1,
      );

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => List.unmodifiable(_skills);
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  double computeSalary() {
    double salary = _baseSalary;

    salary += _yearsOfExperience * 2000;

    for (var skill in _skills) {
      switch (skill) {
        case Skill.FLUTTER:
          salary += 5000;
          break;
        case Skill.DART:
          salary += 3000;
          break;
        case Skill.OTHER:
          salary += 1000;
          break;
      }
    }
    return salary;
  }

  @override
  String toString() {
    return '''
      Name: $_name
      Address: $_address
      Experience: $_yearsOfExperience years
      Skills: ${_skills.map((s) => s.name).join(', ')}
      Total Salary: \$${computeSalary().toStringAsFixed(2)}
    ''';
  }
}

void main() {
  var address1 = Address(
    street: "123 Main St",
    city: "Phnom Penh",
    zipCode: "12000",
  );

  var emp1 = Employee(
    name: "John Doe",
    baseSalary: 20000,
    skills: [Skill.FLUTTER, Skill.OTHER],
    address: address1,
    yearsOfExperience: 5,
  );

  var emp2 = Employee.mobileDeveloper(
    name: "Jane Smith",
    address: address1,
    yearsOfExperience: 3,
  );

  var emp3 = Employee.junior(name: "Sam Lee", address: address1);

  print(emp1);
  print(emp2);
  print(emp3);
}
