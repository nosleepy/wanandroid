import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/wx_article_model.dart';
import 'package:wanandroid/ui/webview_screen.dart';

class ItemWeChatList extends StatefulWidget {
  WxArticleBean item;
  Function onClick;

  ItemWeChatList(this.item, this.onClick);

  @override
  State<ItemWeChatList> createState() {
    return ItemWeChatListState();
  }
}

class ItemWeChatListState extends State<ItemWeChatList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebViewScreen(widget.item.title, widget.item.link);
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
            child: Row(
              children: [
                Text(
                  widget.item.author,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      widget.item.niceShareDate,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Text(
              widget.item.title,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: Row(
              children: [
                Text(
                  "${widget.item.superChapterName}/${widget.item.chapterName}",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
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
          const Divider(height: 1,),
        ],
      ),
    );
  }
}