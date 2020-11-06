import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Slideshow extends StatelessWidget {
  //Params
  final List<Widget> slides;
  final bool dotsOnTop;
  final Color primaryColor;
  final Color secondaryColor;
  final double dotsSpace;
  final BoxShape shape;
  final double dotsSize;
  final double secondaryDotsSize;

  //Constructor
  Slideshow({
    @required this.slides,
    this.dotsOnTop = false,
    this.primaryColor = Colors.redAccent,
    this.secondaryColor = Colors.grey,
    this.dotsSpace = 5,
    this.shape = BoxShape.circle, //Shape of dots
    this.dotsSize = 12,
    this.secondaryDotsSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new SliderModel(), //Instantiate the model in the widget
      child: SafeArea(
        child: Center(child: Builder(
          builder: (BuildContext context) {
            //Set Params and fix a Bug of the state, waiting for the update of the widget
            Future.delayed(Duration(milliseconds: 0), () {
              final ssModel = Provider.of<SliderModel>(context, listen: false);
              ssModel.primaryColor = this.primaryColor;
              ssModel.secondaryColor = this.secondaryColor;
              ssModel.dotsSpace = this.dotsSpace;
              ssModel.dotsSize = this.dotsSize;
              ssModel.shape = this.shape;
              ssModel.secondaryDotsSize = this.secondaryDotsSize;
            });

            //Widget
            return Column(
              children: <Widget>[
                //Place the dots in the top if dotsOnTop param is true
                if (dotsOnTop) _Dots(totalSlides: this.slides.length),
                //Slides using the max of free space
                Expanded(
                  child: _Slides(
                    slides: this.slides,
                  ),
                ),
                //Place the dots in the bottom if dotsOnTop param is false
                if (!dotsOnTop) _Dots(totalSlides: this.slides.length),
              ],
            );
          },
        )),
      ),
    );
  }
}

//Classes

class _Slides extends StatefulWidget {
  //Params
  final List<Widget> slides;

  //Constructor
  const _Slides({this.slides});

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
    //Create a listener for the controller
    pageViewController.addListener(
      //When the controller change place the controller page on the current page variable of the slider model
      () => Provider.of<SliderModel>(context, listen: false).currentPage =
          pageViewController.page,
    );
    super.initState();
  }

  @override
  void dispose() {
    //Dispose the controller if the page is dropped
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        //Create a pageview with the slides
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
          controller: pageViewController,
          itemCount: widget.slides.length,
          itemBuilder: (_, i) => _Slide(slide: widget.slides[i]),
        ),
      );
}

class _Slide extends StatelessWidget {
  //Params
  final Widget slide;

  //Constructor
  const _Slide({this.slide});

  @override
  Widget build(BuildContext context) => Container(
        //Design of a slide
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(30),
        child: slide,
      );
}

class _Dots extends StatelessWidget {
  //Params
  final int totalSlides;

  //Constructor
  _Dots({this.totalSlides});

  @override
  Widget build(BuildContext context) =>
      //Return a widget with the dots
      Container(
        width: double.infinity,
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(totalSlides, (i) => _Dot(index: i))),
      );
}

class _Dot extends StatelessWidget {
  //Param
  final int index;

  //Constructor
  const _Dot({this.index});

  @override
  Widget build(BuildContext context) {
    //Get the instance of the slider model
    final ssModel = Provider.of<SliderModel>(context, listen: false);

    //Get the current page of the slider model
    final currentPageIndex = Provider.of<SliderModel>(context).currentPage;

    //Variables
    EdgeInsets space = EdgeInsets.symmetric(horizontal: ssModel.dotsSpace);
    Color color = ssModel.secondaryColor;
    double size = ssModel.secondaryDotsSize;

    //Condition
    if (currentPageIndex >= index - 0.5 && currentPageIndex < index + 0.5) {
      space = EdgeInsets.symmetric(horizontal: ssModel.dotsSpace + 3)
          .add(EdgeInsets.only(bottom: 2));
      size = ssModel.dotsSize;
      color = ssModel.primaryColor;
    }

    //Result
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: space,
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: ssModel.shape),
    );
  }
}

//Model
class SliderModel with ChangeNotifier {
  double _currentPage = 0;
  Color _primaryColor = Colors.redAccent;
  Color _secondaryColor = Colors.grey;
  double _dotsSpace = 5;
  BoxShape _shape = BoxShape.circle;
  double _dotsSize = 10;
  double _secondaryDotsSize = 10;

  double get currentPage => this._currentPage;
  set currentPage(double currentPage) {
    this._currentPage = currentPage;
    notifyListeners();
  }

  Color get primaryColor => this._primaryColor;
  set primaryColor(Color primaryColor) {
    this._primaryColor = primaryColor;
  }

  Color get secondaryColor => this._secondaryColor;
  set secondaryColor(Color secondaryColor) {
    this._secondaryColor = secondaryColor;
  }

  double get dotsSpace => this._dotsSpace;
  set dotsSpace(double dotsSpace) {
    this._dotsSpace = dotsSpace;
  }

  BoxShape get shape => this._shape;
  set shape(BoxShape shape) {
    this._shape = shape;
  }

  double get dotsSize => this._dotsSize;
  set dotsSize(double dotsSize) {
    this._dotsSize = dotsSize;
  }

  double get secondaryDotsSize => this._secondaryDotsSize;
  set secondaryDotsSize(double secondaryDotsSize) {
    this._secondaryDotsSize = secondaryDotsSize;
  }
}
