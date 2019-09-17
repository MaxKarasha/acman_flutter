class Activity {
  String id;
  String caption;
  DateTime start;
  DateTime end;
  String userId;

  Activity({this.id, this.caption, this.start, this.end, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'caption': this.caption,
      'start': this.start,
      'end': this.end,
      'userId': this.userId
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as String,
      caption: map['caption'] as String,
      start: map['start'] as DateTime,
      end: map['end'] as DateTime,
      userId: map['userId'] as String
      //articles: map['articles'].map<Article>((article) => Article.fromMap(article)).toList(),
    );
  }

}
