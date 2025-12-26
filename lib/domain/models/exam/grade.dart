class Grade {
  const Grade({required this.grade, required this.system});

  final double grade;
  final GradeSystem system;
}

enum GradeSystem {
  gpa(1, 4),
  danish(2, 12),
  spanish(5, 10),
  dutch(6, 10),
  french(10, 20),
  italian(18, 30);

  const GradeSystem(this.minPassingGrade, this.maxGrade);

  final num minPassingGrade;
  final num maxGrade;
}
