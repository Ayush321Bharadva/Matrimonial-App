class User {
  final int? id;
  final String name;
  final String gender;
  final String city;

  // final String dob;
  // final String religion;
  // final String caste;
  // final bool isLiked;
  final String description;
  static final columns = [
    "id",
    "name",
    "gender",
    "city",
    "description",
    // "isLiked"
  ];

  User({
    this.id,
    required this.name,
    required this.gender,
    required this.city,
    required this.description,
    // this.isLiked = false,
  });

  User copyWith({
    int? id,
    String? name,
    String? gender,
    String? city,
    String? description,
    // bool? isLiked,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      description: description ?? this.description,
      // isLiked: isLiked ?? this.isLiked,
    );
  }

  // Convert the User object to a map for database insertion.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'city': city,
      'description': description,
      // 'isLiked' : isLiked ? 1 : 0,
    };
  }

  // Convert a map to a User object.
  static User fromMap(Map<String, dynamic> data) {
    return User(
      id: data['id'],
      name: data['name'],
      gender: data['gender'],
      city: data['city'],
      description: data['description'],
      // isLiked: data['isLiked'] == 1,
    );
  }
}