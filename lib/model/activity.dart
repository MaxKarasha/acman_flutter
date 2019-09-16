class Activity {
  String id;
  String title;
  DateTime startDate;

  Activity(this.title, this.startDate);

  /*Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      columnValue: value,
      columnDate: dateTime.millisecondsSinceEpoch,
      columnComment: comment,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Expense.fromMap(Map map)
      : id = map[columnId],
        value = map[columnValue],
        dateTime = new DateTime.fromMillisecondsSinceEpoch(map[columnDate]),
        comment = map[columnComment];*/
}
