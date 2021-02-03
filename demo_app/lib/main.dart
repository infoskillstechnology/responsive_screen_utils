import 'package:flutter/material.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveScreenUtilInit(
      designSize: Size(360, 690),
      allowFontScaling: false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Responsive Screen Utils Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Responsive Screen Utils Demo'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)

    printScreenInformation();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                // Using Extensions
                Container(
                  padding: EdgeInsets.all(10.0.w),
                  width: 0.5.sw,
                  height: 200.0.h,
                  color: Colors.red,
                  child: Text(
                    'My actual width: ${0.5.sw}dp \n\n'
                        'My actual height: ${200.0.h}dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0.sp,
                    ),
                  ),
                ),
                // Without using Extensions
                Container(
                  padding: EdgeInsets.all(ResponsiveScreenUtil().setWidth(10)),
                  width: ResponsiveScreenUtil().setWidth(180),
                  height: ResponsiveScreenUtil().setHeight(200),
                  color: Colors.blue,
                  child: Text(
                    'My design draft width: 180dp\n\n'
                        'My design draft height: 200dp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ResponsiveScreenUtil().setSp(12),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(ResponsiveScreenUtil().setWidth(10)),
              width: 100.0.r,
              height: 100.0.r,
              color: Colors.green,
              child: Text('I am a square with a side length of 100',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveScreenUtil().setSp(12),
                ),
              ),
            ),
            Text('Device width:${ResponsiveScreenUtil().screenWidth}dp'),
            Text('Device height:${ResponsiveScreenUtil().screenHeight}dp'),
            Text('Device pixel density:${ResponsiveScreenUtil().pixelRatio}'),
            Text('Bottom safe zone distance:${ResponsiveScreenUtil().bottomBarHeight}dp'),
            Text('Status bar height:${ResponsiveScreenUtil().statusBarHeight}dp'),
            Text(
              'The ratio of actual width to UI design:${ResponsiveScreenUtil().scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              'The ratio of actual height to UI design:${ResponsiveScreenUtil().scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50.0.h,
            ),
            Text('System font scaling factor:${ResponsiveScreenUtil().textScaleFactor}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 32.0.h,
                  child: Text(
                    'My font size is 16sp on the design draft and will not change with the system.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0.sp,
                    ),
                  ),
                ),
                Text(
                  'My font size is 16sp on the design draft and will change with the system.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0.ssp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void printScreenInformation() {
    print('Device width dp:${1.0.sw}dp');
    print('Device height dp:${1.0.sh}dp');
    print('Device pixel density:${ResponsiveScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp:${ResponsiveScreenUtil().bottomBarHeight}dp');
    print('Status bar height dp:${ResponsiveScreenUtil().statusBarHeight}dp');
    print('The ratio of actual width to UI design:${ResponsiveScreenUtil().scaleWidth}');
    print('The ratio of actual height to UI design:${ResponsiveScreenUtil().scaleHeight}');
    print('System font scaling:${ResponsiveScreenUtil().textScaleFactor}');
    print('0.5 times the screen width:${0.5.sw}dp');
    print('0.5 times the screen height:${0.5.sh}dp');
  }


}
