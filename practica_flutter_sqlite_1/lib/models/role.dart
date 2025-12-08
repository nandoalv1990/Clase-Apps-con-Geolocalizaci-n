class Role {
  final int? id;
  final String name;
  Role({this.id, required this.name});
  Map<String, dynamic> toMap() => {
    'id':id,
    'name':name,
  };
}