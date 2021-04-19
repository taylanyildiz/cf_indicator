# cf_indicator

 Page View Indicator.

## Screenshots

<img src="https://user-images.githubusercontent.com/37551474/115258848-06d92000-a13a-11eb-92f2-169dec4334a8.png" height="300em" /> <img src="https://user-images.githubusercontent.com/37551474/115258994-283a0c00-a13a-11eb-9365-41ca7220bfb2.png" height="300em" /> <img src="https://user-images.githubusercontent.com/37551474/115259004-296b3900-a13a-11eb-985b-af17f6d0667b.png" height="300em" /> 


## Usage

[Example](https://github.com/taylanyildiz/cf_indicator/blob/main/example/example.dart)

To use this package :

* add the dependency to your [pubspec.yaml](https://github.com/taylanyildiz/cf_indicator/blob/main/pubspec.yaml) file.

## dependencies:

```yaml
  dependencies:
    flutter:
      sdk: flutter
    cf_indicator: "^0.0.1"
```


## How to use

## import

```dart
import 'package:cf_indicator/cf_indicator.dart';
```

## example


```dart
   PageIndicator(
    indicator: Indicator(
    indicatorBackColor: Colors.white,
    indicatorColor: Colors.orange,
    radius: 10.0,
    thickness: -4.0,
    space: 10.0,
    ),
    height: 300.0,
    //backgroundColor: Colors.blue,
    onPageChanged: (value) => print(value),
    page: Images.imageslist.length,
    controller: _pageController,
    builder: (context, index) => _displayWidget(context, index),
  ),
```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
