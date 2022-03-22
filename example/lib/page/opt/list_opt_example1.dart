import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:keframe/frame_separate_widget.dart';

import '../../item/complex_item.dart';

class ComplexListOptExample1 extends StatefulWidget {
  const ComplexListOptExample1({Key key}) : super(key: key);

  @override
  ComplexListOptExample1State createState() => ComplexListOptExample1State();
}

class ComplexListOptExample1State extends State<ComplexListOptExample1> {
  int childCount = 100;

  ScrollController scrollController;
  double scrollPos = 1500;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('列表优化 1'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              cacheExtent: 500,
              controller: scrollController,
              itemCount: childCount,
              itemBuilder: (BuildContext c, int i) => FrameSeparateWidget(
                index: i,
                placeHolder: Container(
                  color: (i % 3 == 0)
                      ? Colors.lightGreen[300]
                      : (i % 3 == 1)
                          ? Colors.lightGreen[500]
                          : Colors.lightGreen[700],
                  height: 60,
                ),
                child: CellWidget(
                  color: i.isEven ? Colors.red : Colors.blue,
                  index: i,
                ),
              ),
            ),
          ),
          FrameSeparateWidget(
            index: -1,
            child: operateBar(),
          )
        ],
      ),
    );
  }

  Widget operateBar() {
    return SizedBox(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Wrap(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      childCount += 20;
                      setState(() {});
                    },
                    child: const Text(
                      'setState增加20',
                      style: TextStyle(fontSize: 14),
                    )),
                ElevatedButton(
                    onPressed: () {
                      scrollController.animateTo(scrollPos,
                          duration: Duration(
                              milliseconds: scrollPos == 0 ? 1500 : 600),
                          curve: Curves.easeInOut);
                      scrollPos = scrollPos >= 6000 ? 0 : scrollPos + 1500;
                      setState(() {});
                    },
                    child: Text(
                      '滚动到$scrollPos位置',
                      style: const TextStyle(fontSize: 14),
                    )),
                const Text(
                    '说明：将分帧组件嵌套在 builder 以及底部的操作区域。如果已知实际 item 的宽高信息，最好让 placeholder 保持一致。如果实际的 item 本身比较复杂，可以在 item 中多层嵌套分帧组件。这种场景建议将 ListView 的 cacheExtent 设置大一点如 500'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
