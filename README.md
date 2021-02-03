# responsive_screen_utils

**A flutter plugin for adapting screen, dynamic width and height and font size.Let your UI display a reasonable layout on different screen sizes!**

*Note*: responsive_screen_utils plugin is still under development, and some APIs might not be available yet.

[github](https://github.com/infoskillstechnology/responsive_screen_utils.git)

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
  responsive_screen_utils: ^{latest version}
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
Please set the size of the design draft before use, the width and height of the design draft.

```dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design,in dp)
    return ResponsiveScreenUtilInit(
      designSize: Size(360, 690),
      allowFontScaling: false,
      child: MaterialApp(
        ...
      ),
    );
  }
}
```

### Use：

### API

#### Pass the dp size of the design draft

```dart
    ResponsiveScreenUtil().setWidth(540)  (dart sdk>=2.6 : 540.w) //Adapted to screen width
    ResponsiveScreenUtil().setHeight(200) (dart sdk>=2.6 : 200.h) //Adapted to screen height , under normal circumstances, the height still uses x.w
    ResponsiveScreenUtil().radius(200) (dart sdk>=2.6 : 200.r)    //Adapt according to the smaller of width or height
    ResponsiveScreenUtil().setSp(24)      (dart sdk>=2.6 : 24.sp) //Adapter font
    ResponsiveScreenUtil().setSp(24, allowFontScalingSelf: true)  (dart sdk>=2.6 : 24.ssp) //Adapter font(fonts will scale to respect Text Size accessibility settings)
    ResponsiveScreenUtil().setSp(24, allowFontScalingSelf: false) (dart sdk>=2.6 : 24.nsp) //Adapter font(fonts will not scale to respect Text Size accessibility settings)

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
width: ResponsiveScreenUtil().setWidth(50),
height:ResponsiveScreenUtil().setHeight(200),
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

The setHeight method is mainly to adapt to the height, which is used when you want to control the height of a screen on the UI to be the same as the actual display.

Generally speaking, 50.w!=50.h.

```dart
//for example:

///If you want to display a square:
///The UI may show a rectangle:
Container(
           width: 375.w,
           height: 375.h,
            ),
            
////If you want to display a square:
Container(
           width: 300.w,
           height: 300.w,
            ),

or

Container(
           width: 300.r,
           height: 300.r,
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

