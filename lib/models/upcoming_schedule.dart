class UpcomingSchedule {
  String category;
  String title;
  String contents;
  DateTime etda;
  String poster;
  bool taskCompleted = false;
  String checker;
  String memo;

  UpcomingSchedule(this.category, this.title, this.contents, this.etda, this.poster, this.taskCompleted, this.checker, this.memo);

  // Convert a note item object into a map
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'title': title,
      'contents': contents,
      'etda': etda,
      'poster': poster,
      'taskCompleted': taskCompleted,
      'checker': checker,
      'memo': memo
    };
  }

  // Convert a note item object into a map
  Map<String, dynamic> updateUpcomingScheduleToMap(category, title, contents, etda, poster, taskCompleted, checker, memo) {
    return {
      'category': category,
      'title': title,
      'contents': contents,
      'etda': etda,
      'poster': poster,
      'taskCompleted': taskCompleted,
      'checker': checker,
      'memo': memo
    };
  }
}
