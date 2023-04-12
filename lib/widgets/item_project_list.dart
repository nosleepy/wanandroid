import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/project_article_model.dart';
import 'package:wanandroid/res/styles.dart';
import 'package:wanandroid/ui/webview_screen.dart';

class ItemProjectList extends StatefulWidget {
  ProjectArticleBean item;
  Function onClick;

  ItemProjectList(this.item, this.onClick);

  @override
  State<ItemProjectList> createState() {
    return ItemProjectListState();
  }
}

class ItemProjectListState extends State<ItemProjectList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return WebViewScreen(widget.item.title, widget.item.link);
        }));
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 140,
                  child: Image.network(
                    widget.item.envelopePic,
                    fit: BoxFit.fill,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.item.desc,
                            style: const TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 36),
                          child: Row(
                            children: [
                              Text(
                                widget.item.author,
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                              Gaps.hGap10,
                              Text(
                                widget.item.niceShareDate,
                                style: const TextStyle(fontSize: 14, color: Colors.grey),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 1,)
          ],
        ),
      ),
    );
  }
}