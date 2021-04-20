import 'package:cf_indicator/cf_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Page View Indicator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(title: 'Page View Indicator'),
    );
  }
}

/// [Images] class for example app [List<String>] type
/// We have assets path insede it has 3 images [Movie Images]
class Images {
  static final imageslist = <String>[
    "assets/images/anatolia.png",
    "assets/images/god_father.png",
    "assets/images/social_network.png",
  ];
}

class HomeScreen extends StatefulWidget {
  final String title;
  HomeScreen({
    Key key,
    @required this.title,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

/// [_pageController] is not default Controller if we want create a [PageController] and can use in our pageView,
class _HomeScreenState extends State<HomeScreen> {
  // PageController _pageController;
  @override
  void initState() {
    super.initState();
    // _pageController = PageController(initialPage: 1, viewportFraction: .5);
  }

  /// [_displayWidget] showing child widget we have
  Widget _displayWidget(context, index) {
    return Image.asset(
      Images.imageslist[index],
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PageIndicator(
              indicator: Indicator(
                indicatorBackColor: Colors.grey,
                indicatorColor: Colors.orange,
                radius: 10.0,
                thickness: -4.0,
                space: 10.0,
              ),
              // height: 300.0,
              // width: 200.0,
              //backgroundColor: Colors.blue,
              value: .5, // must be between 1.0 and 0.0 or null
              onPageChanged: (value) => print(value),
              page: Images.imageslist.length,
              // controller: _pageController,
              builder: (context, index) => _displayWidget(context, index),
            ),
          ],
        ),
      ),
    );
  }
}
