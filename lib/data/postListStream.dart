import 'package:inforum/component/postListItem.dart';
import 'package:inforum/service/postStreamService.dart';

List<ForumListItem> psis = [];

Future<List<ForumListItem>> getList(String userID) async {
  psis.clear();
  List<Recordset> psl = await getPostStream(userID);

  psl.forEach((rs) {
    String t = rs.tags;
    psis.add(ForumListItem(
      postID: rs.postId,
      titleText: rs.title,
      contentText: rs.bodyS,
      likeCount: rs.likeCount,
      dislikeCount: rs.dislikeCount,
      likeState: rs.likeState ?? 0,
      commentCount: rs.commentCount,
      collectCount: rs.collectCount,
      isCollect: rs.isCollected ?? false,
      imgURL: rs.imageUrl ?? null,
      authorName: rs.nickname,
      imgAuthor: rs.avatarUrl ?? null,
      isAuthor: rs.isEditor == 1 ? true : false,
      time: rs.lastEditTime.toString(),
      tags: t != null ? t.split(',') : null,
    ));
  });
  psis.sort((a, b) => b.postID.compareTo(a.postID)); //按ID排序,ID数字越大越新
  return psis;
}