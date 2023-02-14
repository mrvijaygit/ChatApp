import 'package:chat_app/utils/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import '../data/database_helper.dart';
import '../model/get_message_model.dart';
import '../utils/globals.dart';
import '../utils/styles.dart';

class MessageViewScreen extends StatefulWidget {
  final String? name;
  final int? typeId;

  const MessageViewScreen({Key? key,this.name,this.typeId}) : super(key: key);

  @override
  State<MessageViewScreen> createState() => _MessageViewScreenState();
}

class _MessageViewScreenState extends State<MessageViewScreen> {
  final _msgCtl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> getMsg = [];

  @override
  void initState(){
    super.initState();
    var db = DatabaseHelper();
    db.getAllMessage().then((value){
      getMsg = value.toList();
      setState(() {});
    });
    WidgetsBinding.instance!
        .addPostFrameCallback((_) =>_scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _msgCtl.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var kWidth = UiHelper.getSize(context).width;
    var kHeight = UiHelper.getSize(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Globals.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.yellow.shade100,
              child: Icon(
                Icons.person,
                color: Colors.yellow.shade900,
              ),
            ),
            SizedBox(
              width: kWidth * 0.01,
            ),
            Text(widget.name!,
            style: Styles.headingStyle4(
              isBold: true,
              color: Colors.white
            ),),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.more_vert),
          )
        ],
      ),
        bottomSheet: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    elevation: 1,
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _msgCtl,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                          hintText: 'Type your message here...',
                          hintStyle: Styles.headingStyle5(
                              color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                      if(_msgCtl.text.isNotEmpty){
                        Future.value(Message(widget.typeId,_msgCtl.text))
                            .then((value) => onSend(value))
                            .catchError((onError) {
                              print(onError);
                        });
                      }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal : 15.0),
                    child: CircleAvatar(
                      backgroundColor: Globals.primary,
                      radius: 20,
                      child: Icon(
                          Icons.send_outlined,
                          size: 20.0,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 70.0),
          child: GroupedListView<Message, DateTime>(
            elements: getMsg,
            controller : _scrollController,
            shrinkWrap: true,
            groupBy: (element) => DateTime(2022),
            groupComparator: (value1,
                value2) => value2.compareTo(value1),
            order: GroupedListOrder.ASC,
            groupHeaderBuilder: (Message message)=>const SizedBox(),
            itemBuilder: (context, Message message) {
              return SingleChildScrollView(
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Align(
                    alignment: widget.typeId == message.userId
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Card(
                      shape: widget.typeId == message.userId
                           ? const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(0),
                          )
                      ) : const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            bottomRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      color: widget.typeId == message.userId
                      ? Colors.blueGrey
                      : Colors.white,
                      elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          message.message!,
                          style: Styles.headingStyle5(
                            isBold: true,
                            color: widget.typeId == message.userId
                                ? Colors.white
                                : Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
    );
  }

  void onSend(Message message) async {
    var db = DatabaseHelper();
    setState(() {
      getMsg.add(message);
    });
    await db.saveMessage(message);
    setState(() {
      _msgCtl.text = "";
    });
  }
}
