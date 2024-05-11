
class Note {
  String title;
  String category; // use team name
  String contents;
  DateTime postDate;
  String poster;
  String priority;

  Note(this.title, this.category, this.contents, this.postDate, this.poster, this.priority);

  // Convert a note item object into a map
  Map<String, dynamic> toMap() {
    return {'title': title, 'category': category, 'contents': contents, 'postDate': postDate, 'poster': poster, 'priority': priority};
  }

  // Convert a note item object into a map
  Map<String, dynamic> updateNoteToMap(title, category, contents, postDate, poster, priority) {
    return {'title': title, 'category': category, 'contents': contents, 'postDate': postDate, 'poster': poster, 'priority': priority};
  }
}
