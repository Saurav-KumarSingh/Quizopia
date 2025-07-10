class UserModel {
  final String name;
  final String email;
  final int totalScore;
  final int totalAttempted;
  final int correctAnswers;
  final int incorrectAnswers;
  final String profileImage;

  UserModel({
    required this.name,
    required this.email,
    required this.totalScore,
    required this.totalAttempted,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.profileImage,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      totalScore: data['totalScore'] ?? 0,
      totalAttempted: data['totalAttempted'] ?? 0,
      correctAnswers: data['correctAnswers'] ?? 0,
      incorrectAnswers: data['incorrectAnswers'] ?? 0,
      profileImage: data['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'totalScore': totalScore,
      'totalAttempted': totalAttempted,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'profileImage': profileImage,
    };
  }
}
