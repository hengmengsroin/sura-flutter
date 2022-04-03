# sura_flutter

[![pub package](https://img.shields.io/badge/pub-1.1.0-blueviolet.svg)](https://pub.dev/packages/sura_flutter) ![Latest commit](https://badgen.net/github/last-commit/asurraa/sura_flutter)

A flutter package for custom widgets and utility function.

# Migrate from 0.2.x to 0.3.x

- BREAKING CHANGE:

  - remove FutureManager, AsyncSubjectManager, FutureManagerBuilder
  - All manager class now has a separate package

  ```dart
  dependencies:
    sura_manager: ^1.0.0
  ```

# Installation

Add this to pubspec.yaml

```dart
dependencies:
  sura_flutter: ^1.1.0
```

# Widgets

| Widget | Description |
| --- | --- |
| [ConditionalWidget][other] | Build a widget base on a boolean condition |
| [KeyboardDismiss][other] | Dismiss keyboard on tap |
| [LoadingOverlay][other] | Create an overlay loading that cover entire screen and disable input |
| [SpaceX][other] | SizedBox with only width |
| [SpaceY][other] | SizedBox with only height |
| [SuraAccordian][accordion_expandable] | Custom ExpansionTile |
| [SuraActionSheet][other] | Custom CupertinoActionSheet for option selector |
| [SuraAsyncButton][buttons] | Fully customize Material ElevatedButton for asynchronus onPressed callback |
| [SuraAsyncIconButton][buttons] | SuraIconButton with asynchronus onPressed callback |
| [SuraBadge][buttons] | Small badge like notification |
| [SuraConfirmationDialog][other] | Platform adaptive AlertDialog with cancel and confirm action |
| [SuraExpandable][accordion_expandable] | Similar to SuraAccordion but with different use case |
| [SuraFlatButton][buttons] | Custom TextButton or FlatButton |
| [SuraFutureHandler][builder_example] | FutureBuilder with less boilerplate code |
| [SuraIconButton][buttons] | Custom IconButton |
| [SuraListTile][other] | Custom ListTile |
| [SuraLoadingDialog][other] | Create and manage Loading Dialog, Deprecated and shouldn't be use. Consider using LoadingOverlay instead |
| [SuraNotifier][buttons] | Custom ValueListenableBuilder |
| [SuraPaginatedGrid][other] | Gridview with pagination support |
| [SuraPaginatedList][other] | ListView with pagination support |
| [SuraPlatformChecker][other] | Platform adaptive widget |
| [SuraProvider][other] | A provider for SuraFlutter global setting |
| [SuraRaisedButton][buttons] | Custom ElevatedButton with loading notifier |
| [SuraSimpleDialog][other] | Simple platform adaptive AlertDialog |
| [SuraStreamHandler][builder_example] | A Streambuilder with less boilerplate code |
| [SuraToolbar][other] | Custom ToolBar or AppBar |

[buttons]: https://github.com/asurraa/sura-flutter/tree/master/example/lib/examples/other_buttons_example.dart
[builder_example]: https://github.com/asurraa/sura-flutter/tree/master/example/lib/examples/builder_example.dart
[accordion_expandable]: https://github.com/asurraa/sura-flutter/tree/master/example/lib/examples/sura_accordion_and_sura_expandable.dart
[other]: https://github.com/asurraa/sura_flutter/tree/master/example

# Mixin

### AfterBuildMixin

Create an override method that will call after the build method has been called

```dart
class _HomePageState extends State<NewPage> with AfterBuildMixin {

  //this method will call after widget has been build
  @override
  void afterBuild(BuildContext context) {

  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

```

### SuraFormMixin

Provide some property and method when working with **Form**

#### field and attribute

- **formKey**: a key for form
- **loadingNotifier**: a bool ValueNotifier
- **passwordObsecureNotifier**: a bool ValueNotitifer for toggling password obsecure field
- **isFormValidated**: a bool return by validate **formKey**

#### method

- **toggleLoading**: toggle _loadingNotifier_
- **togglePasswordObsecure**: toggle _passwordObsecureNotifier_

```dart
class _HomePageState extends State<NewPage> with SuraFormMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: formKey, child: child)
    );
  }
}
```

### BoolNotifierMixin

Provider a ValueNotifier<bool> and a value toggle function

- **boolNotifier**: a bool ValueNotifier

#### method

- **toggleValue**: toggle _loadingNotifier_

```dart
class _HomePageState extends State<NewPage> with BoolNotifierMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

# Extension

### BuildContext extension

```dart
  Size screenSize = context.screenSize;
  Color primaryColor = context.primaryColor;
  Color accentColor = context.accentColor;
  TextThemeData textTheme = context.textTheme;
  Theme theme = context.theme;
  MediaQueryData data = context.mediaQuery;
  //
  context.hideKeyboard();

```

### TextStyle Extention

```dart
Text("Hello Flutter", style: TextStyle().normal)
Text("Hello Flutter", style: TextStyle().medium)
Text("Hello Flutter", style: TextStyle().bold)
Text("Hello Flutter", style: TextStyle().semiBold)
Text("Hello Flutter", style: TextStyle().white)
Text("Hello Flutter", style: TextStyle().black)
Text("Hello Flutter", style: TextStyle().red)
Text("Hello Flutter", style: TextStyle().green)
Text("Hello Flutter", style: TextStyle().grey)
Text("Hello Flutter", style: TextStyle().underline)
Text("Hello Flutter", style: TextStyle().setColor(Colors.white))
Text("Hello Flutter", style: TextStyle().setFontSize(24))

///This responsive font size is configre as follwing using SuraResponsive value:
/// tablet: value + 4
/// desktop: value + 6
/// small mobile: value - 2
Text("Hello Flutter", style: TextStyle().responsiveFontSize(24))
```

### DateTime extension

```dart
DateTime.now().format(format: "dd mmm yyyy", locale: context.locale)
DateTime.now().isTheSameDay(DateTime.now())
DateTime.now().formatToLocalDate(format: "dd mmm yyyy", locale: context.locale)
```

### List and map extension

```dart
///Filter list
List<int> adult = [2,24,12,18].filter((age)=> age >= 18);

///Add age to Map if age isn't null
Map<String, int> data = {};
int? age = 20;
data.addIfNotNull("age",age);

///Return null if age doesn't exist
data.getIfExist("age");
```

### Widget's Extension

```dart
Text("Hello Flutter").padding(EdgeInsets.all(16.0)) // defaulat value is EdgeInsets.all(8.0)
Text("Hello Flutter").margin(EdgeInsets.all(16.0)) // defaulat value is EdgeInsets.all(8.0)
///As a value
Text("Hello Flutter").marginValue(all: 12)
Text("Hello Flutter").paddingValue(horizontal: 12, vertical: 8)
```

```dart
Text("Hello Flutter").cssSpacing(margin: [10,10], padding:[16])
//css margin and padding rule
```

```dart
Text("Hello Flutter").rotate(45)
///Rotate 45 degree
```

```dart
Text("Hello Flutter").flexible
Text("Hello Flutter").expanded
Text("Hello Flutter").clipOval
Text("Hello Flutter").opacity(0.5)
```

### String extension

```dart
String name = "chunlee".capitalize() // => Chunlee
```

# Utility and Style

### DotTabIndicator

![alt text](screenshots/tab-indicator-2.png "DotTabIndicator")

```dart
  TabBar(
      ...
      indicator: DotTabIndicator(
        color: Colors.blue,
        dotAlignment: TabAlignment.bottom,
      )
      ...
  )
```

### SmallUnderlineTabIndicator

![alt text](screenshots/tab-indicator-1.png "SmallUnderlineIndicator")

```dart
  TabBar(
      ...
      isScrollable: true, //This indicator work best with scrollable tab bar
      indicator: SmallUnderlineTabIndicator(
        color: Colors.blue,
        paddingLeft: 16,
        alignment: TabAlignment.bottom,
      )
      ...
  )
```

### ShadowInputBorder

This input border solve a problem thath TextField doesn't have a default elevation.

![alt text](screenshots/shadow-input-border.png "SmallUnderlineIndicator")

```dart
  TextFormField(
      ...
      decoration: InputDecoration(
        border: ShadowInputBorder(
          elevation: 2.0, //required
          fillColor: Colors.white, //required
          borderRadius: SrauStyle.radius(),
          shadowColor: Colors.black87,
        ),

      )
      ...
  )
```

### SuraColor

```dart

//Get Color from hex string
Color green = SuraColor.fromCode("42f545")

//Get Color from RGB without Alpha or Opacity
Color newColor = SuraColor.fromRGB(8, 182, 155)

//Convert color to MaterialColor
MaterilColor newMaterialColor = SuraColor.toMaterial(0xFF869CF4)
```

### SuraUtils

```dart

//Ping to google for internet connection
bool isConnected = await SuraUtils.checkConnection();

//Future.delayed base on second value
double radian = SuraUtils.degreeToRadian(90);

//Future.delayed base on second value
await SuraUtils.wait(2);

//Get random image from unsplash
String carUrlImage =  SuraUtils.unsplashImage(width: 200, height: 200, category: "car");

//Get byte from asset bundle
Future<Uint8List> imageByte = await SuraUtils.getBytesFromAsset("image asset path", 200); //200 is imagewidth

//Get random image from unsplash
String carUrlImage =  SuraUtils.unsplashImage(width: 200, height: 200, category: "car");

//Get random from picsum with provided: width and height
String randomUrlImage = SuraUtils.picsumImage(200,300);
```

## SuraFormValidator

Provide some field validation

```dart
///Validate
TextFormField(
  validator: (value) => SuraFormValidator.validateField(value, field: "username"),
),

TextFormField(
  validator: (value) => SuraFormValidator.isNumber(value, field: "age"),
),

TextFormField(
  validator: (value) => SuraFormValidator.validateEmail(value, field: "email"),
)
```

## SuraPageNavigator and SuraNavigator

PageNavigator support push, pushReplacement and pushAndRemove method

```dart
///use name param to provide RouteSetting's routeName
SuraPageNavigator.push(context, DetailPage(), name: "detail-page");

///Also support RouteSetting
SuraPageNavigator.pushReplacement(context, HomePage(), settings: RouteSetting());

///Remove all
SuraPageNavigator.pushAndRemove(context, RootPage());
```

SuraNavigator also support push, pushReplacement, pushAndRemove without providing a context but you need to add **SuraNavigator.navigatorKey** to MaterialApp

```dart
MaterialApp(
    ...
    navigatorKey: SuraNavigator.navigatorKey,
    ...
    home: MyHomePage(),
)
```

```dart
SuraNavigator.push(DetailPage());
SuraNavigator.pushReplacement(HomePage());
SuraNavigator.pushAndRemove(RootPage());
```

**SuraNavigator also can show dialog without providing a context**

```dart
var result = await SuraNavigator.dialog(MyDialog());
```

### SuraDecoration

```dart
RoundedRectangleBorder roundRectangle = SuraDecoration.roundRect(12);//default value is 8
BorderRadius radius = SuraDecoration.radius(12); //default value is 8
```

### SuraResponsiveSize

A responsive tool to help define a value base on screen size

- Wrap your Home widget in MaterialApp with **SuraResponsiveBuilder**

Example:

```dart
double width = SuraResponsive.value(20,24,28,16);
// Only required first parameter
//set value 20 for mobile size
//set value 24 for tablet size
//set value 28 for desktop size
//set value 16 for small mobile size
```
