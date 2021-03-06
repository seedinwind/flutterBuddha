import 'package:flutter/material.dart';
import 'package:buddhawise/page/videolistpage.dart';
import 'package:buddhawise/page/learnpage.dart';
import 'package:buddhawise/page/thinkpage.dart';
import 'package:buddhawise/page/practicepage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectIndex = 0;
  var pages = [
    LearnPage(),
    ThinkPage(),
    PracticePage()
  ];
  var _pageController = PageController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: PageView.builder(itemBuilder: _pageCreator,
            onPageChanged: _onPageChange,
            itemCount: 3,
            controller: _pageController,),
        ),
        drawer: Drawer(),
        // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomNavigationBar(
          items: _createNavigationBar(),
          onTap: _onNavigationItemSelect,
          currentIndex: _selectIndex,
        ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return VideoListPage();
        }));
      }),
    );
  }

  List<BottomNavigationBarItem> _createNavigationBar() {
    return [
      BottomNavigationBarItem(
          icon: ImageIcon(ExactAssetImage("assets/images/icon.png")),
          title: Text("闻")),
      BottomNavigationBarItem(
          icon: ImageIcon(ExactAssetImage("assets/images/icon.png")),
          title: Text("思")),
      BottomNavigationBarItem(
          icon: ImageIcon(ExactAssetImage("assets/images/icon.png")),
          title: Text("修"))
    ];
  }

  _onNavigationItemSelect(index) {
    setState(() {
      _selectIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  Widget _pageCreator(BuildContext context, int index) {
    return pages[index];
  }

  void _onPageChange(int value) {
    setState(() {
      _selectIndex = value;
    });
  }
}
