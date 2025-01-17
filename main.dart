import 'package:flutter/material.dart';

void main() {
  runApp(
    MainApp()
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4 )),
              Center(child: Text(
                "Hello!\nHow can I help you?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(0xffffffff),
                  fontSize: 25,
                  fontWeight: FontWeight.w900
                ),
              ),
              ),

              Spacer(flex: 3,),
            ChatGPTTextField(),

            ],
          )
          ),
        ),
      );

  }
}
class ChatGPTTextField extends StatefulWidget {
  const ChatGPTTextField({super.key});

  @override
  State<ChatGPTTextField> createState() => _ChatGPTTextFieldState();
}

class _ChatGPTTextFieldState extends State<ChatGPTTextField> with SingleTickerProviderStateMixin {
  // Control Variables
  late AnimationController _animationController;
  late  Animation<double> _scaleAnimation;
  final ScrollController _firstController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  int _lineCount=1;
  bool _enableSend=false;
  bool _showIcons=false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100), // Duration of the pop-up effect
    );
    _scaleAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _calculateLines(String text) {
    final lines = text.split('\n').length;
    setState(() {
      _lineCount = lines;
    });
  }

  void _onTextChanged(String text) {
    if (text.isNotEmpty) {
      setState(() {
        _enableSend=true;
      });
    } else {
        setState(() {
          _enableSend=false;
        });
       // Shrink the button when input is cleared
    }
    _calculateLines(text);
  }

  @override
  Widget build(BuildContext context) {
    return Column( children:[
     Container(
       padding: EdgeInsets.only(bottom: 10,top: 10),
         color: Color(0xff30ab93),
         child:Row(
           crossAxisAlignment:CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10,left: 5),
            child:AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation){
                  return ScaleTransition(scale: animation,child: child,);
                },
                child:_showIcons?Row(
                  children: [
                    IconButton(
                            onPressed: (){},
                            icon: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                            ),
                        ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.image_outlined,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.folder,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.language,
                        color: Colors.white,
                      ),
                    ),

                  ],
                ):RawMaterialButton(
              onPressed: () {
                setState(() {
                  _showIcons=true;
                });
              },
              fillColor: Color(0xff939393),
              constraints: BoxConstraints(minWidth: 0.0),
              padding: EdgeInsets.all(5.0),
              shape: CircleBorder(),
              child: Icon(
                Icons.add_sharp,
                color: Color(0xffffffff),
                size: 25.0,
              ),
            )
            )
        ),
        // Fix this part of the code in Expanded Widget
        Expanded(child:Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Container(
                      decoration: BoxDecoration(
                      color: Colors.grey[900], // Background color
                      borderRadius: BorderRadius.circular(25), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: RawScrollbar(
                      thumbColor: Colors.white70,
                      thumbVisibility: true,
                      controller: _firstController,
                      child: TextField(

                            onTap: (){
                              setState(() {
                                _showIcons=false;
                              });
                            },
                            scrollController: _firstController,
                            onChanged: _onTextChanged,
                            minLines: 1,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                              color: Colors.white, // Input text color
                            ),
                            decoration: InputDecoration(
                              hintText: 'Message',
                              hintStyle: TextStyle(
                                color: Colors.white54, // Hint text color
                              ),
                              border: InputBorder.none, // No border
                            ),
                          ),)
                  ),

             )),

        Column(children: [
          _lineCount>5?IconButton(onPressed: (){}, icon: Icon(Icons.add_alert)):Container(),
          Padding(padding: EdgeInsets.only(bottom: _lineCount>5?60:0 )),
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              transitionBuilder: (Widget child, Animation<double> animation){
                return ScaleTransition(scale: animation,child: child,);
              },
              child:_enableSend?Padding(
                padding: EdgeInsets.only(bottom: 20),
                key: ValueKey(2),
                child:ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ElevatedButton.styleFrom(
                      shape:  CircleBorder(),
                      padding:  EdgeInsets.all(15),
                      backgroundColor: Color(0xffffffff),

                    ),
                    child: Icon(
                      Icons.send,
                      size: 18,
                    )
                ),
              ):Padding(
                padding: EdgeInsets.only(bottom: 20),
                child:ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    style: ElevatedButton.styleFrom(
                      shape:  CircleBorder(),
                      padding:  EdgeInsets.all(15),
                      backgroundColor: Color(0xffffffff),

                    ),
                    child: Icon(
                      Icons.keyboard_voice,
                      size: 18,
                    )
                ),
              )
          )
        ])
      ],
    )
     ),
    ]
    );
  }
}

