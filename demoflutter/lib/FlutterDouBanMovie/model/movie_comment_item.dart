class MovieCommentItem{
  String content;  //具体评论内容
  String created_at; //发表的时间
  String id;
  String name;
  String avatar;
  int useful_count; //点赞数
  MovieRate movieRate;

  MovieCommentItem(this.content,this.created_at,this.id,this.name,this.avatar,this.useful_count,this.movieRate);

  MovieCommentItem.fromJson(Map data){
    content = data['content'];
    created_at = data['created_at'];
    id = data['id'];
    name = data['author']['name'];
    avatar = data['author']['avatar'];
    useful_count = data['useful_count'];
    movieRate = MovieRate.fromJson(data['rating']);
  }
}

class MovieRate {
  double max;
  double value;
  double min;

  MovieRate(this.max,this.value,this.min);

  MovieRate.fromJson(Map data) {
    max = data['max'].toDouble();
    value = data['value'].toDouble();
    min = data['min'].toDouble();
  }
}