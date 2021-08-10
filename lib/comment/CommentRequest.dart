class CommentRequest{
  String comment;
  String user_id;
  String item_id;

  CommentRequest(this.comment, this.user_id, this.item_id);

  Map<String, String> toJson() => {
    "comment": comment,
    "user_id": user_id,
    "item_id": item_id,

  };

}