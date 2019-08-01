class DzjContent {
  String buming;
  String yizhe;
  DzjContent({this.buming,this.yizhe});

  factory DzjContent.fromJson(Map<String, dynamic> json) {
    return DzjContent(buming: json['title'],yizhe: json['yizhe']);
  }
}

class DzjBuList {
  int resCode;
  List<DzjContent> contents;

  DzjBuList({this.resCode,this.contents});

  factory DzjBuList.fromJson(Map<String, dynamic> json) {
    var jsonList=json['data'] as List;
    List<DzjContent> memberList =
    jsonList.map((value) => DzjContent.fromJson(value)).toList();

    return DzjBuList(resCode:json['resCode'],contents: memberList);
  }

}



class DzjDetail{
   String id;
   String buming;
   String jingti;
   String juanhao;
   String pinming;
   String pinhao;
   String yizhe;
   String content;
   DzjDetail({this.buming,this.jingti,this.juanhao,this.pinming,this.pinhao,this.yizhe,this.content});
  factory DzjDetail.fromJson(Map<String, dynamic> json) {
    return DzjDetail(buming: json['buming'],
      jingti: json['jingti'],
      juanhao: json['juanhao'],
      pinming: json['pinming'],
      pinhao: json['pinhao'],
      yizhe: json['yizhe'],
      content: json['content'],);
  }
}

class DzjDetailList{
  int resCode;
  List<DzjDetail> contents;
  DzjDetailList({this.resCode,this.contents});
  factory DzjDetailList.fromJson(Map<String, dynamic> json) {
    var jsonList=json['data'] as List;
    List<DzjDetail> memberList =
    jsonList.map((value) => DzjDetail.fromJson(value)).toList();

    return DzjDetailList(resCode:json['resCode'],contents: memberList);
  }
}
