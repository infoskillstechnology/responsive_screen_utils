import 'package:flutter/material.dart';
import 'package:responsive_screen_utils/responsive_screen_utils.dart';

void main() {
  runApp(MyApp());
}

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
          debugShowCheckedModeBanner: false,
          title: 'Responsive Screen Utils Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: 14.sp), // Default body text
            ),
          ),
          home: MyHomePage(title: 'Responsive Screen Utils Demo'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // It's good practice to call this once, perhaps in a splash screen or early in initState.
    // However, for demo purposes, calling it here shows the values immediately.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      printScreenInformation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontSize: 18.sp)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w), // Responsive padding for the whole scroll view
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Make children take full width
          children: <Widget>[
            // Example from README: Responsive Box and Adaptive Square
            Container(
              width: 150.w, // Adapts to screen width
              height: 100.h, // Adapts to screen height
              margin: EdgeInsets.only(bottom: 10.h),
              color: Colors.blueAccent,
              alignment: Alignment.center,
              child: Text(
                'Responsive Box\n150.w x 100.h',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp, // Adapts font size
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: 180.r, // Adapts using the smaller scale factor (width or height)
              height: 180.r, // Ensures it's a square that scales proportionally
              margin: EdgeInsets.only(bottom: 10.h),
              color: Colors.greenAccent,
              alignment: Alignment.center,
              child: Text(
                'Adaptive Square\n(180.r)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.ssp, // Font scales with system settings
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                'This text has responsive padding (10.h vertical, 0 horizontal within this Text). Font size 12.nsp (non-scalable).',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12.nsp, color: Colors.black54),
              ),
            ),
            Divider(height: 20.h, thickness: 1.h, color: Colors.grey.shade300),
            _buildInfoSection(),
            SizedBox(height: 20.h),
            _buildFontScalingDemo(),
            SizedBox(height: 20.h),
            // Original Demo Elements (adapted and restyled)
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    height: 150.h,
                    margin: EdgeInsets.only(right: 4.w),
                    color: Colors.redAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '0.5 Screen Width Container',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Actual width: ${0.5.sw.toStringAsFixed(1)}dp\nActual height: ${150.0.h.toStringAsFixed(1)}dp',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 9.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveScreenUtil().setWidth(8)), // Using direct method call
                    height: ResponsiveScreenUtil().setHeight(150), // Using direct method call
                    margin: EdgeInsets.only(left: 4.w),
                    color: Colors.purpleAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Fixed Design Values',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'Design width: 180dp\nDesign height: 150dp',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: ResponsiveScreenUtil().setSp(9)), // Using direct method call
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                textStyle: TextStyle(fontSize: 16.sp),
              ),
              onPressed: printScreenInformation,
              child: Text('Print Screen Info to Console'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      elevation: 2.r,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Screen Information:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            _infoText('Design Size (for lib):', '${ResponsiveScreenUtil().uiSize.width.toStringAsFixed(0)}w x ${ResponsiveScreenUtil().uiSize.height.toStringAsFixed(0)}h'),
            _infoText('Device Screen Width:', '${ResponsiveScreenUtil().screenWidth.toStringAsFixed(2)} dp (${1.sw.toStringAsFixed(2)} sw)'),
            _infoText('Device Screen Height:', '${ResponsiveScreenUtil().screenHeight.toStringAsFixed(2)} dp (${1.sh.toStringAsFixed(2)} sh)'),
            _infoText('Pixel Density:', '${ResponsiveScreenUtil().pixelRatio.toStringAsFixed(2)}'),
            _infoText('Status Bar Height:', '${ResponsiveScreenUtil().statusBarHeight.toStringAsFixed(2)} dp'),
            _infoText('Bottom Bar Height:', '${ResponsiveScreenUtil().bottomBarHeight.toStringAsFixed(2)} dp'),
            _infoText('Text Scale Factor:', '${ResponsiveScreenUtil().textScaleFactor.toStringAsFixed(2)}'),
            _infoText('Scale Width Factor:', '${ResponsiveScreenUtil().scaleWidth.toStringAsFixed(2)}'),
            _infoText('Scale Height Factor:', '${ResponsiveScreenUtil().scaleHeight.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildFontScalingDemo() {
    return Card(
      elevation: 2.r,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Font Scaling Examples (Base size: 16):', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.h),
            Text(
              '16.sp: Scales with global `allowFontScaling` (${ResponsiveScreenUtil().allowFontScaling}). Current size: ${(16.sp).toStringAsFixed(1)}', 
              style: TextStyle(fontSize: 16.sp)
            ),
            SizedBox(height: 4.h),
            Text(
              '16.ssp: Forces scaling with system text size. Current size: ${(16.ssp).toStringAsFixed(1)}', 
              style: TextStyle(fontSize: 16.ssp)
            ),
            SizedBox(height: 4.h),
            Text(
              '16.nsp: Forces NO scaling with system text size. Current size: ${(16.nsp).toStringAsFixed(1)}', 
              style: TextStyle(fontSize: 16.nsp)
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoText(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label, style: TextStyle(fontSize: 11.sp, color: Colors.black87)),
          Text(value, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
        ],
      ),
    );
  }

  void printScreenInformation() {
    print('--- Responsive Screen Utils ---');
    print('Design Size (for lib): ${ResponsiveScreenUtil().uiSize.width.toStringAsFixed(0)}w x ${ResponsiveScreenUtil().uiSize.height.toStringAsFixed(0)}h');
    print('Device width dp: ${1.0.sw}dp (${ResponsiveScreenUtil().screenWidth.toStringAsFixed(2)} physical pixels)');
    print('Device height dp: ${1.0.sh}dp (${ResponsiveScreenUtil().screenHeight.toStringAsFixed(2)} physical pixels)');
    print('Device pixel density: ${ResponsiveScreenUtil().pixelRatio}');
    print('Bottom safe zone distance dp: ${ResponsiveScreenUtil().bottomBarHeight.toStringAsFixed(2)}dp');
    print('Status bar height dp: ${ResponsiveScreenUtil().statusBarHeight.toStringAsFixed(2)}dp');
    print('The ratio of actual width to UI design (scaleWidth): ${ResponsiveScreenUtil().scaleWidth.toStringAsFixed(2)}');
    print('The ratio of actual height to UI design (scaleHeight): ${ResponsiveScreenUtil().scaleHeight.toStringAsFixed(2)}');
    print('System font scaling factor (textScaleFactor): ${ResponsiveScreenUtil().textScaleFactor}');
    print('Global allowFontScaling: ${ResponsiveScreenUtil().allowFontScaling}');
    print('0.5 times the screen width: ${0.5.sw.toStringAsFixed(2)}dp');
    print('0.5 times the screen height: ${0.5.sh.toStringAsFixed(2)}dp');
    print('Font 16.sp: ${16.sp.toStringAsFixed(2)}');
    print('Font 16.ssp: ${16.ssp.toStringAsFixed(2)}');
    print('Font 16.nsp: ${16.nsp.toStringAsFixed(2)}');
    print('-----------------------------');
  }
}
