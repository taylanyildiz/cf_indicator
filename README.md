# cf_indicator

 Page View Indicator.

## Screenshots

<img src="https://user-images.githubusercontent.com/37551474/115258848-06d92000-a13a-11eb-92f2-169dec4334a8.png" height="300em" /> <img src="https://user-images.githubusercontent.com/37551474/115258994-283a0c00-a13a-11eb-9365-41ca7220bfb2.png" height="300em" /> <img src="https://user-images.githubusercontent.com/37551474/115259004-296b3900-a13a-11eb-985b-af17f6d0667b.png" height="300em" /> 


## Usage

[Example](https://github.com/taylanyildiz/cf_indicator/blob/master/example/example.dart)

To use this package :

* add the dependency to your [pubspec.yaml](https://github.com/taylanyildiz/cf_indicator/blob/master/pubspec.yaml) file.

## dependencies:

```yaml
  dependencies:
    flutter:
      sdk: flutter
    cf_indicator: "^0.0.7"
```


## How to use

## import

```dart
import 'package:cf_indicator/cf_indicator.dart';
```

## example
```dart
  PageIndicator(
    // controller: _pageController,
    // height: 300.0,
    // width: 200.0,
    //backgroundColor: Colors.blue,
    value: .5, // must be between 1.0 and 0.0 or null
    onPageChanged: (value) => print(value),
    page: Images.imageslist.length,
    builder: (context, index) => _displayWidget(context, index),
    // you have default indicator. if you want change add indicator class 
    // you don't have to fill every value in indicator. You can change what value[s] you want to change 
    // indicator: Indicator(indicatorColor: Colors.blue),
    <!-- indicator: Indicator(
      indicatorBackColor: Colors.grey,
      indicatorColor: Colors.orange,
      radius: 10.0,
      thickness: -4.0,
      space: 10.0,
      ), -->
    
  ),
```

```dart
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
```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
