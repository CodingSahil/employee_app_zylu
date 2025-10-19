import 'package:equatable/equatable.dart';

class EmployeeModel extends Equatable {
  const EmployeeModel({this.id, required this.name, required this.yearsOfService, required this.isActive});

  final int? id;
  final String name;
  final num yearsOfService;
  final bool isActive;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      yearsOfService: json['yearsOfService'] as num,
      isActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {if (id != null) 'id': id, 'name': name, 'yearsOfService': yearsOfService, 'isActive': isActive};
  }

  @override
  List<Object?> get props => [id, name, yearsOfService, isActive];
}
