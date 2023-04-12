import 'package:flutter/material.dart';
import 'package:wanandroid/model/article_bean.dart';
import 'package:wanandroid/ui/webview_screen.dart';
import 'package:wanandroid/utils/toast_util.dart';

class ItemArticleList extends StatefulWidget {
  ArticleBean item;
  bool isTop;
  Function onClick;

  ItemArticleList(this.item, this.isTop, this.onClick);

  @override
  State<ItemArticleList> createState() {
    return ItemArticleListState();
  }
}

class ItemArticleListState extends State<ItemArticleList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebViewScreen(widget.item.title, widget.item.link);
        }));
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                Offstage(
                  offstage: !widget.isTop,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 0.5),
                    ),
                    child: const Text(
                      "置顶",
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ),
                ),
                Offstage(
                  offstage: !widget.item.fresh,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, width: 0.5),
                    ),
                    child: const Text(
                      "新",
                      style: TextStyle(fontSize: 10, color: Colors.red),
                    ),
                  ),
                ),
                Offstage(
                  offstage: widget.item.tags.isEmpty,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 0.5),
                    ),
                    child: Text(
                      widget.item.tags.isNotEmpty ? widget.item.tags[0].name : "",
                      style: TextStyle(fontSize: 10, color: Colors.green),
                    ),
                  ),
                ),
                Text(
                  widget.item.author.isEmpty ? widget.item.shareUser : widget.item.author,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.item.niceShareDate,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.right,
                )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
            alignment: Alignment.centerLeft,
            child: Text(
              widget.item.title,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Row(
              children: [
                Text(
                  "${widget.item.superChapterName}/${widget.item.chapterName}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        widget.onClick();
                      },
                      child: Icon(
                        widget.item.collect ? Icons.favorite : Icons.favorite_border,
                        color: widget.item.collect ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}