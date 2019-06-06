class Poem {
  String title;
  String time;
  String author;
  String content;
  Poem({this.title,this.author,this.time,this.content});

  factory Poem.fromJson(Map<String, dynamic> json) {
    return Poem(title: json['title'], author: json['author'],time: json['time'],content: json['content']);
  }
}

class PoemList {
  int resCode;
  List<Poem> poems;

  PoemList({this.resCode,this.poems});

  factory PoemList.fromJson(Map<String, dynamic> json) {
    var jsonList=json['data'] as List;
    List<Poem> memberList =
    jsonList.map((value) => Poem.fromJson(value)).toList();

    return PoemList(resCode:json['resCode'],poems: memberList);
  }

}
