class FavorateRequest {
  String user_id;
  String item_id;

  FavorateRequest(this.user_id, this.item_id);

  Map<String, String> toJson() => {
        "user_id": user_id,
        "item_id": item_id,
      };
}
