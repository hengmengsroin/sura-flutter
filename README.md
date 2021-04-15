# sura_flutter

[![pub package](https://img.shields.io/badge/pub-0.1.4-blueviolet.svg)](https://pub.dev/packages/sura_flutter)
![Latest commit](https://badgen.net/github/last-commit/asurraa/sura_flutter)

A flutter package from AsurRaa for widgets and utility functions

# Installation

Add this to pubspec.yaml

```dart
dependencies:
  sura_flutter: ^0.1.4
```

# Widgets

| Widget                                 | Description                                            |
| -------------------------------------- | ------------------------------------------------------ |
| [SuraRaisedButton][otherbuttonurl]     | A Material ElevatedButton with loading notifier        |
| [SuraBadge][otherbuttonurl]            | A small badge like notification                        |
| [SuraActionSheet][sheet-dialog]        | ACupertino bottom sheet with option                    |
| [ConditionalWidget][other]             | Build a widget base on a boolean condition             |
| [SuraToolbar][otherbuttonurl]          | A custom back button with title (header)               |
| [SuraFutureHandler][streamfutureurl]   | A FutureBuilder with less boilerplate code             |
| [SuraAccordian][accordin-expandable]   | A customizable ExpansionTile                           |
| [SuraExpandable][accordin-expandable]  | A widget that can be toggle with top and bottom widget |
| [SuraConfirmationDialog][sheet-dialog] | An Alert dialog with cancel and confirm action         |
| [SuraAsyncButton][jinloadingbuttonurl] | A Material ElevatedButton that has a loading widget    |
| [SuraLoadingDialog][sheet-dialog]      | A Loading dialog manager class                         |
| [SuraPlatformChecker][other]           | Provide a widget base on Android or iOS platform       |
| [SuraSimpleDialog][sheet-dialog]       | A simple alert dialog                                  |
| [SuraListTile][other]                  | An easy and customizable ListTile                      |
| [SuraPaginatedList][paginated]         | A Listview.separated with pagination support           |
| [SuraPaginatedGridBuilder][paginated]  | A Gridview.builder with pagination support             |
| [SuraIconButton][otherbuttonurl]       | A customizable IconButton                              |
| [SuraFlatButton][otherbuttonurl]       | A small alternative to Flutter's FlatButton            |
| [SpaceX][other]                        | SizedBox with only width                               |
| [SpaceY][other]                        | SizedBox with only height                              |
| [SuraStreamHandler][streamfutureurl]   | A Streambuilder with less boilerplate code             |
| [SuraNotifier][other]                  | A ValueListenableBuilder with less boilerplate code    |

[jinloadingbuttonurl]: https://github.com/asurraa/sura_flutter
[otherbuttonurl]: https://github.com/asurraa/sura_flutter
[jinmediacardurl]: https://github.com/asurraa/sura_flutter
[streamfutureurl]: https://github.com/asurraa/sura_flutter
[accordin-expandable]: https://github.com/asurraa/sura_flutter
[sheet-dialog]: https://github.com/asurraa/sura_flutter
[paginated]: https://github.com/asurraa/sura_flutter
[other]: https://github.com/asurraa/sura_flutter

# Mixin

### AfterBuildMixin

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
    return Container();
  }
}
```

### NotifierMixin

- **loadingNotifier**: a bool ValueNotifier

#### method

- **toggleLoading**: toggle _loadingNotifier_

```dart
class _HomePageState extends State<NewPage> with SuraFormMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

# Widget's Extension

### padding, margin

```dart
Text("Hello Flutter").padding(EdgeInsets.all(16.0)) // defaulat value is EdgeInsets.all(8.0)
Text("Hello Flutter").margin(EdgeInsets.all(16.0)) // defaulat value is EdgeInsets.all(8.0)
///As a value
Text("Hello Flutter").marginValue(all: 12)
Text("Hello Flutter").paddingValue(horizontal: 12, vertical: 8)
```

### cssSpacing

```dart
Text("Hello Flutter").cssSpacing(margin: [10,10], padding:[16])
//css margin and padding rule
```

### rotate (in degree)

```dart
Text("Hello Flutter").rotate(45)
```

### flexible, expanded, clipOval, opacity

```dart
Text("Hello Flutter").flexible
Text("Hello Flutter").expanded
Text("Hello Flutter").clipOval
Text("Hello Flutter").opacity(0.5)
```

# TextStyle Extention

```dart
Text("Hello Flutter", style: TextStyle().normal)
Text("Hello Flutter", style: TextStyle().medium)
Text("Hello Flutter", style: TextStyle().bold)
Text("Hello Flutter", style: TextStyle().applyColor(Colors.white))
Text("Hello Flutter", style: TextStyle().applFontSize(24))
```

# Other Extension

### BuildContext extension

```dart
  Size screenSize = context.screenSize;
  Color primaryColor = context.primaryColor;
  Color accentColor = context.accentColor;
  TextTheme textTheme = context.textTheme;
  Theme theme = context.theme;

```

### DateTime extension

```dart
DateTime.now().format("dd mmm yyyy")
DateTime.now().isTheSameDay(DateTime.now())
DateTime.now().formatToLocalDate("dd mmm yyyy")
```

### String extension

```dart
String name = "chunlee".capitalize() // => Chunlee
```

# Utility and Style

## DotTabIndicator

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

## SmallUnderlineTabIndicator

```dart
  TabBar(
      ...
      indicator: SmallUnderlineTabIndicator(
        color: Colors.blue,
        width: 16,
        height: 8,
        radius: 8,
        paddingLeft: 16,
        alignment: TabAlignment.bottom,
      )
      ...
  )
```

## ShadowInputBorder

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
Color green = SuraColor.fromCode("42f545")
Color newColor = SuraColor.fromRGB(8, 182, 155)
MaterilColor newMaterialColor = SuraColor.toMaterial(0xFF869CF4)
```

### SuraUtils

```dart
Future<Uint8List> imageByte = await SuraUtils.getBytesFromAsset("image asset path", 200); //200 is imagewidth
String carUrlImage =  SuraUtils.unsplashImage(dimension: 200, category: "car"); //get image url from unsplash with given dimension and category
String randomUrlImage = SuraUtils.picsumImage(200); //get random image url from picsum with given dimension
```

### SuraFormValidator

```dart
TextFormField(
validator: (value) => SuraFormValidator.validateField(value, field:"username"),
// check JinValidator class for more field validator
)
```

### PageNavigator and SuraNavigator

PageNavigator support push, pushReplacement and pushAndRemove method

```dart
PageNavigator.push(context, DetailPage());
PageNavigator.pushReplacement(context, HomePage());
PageNavigator.pushAndRemove(context, RootPage());
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

### SuraStyle

```dart
RoundedRectangleBorder roundRectangle = SuraStyle.roundRect(12);//default value is 8
BorderRadius radius = SuraStyle.radius(12); //default value is 8
```
