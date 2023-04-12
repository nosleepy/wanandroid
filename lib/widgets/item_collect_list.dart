import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanandroid/model/collection_model.dart';
import 'package:wanandroid/res/styles.dart';
import 'package:wanandroid/ui/webview_screen.dart';

class ItemCollectList extends StatefulWidget {
  CollectionBean item;
  Function onClick;

  ItemCollectList(this.item, this.onClick);

  @override
  State<ItemCollectList> createState() {
    return ItemCollectListState();
  }
}

class ItemCollectListState extends State<ItemCollectList> {
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
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Offstage(
                  offstage: widget.item.envelopePic.isEmpty,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 140,
                    height: 100,
                    child: Image.network(
                      widget.item.envelopePic,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.item.author,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  widget.item.niceDate,
                                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap10,
                        Text(
                          widget.item.title,
                          style: const TextStyle(fontSize: 16),
                        ),
                        Gaps.vGap10,
                        Row(
                          children: [
                            Text(
                              widget.item.chapterName,
                              style: const TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    widget.onClick();
                                  },
                                  child: Icon(Icons.favorite, color: Colors.red,),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1,)
        ],
      ),
    );
  }
}