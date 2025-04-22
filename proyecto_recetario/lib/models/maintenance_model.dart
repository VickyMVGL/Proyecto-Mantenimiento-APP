class Maintenance{
  int id;
  String maintenance;
  String description;
  String car;
  String date;
  String mechanic;
  String notes;

  Maintenance({
    required this.id,
    required this.maintenance,
    required this.description,
    required this.car,
    required this.date,
    required this.mechanic,
    required this.notes,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    return Maintenance(
      id: json['id'],
      maintenance: json['maintenance'],
      description: json['description'],
      car: json['car'],
      date: json['date'],
      mechanic: json['mechanic'],
      notes: json['notes'],
    );
  }

  Map <String, dynamic> toJson() {
    return {
      'id': id,
      'maintenance': maintenance,
      'description': description,
      'car': car,
      'date': date,
      'mechanic': mechanic,
      'notes': notes,
    };
  }

  @override
  String toString() {
    return 'Maintenance{id: $id, maintenance: $maintenance, description: $description, car: $car, date: $date, mechanic: $mechanic, notes: $notes}';
  }
}