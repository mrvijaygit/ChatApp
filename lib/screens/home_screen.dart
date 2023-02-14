import 'package:chat_app/model/get_user_model.dart';
import 'package:chat_app/screens/message_view_screen.dart';
import 'package:chat_app/utils/styles.dart';
import 'package:flutter/material.dart';
import '../utils/globals.dart';
import '../utils/ui_helper.dart';
import '../widgets/clipper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<GetUserModel> getUser = [];

  @override
  void initState() {
    getUser = [
      GetUserModel(id: 1,name: "Vijay",message: "How are you?",time: "00.40"),
      GetUserModel(id: 2,name: "Prakash",message: "Hello",time: "Yesterday")
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final kWidth = UiHelper.getSize(context).width;
    return Scaffold(
        body: SafeArea(
          child: Container(
            color: Colors.black45,
            child: Stack(
                children: [
              Column(
                children: [
                  SizedBox(
                    height: UiHelper.getSize(context).height * 0.20,
                    width: UiHelper.getSize(context).width,
                    child: ClipPath(
                      clipper: WaveClip(),
                      child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.topLeft,
                                colors: [
                                  Globals.primary,
                                  Globals.primary,
                                ])),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: UiHelper.getSize(context).height * 0.06,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: getUser.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MessageViewScreen(
                                name: getUser[index].name,
                                typeId: getUser[index].id,
                              )));
                            },
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey,
                                ),
                              ),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(getUser[index].name ?? "",
                                  style: Styles.headingStyle4(
                                    isBold: true,
                                    color: Colors.white
                                  ),),
                                  Text(getUser[index].time ?? "",
                                      style: Styles.headingStyle7(
                                          color: Colors.white
                                      ))
                                ],
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_outlined,
                                      size: 15,
                                      color: Colors.white54,
                                    ),
                                    SizedBox(
                                      width: kWidth * 0.01,
                                    ),
                                    Text(getUser[index].message ?? "",
                                      style: Styles.headingStyle6(
                                        color: Colors.white54,
                                        isBold: true
                                      )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ),
                ],
              ),
              Positioned(
                top: UiHelper.getSize(context).height * 0.09,
                left: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                            Icons.wechat_outlined,
                          size: 60,
                          color: Colors.white,
                        ),
                      )
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("CHAT APP",
                      style: Styles.headingStyle2(
                      color: Colors.white,
                    ),)
                  ],
                ),
              ),
            ]),
          ),
        ));
  }
}

