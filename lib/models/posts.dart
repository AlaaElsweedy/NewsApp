class Posts{

  String id, title, content, dateWritten,featuredImage;
  int votesUp, votesDown;
  List<int> votersUp, votersDown;
  int userId , categoryId;

  Posts({this.id, this.title, this.content, this.dateWritten, this.featuredImage,
      this.votesUp, this.votesDown, this.votersUp, this.votersDown, this.userId,
      this.categoryId});


}