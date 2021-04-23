import 'package:flutter/material.dart';

/// [Indicator] class have [radius] [thickness] [space]
/// if you want change indicator setting you must add this class in [PageIndicator]

// PageIndicator(
//  indicator:Indicator(
//      offset:Offset(0.0,widget.height/2.5)
//      radius:8.0,
//      thickness:3.0,
//      space:10.0,
//      indicatorColor:Colors.red,
//      indicatorBackColor:Colors.green,
//  ),
//  controller: **
//  width: **
//  heiht: **
//  autoTransition: 'comming soon'
// ),

class Indicator {
  /// [offset] indicator position if you want changed
  /// default value [Offset] (0.0,height/2.5)
  /// you want to bring it to  left side on [PageView] you you should give negative value
  /// [radius] circleIndicator border value
  /// [thickness] radius = radius = thickness
  /// [indicatorColor] indicator Foreground Color
  /// [indicatorBackColor] indicator Background Color
  final Offset offset;
  final double radius;
  final double thickness;
  final double space;
  final Color indicatorColor;
  final Color indicatorBackColor;

  Indicator({
    this.offset,
    this.indicatorColor,
    this.indicatorBackColor,
    this.radius,
    this.thickness,
    this.space,
  });
}

// ignore: must_be_immutable
class PageIndicator extends StatefulWidget {
  /// [PageIndicator] have a default [controller]
  /// [initialPage] page Starting index.
  /// [keepPage] keepScrrollOffset value.
  /// [viewportFraction] pageView
  /// Default Values
  int initialPage = 0;
  bool keepPage = false;
  double viewportFraction = 1.0;

  double value;

  /// [value] chaged pageView child size not selected Child
  /// [value] default value [1.0] and it only work if you have a pageController it must be viewTranstion value and must be [<1.0]
  /// [example] [PageController] defalutPage = [PageController(initalPage = 0,viewFraction = 0.5)]

  final Widget Function(BuildContext, int) builder;

  /// [builder] is a Function and [(BuildConttext,index)] it needs
  /// Here what child you want must be return from on your page Stateless
  double width;
  double height;

  /// [width] default value is [200.0 ]=>  child width value
  /// [height] default value is [200.0] => child height value

  Color backgroundColor;

  /// [backgroundColor] color of this widget backgroundColor

  Indicator indicator;

  /// [indicator] have indicator settings

  int page;

  /// [page] is how many we have page on [PageView]
  /// default value [int][3]
  bool autoTransition;

  /// [autoTransition] move animation page Transition default value false

  final Function(int) onPageChanged;

  /// [onPageChanged] this function return [int][page]

  PageController controller;
  PageIndicator({
    Key key,
    @required this.onPageChanged,
    this.controller,
    Indicator indicator,
    double width,
    double height,
    this.backgroundColor,
    this.page = 3,
    this.autoTransition = false,
    this.value,
    @required this.builder,
  })  : width = width ?? 200.0,
        height = height ?? 200.0,
        indicator = indicator ??
            Indicator(
              offset: Offset(0.0, height / 2.5),
              radius: 8.0,
              thickness: 1.0,
              space: 5.0,
              indicatorColor: Colors.red,
              indicatorBackColor: Colors.grey,
            ),
        assert(width != 0.0),
        assert(height != 0.0),
        assert(page != 0),
        assert(builder != null),
        super(key: key);
  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  PageController _pageController;
  PageController _pageControllerDefault;

  int currentPage = 0;

  /// [_controller] every chaged page indicator set position step by step
  /// [_animation] parent of [_controller] and setState this widget

  ///[_pageViewWidget] here we are animationTransition page controller
  ///[AnimatedBuilder] animation => [controller] because we need pageController currentPage by use [onPageChanged]
  /// [_pageViewWidget] show our children and animated Transition

  Widget _pageViewWidget(context, index) => AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double val = 1.0;
          if (widget.value != null &&
              _pageController.position.hasContentDimensions) {
            val = _pageController.page - index;
            val = (1 - (val.abs() * widget.value)).clamp(0.0, 1.0);
          }
          return Center(
            child: SizedBox(
              width:
                  Curves.easeInOut.transform(widget.value != null ? val : 1.0) *
                      widget.width,
              height:
                  Curves.easeInOut.transform(widget.value != null ? val : 1.0) *
                      widget.height,
              child: child,
            ),
          );
        },
        child: widget.builder(context, index),
      );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.controller = PageController(
    //   initialPage: widget.controller.initialPage,
    //   viewportFraction: widget.controller.viewportFraction,
    // );
    _pageControllerDefault = PageController(
      initialPage: widget.initialPage,
      keepPage: widget.keepPage,
      viewportFraction: widget.viewportFraction,
    );
    _pageController = widget.controller ?? _pageControllerDefault;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // print('dispose');
    _pageControllerDefault.dispose();
  }

  // @override
  // void deactivate() {
  //   // TODO: implement deactivate
  //   super.deactivate();
  //   //widget.controller.dispose();
  //   print('deactive');
  // }

  @override
  Widget build(BuildContext context) {
    print('index');
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          color: widget.backgroundColor,
          width: MediaQuery.of(context).size.width,
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: widget.onPageChanged,
            itemCount: widget.page,
            itemBuilder: (context, index) => _pageViewWidget(context, index),
          ),
        ),
        Transform.translate(
          offset: widget.indicator.offset ?? Offset(0.0, widget.height / 2.5),
          child: Container(
            child: CustomPaint(
              painter: PageIndicatorPaint(
                controller: _pageController,
                animation: _pageController,
                indicator: widget.indicator,
                pageCount: widget.page,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// [CustomPainter] is our indicator
/// circle or rectagle indicator chaged color and change position with [PageView] position

class PageIndicatorPaint extends CustomPainter {
  /// [indicatorColor] is ForegroundColor of indicator.
  /// [indicatorBackColor] is backgroundColor of indicator.
  /// [thickness] is indicator size
  /// [page] is [PageView] page so we need this because pageIndicator postion change with [PageViewController] [page]
  /// [pageCount] how many we have page, because same page count we have indicator
  /// [space] each space value of [PageIndicator]
  /// [radius] indicator border radius value
  Color indicatorColor;
  Color indicatorBackColor;
  double thickness;
  double space;
  double radius;

  /// Up there settings [indicator] have
  Indicator indicator;
  double page;
  final int pageCount;
  Paint indicatorPaint;
  Paint indicatorBackPaint;

  /// [indicatorPaint] foreGround indicator circle paint
  /// [indicatorBackPaint] backGround indicator cirle paint
  ///  [Listenable] ***
  ///  [PageController]
  final Listenable animation;
  final PageController controller;
  PageIndicatorPaint({
    @required this.controller,
    @required this.pageCount,
    @required this.indicator,
    @required this.animation,
  })  : indicatorColor = indicator.indicatorColor ?? Colors.red,
        indicatorBackColor = indicator.indicatorBackColor ?? Colors.black,
        radius = indicator.radius ?? 10.0,
        thickness = indicator.thickness ?? 3.0,
        space = indicator.space ?? 10.0,
        super(repaint: animation);

  /// [Offset] (center) it first our indicator in center
  @override
  void paint(Canvas canvas, Size size) {
    indicatorPaint = Paint()..color = indicatorColor;
    indicatorBackPaint = Paint()..color = indicator.indicatorBackColor;
    final Offset center = size.center(Offset.zero);
    final double totalWidth =
        (pageCount * 2 * radius) + ((pageCount - 1) * space);
    _drawBackgroundIndicator(canvas, center, totalWidth);
    _drawForegroundIdicator(canvas, center, totalWidth);
  }

  void _drawBackgroundIndicator(
      Canvas canvas, Offset center, double totalWidth) {
    Offset circleCenter = center.translate((-totalWidth / 2) + radius, 0);
    for (var i = 0; i < pageCount; i++) {
      canvas.drawCircle(circleCenter, radius - thickness, indicatorBackPaint);
      circleCenter = circleCenter.translate((2 * radius) + space, 0);
    }
  }

  void _drawForegroundIdicator(
      Canvas canvas, Offset center, double totalWidth) {
    if (controller.hasClients && controller.page != null) {
      page = controller.page;
    } else {
      page = 0.0;
    }
    final int pageIndexToLeft = page.floor();
    final double leftDotX = (center.dx - (totalWidth / 2)) +
        (pageIndexToLeft * ((2 * radius) + space));
    final double transitionPercent = page - pageIndexToLeft;
    final double laggingLeftPositionPercent =
        (transitionPercent - 0.3).clamp(0.0, 1.0) / 0.7;

    final double indicatorLeftX =
        leftDotX + (laggingLeftPositionPercent * ((2 * radius) + space));

    final double acceleratedRightPositionPercent =
        (transitionPercent / 0.5).clamp(0.0, 1.0);

    final double indicatorRightX = leftDotX +
        (acceleratedRightPositionPercent * ((2 * radius) + space)) +
        (2 * radius);

    canvas.drawRRect(
      RRect.fromLTRBR(
        indicatorLeftX,
        -radius,
        indicatorRightX,
        radius,
        Radius.circular(radius),
      ),
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
