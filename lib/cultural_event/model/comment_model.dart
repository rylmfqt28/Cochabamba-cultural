class CommentModel {
  String? userUid;
  String? userName;
  String? userImage;
  double? votation;
  String? comment;
  DateTime? commentDate;

  CommentModel(
      {this.userUid,
      this.userName,
      this.userImage,
      this.votation,
      this.comment,
      this.commentDate});

  factory CommentModel.fromMap(map) {
    return CommentModel(
        userUid: map["userUid"],
        userName: map["userName"],
        userImage: map["userImage"],
        votation: map["votation"],
        comment: map["comment"],
        commentDate: map["commentDate"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "userUid": userUid,
      "userName": userName,
      "userImage": userImage,
      "votation": votation,
      "comment": comment,
      "commentDate": commentDate
    };
  }

  copyWhit(
          {String? userUid,
          String? userName,
          String? userImage,
          double? votation,
          String? comment,
          DateTime? commentDate}) =>
      CommentModel(
          userUid: userUid ?? this.userUid,
          userName: userName ?? this.userName,
          userImage: userImage ?? this.userImage,
          votation: votation ?? this.votation,
          comment: comment ?? this.comment,
          commentDate: commentDate ?? this.commentDate);
}
