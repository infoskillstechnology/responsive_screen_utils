# responsive_screen_utils

**A flutter plugin for adapting screen, dynamic width and height and font size.Let your UI display a reasonable layout on different screen sizes!**

*Note*: responsive_screen_utils plugin is still under development, and some APIs might not be available yet.

[Github Link](https://github.com/infoskillstechnology/responsive_screen_utils.git)

[CHANGELOG](https://github.com/OpenFlutter/flutter_screenutil/blob/master/CHANGELOG.md)

## Usage:

### Add dependency：
Please check the latest version before installation.
If there is any problem with the new version, please use the previous version
```yaml
dependencies:
  flutter:
    sdk: flutter
  # add responsive_screen_utils
  responsive_screen_utils: ^0.0.3
```
### Add the following imports to your Dart code:
```dart
import 'package:responsive_screen_utils/responsive_screen_utils.dart';
```

### Property
   
|Property|Type|Default Value|Description|
|:---|:---|:---|:---| 
|designSize|Size|Size(360, 690)|The size of the device in the design draft, in dp|
|allowFontScaling|bool|false|Sets whether the font size is scaled according to the system's "font size" assist option|

### Initialize and set the fit size and font size to scale according to the system's "font size" accessibility option

Please set the size of the design draft before use, the width and height of the design draft. This is typically done at the root of your application.

```dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (e.g., the screen size of the device in the design draft, in dp)
    //Default is Size(360, 690)
    return ResponsiveScreenUtilInit(
      designSize: Size(375, 812), // Example: iPhone X dimensions
      allowFontScaling: true, // Allows font scaling based on system settings
      builder: (context, child) {
        return MaterialApp(
          title: 'Responsive App',
          home: MyHomePage(),
          // It's good practice to ensure the child of ResponsiveScreenUtilInit is used.
          // If you have a builder, ensure it returns the child or incorporates it.
        );
      },
      // If you don't need a builder, you can directly pass the child widget.
      // child: MaterialApp(
      //   title: 'Responsive App',
      //   home: MyHomePage(),
      // ),
    );
  }
}
```

**Explanation of `ResponsiveScreenUtilInit` properties:**

*   `designSize`: This is the `Size` (width, height) of the screen that your UI was designed for. For example, if your designer provided mockups for an iPhone X, you might use `Size(375, 812)`.
*   `allowFontScaling`: If set to `true`, font sizes will scale according to the user's system-level text size settings. If `false`, font sizes will be fixed based on your design.
*   `builder`: An optional builder function that provides `context` and `child`. This is useful if you need to access `BuildContext` immediately within the `MaterialApp` or similar root widget. If you don't need a builder, you can directly provide a `child` widget.

### How it Works

The library calculates scaling factors based on the `designSize` you provide and the actual screen size of the device it's running on. It then provides extension methods and utility functions to convert your design dimensions (in dp) and font sizes (in sp) into dimensions that are appropriate for the current device's screen.

**Core Concepts:**

*   **`.w` (width extension):** Scales a number based on the screen width. `100.w` means a width that occupies the same proportion of the screen as 100dp would on your design screen width.
*   **`.h` (height extension):** Scales a number based on the screen height. `100.h` means a height that occupies the same proportion of the screen as 100dp would on your design screen height.
*   **`.r` (radius/adaptive extension):** Scales a number based on the smaller of the width or height scaling factors. This is useful for creating elements like circles or squares that should maintain their aspect ratio and scale proportionally.
*   **`.sp` (scalable pixel for fonts):** Scales font sizes. If `allowFontScaling` (globally or locally) is true, it also considers the system's text scaling factor.
*   **`.sw` (screen width fraction):** `1.sw` is the full screen width. `0.5.sw` is 50% of the screen width.
*   **`.sh` (screen height fraction):** `1.sh` is the full screen height. `0.5.sh` is 50% of the screen height.

**Example: Creating a Responsive Widget**

Let's say your design has a container that is 150dp wide and 100dp high, with a text font size of 16sp.

```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Responsive Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150.w, // Adapts to screen width
              height: 100.h, // Adapts to screen height
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(
                'Responsive Box',
                style: TextStyle(
                  fontSize: 16.sp, // Adapts font size
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.h), // Responsive spacing
            Container(
              width: 200.r, // Adapts using the smaller scale factor (width or height)
              height: 200.r, // Ensures it's a square that scales proportionally
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                'Adaptive Square (200.r)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.ssp, // Font scales with system settings
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Screen Width: ${1.sw.toStringAsFixed(2)}dp (${ResponsiveScreenUtil().screenWidth.toStringAsFixed(2)} physical pixels)',
            ),
            Text(
              'Screen Height: ${1.sh.toStringAsFixed(2)}dp (${ResponsiveScreenUtil().screenHeight.toStringAsFixed(2)} physical pixels)',
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Text(
                'This text has responsive padding.',
                style: TextStyle(fontSize: 12.nsp), // Font does NOT scale with system settings
              ),
            )
          ],
        ),
      ),
    );
  }
}
```

### Use：

### API

#### Pass the dp size of the design draft

```dart
    ResponsiveScreenUtil().setWidth(540.0)  (dart sdk>=2.6 : 540.w) //Adapted to screen width
    ResponsiveScreenUtil().setHeight(200.0) (dart sdk>=2.6 : 200.h) //Adapted to screen height , under normal circumstances, the height still uses x.w
    ResponsiveScreenUtil().radius(200.0) (dart sdk>=2.6 : 200.r)    //Adapt according to the smaller of width or height
    ResponsiveScreenUtil().setSp(24.0)      (dart sdk>=2.6 : 24.sp) //Adapter font
    ResponsiveScreenUtil().setSp(24.0, allowFontScalingSelf: true)  (dart sdk>=2.6 : 24.ssp) //Adapter font (font size will scale to respect Text Size accessibility settings if `allowFontScaling` in `ResponsiveScreenUtil.init` is true OR `allowFontScalingSelf` is true)
    ResponsiveScreenUtil().setSp(24.0, allowFontScalingSelf: false) (dart sdk>=2.6 : 24.nsp) //Adapter font (font size will NOT scale to respect Text Size accessibility settings, overriding global `allowFontScaling`)

    ResponsiveScreenUtil().pixelRatio       //Device pixel density
    ResponsiveScreenUtil().screenWidth   (dart sdk>=2.6 : 1.sw)    //Device width
    ResponsiveScreenUtil().screenHeight  (dart sdk>=2.6 : 1.sh)    //Device height
    ResponsiveScreenUtil().bottomBarHeight  //Bottom safe zone distance, suitable for buttons with full screen
    ResponsiveScreenUtil().statusBarHeight  //Status bar height , Notch will be higher
    ResponsiveScreenUtil().textScaleFactor  //System font scaling factor

    ResponsiveScreenUtil().scaleWidth //The ratio of actual width to UI design
    ResponsiveScreenUtil().scaleHeight //The ratio of actual height to UI design

    0.2.sw  //0.2 times the screen width
    0.5.sh  //50% of screen height
```

#### Adapt screen size：

Pass the dp size of the design draft((The unit is the same as the unit at initialization))：

Adapted to screen width: `ResponsiveScreenUtil().setWidth(540)`,

Adapted to screen height: `ResponsiveScreenUtil().setHeight(200)`, In general, the height is best to adapt to the width

If your dart sdk>=2.6, you can use extension functions:

example:

instead of :
```dart
Container(
width: ResponsiveScreenUtil().setWidth(50.0),
height:ResponsiveScreenUtil().setHeight(200.0),
)
```
you can use it like this:
```dart
Container(
width: 50.w,
height:200.h
)
```
**Note** 

The height can also use setWidth to ensure that it is not deformed(when you want a square)

The `setHeight` method (or `.h` extension) is mainly to adapt to the height. This is useful when you want a UI element to occupy a specific proportion of the screen height, regardless of the width.

Generally speaking, `50.w` might not be equal to `50.h` in terms of actual pixel values if the screen aspect ratio is different from your design's aspect ratio. Use `.r` for elements that need to scale uniformly (e.g., circles, squares that must remain square).

```dart
//for example:

///If you want to display a square:
///The UI may show a rectangle:
Container(
           width: 375.0.w,
           height: 375.0.h,
            ),
            
////If you want to display a square:
Container(
           width: 300.0.w,
           height: 300.0.w,
            ),

or

Container(
           width: 300.0.r,
           height: 300.0.r,
            ),
```


#### Adapter font:
``` dart
//Incoming font size(The unit is the same as the unit at initialization), fonts will not scale to respect Text Size accessibility settings
//(AllowallowFontScaling when initializing ResponsiveScreenUtil)
ResponsiveScreenUtil().setSp(28) 
28.sp   
     
//Incoming font size，the unit is pixel，fonts will scale to respect Text Size accessibility settings
//(If somewhere follow the global allowFontScaling setting)
ResponsiveScreenUtil().setSp(24, allowFontScalingSelf: true)
28.ssp

//(If somewhere does not follow the global allowFontScaling setting)
ResponsiveScreenUtil().setSp(24, allowFontScalingSelf: false)
28.nsp

//for example:
Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'My font size is 24dp on the design draft and will not change with the system.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: ResponsiveScreenUtil().setSp(24),
                    )),
                Text(
                    'My font size is 24dp on the design draft and will change with the system.',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ResponsiveScreenUtil()
                            .setSp(24, allowFontScalingSelf: true))),
              ],
            )
```

