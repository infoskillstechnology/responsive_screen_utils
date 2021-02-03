import 'responsive_screenutil.dart';

extension SizeExtension on double {

  ///[ResponsiveScreenUtil.setWidth]
  double get w => ResponsiveScreenUtil().setWidth(this);

  ///[ResponsiveScreenUtil.setHeight]
  double get h => ResponsiveScreenUtil().setHeight(this);

  ///[ResponsiveScreenUtil.radius]
  double get r => ResponsiveScreenUtil().radius(this);

  ///[ResponsiveScreenUtil.setSp]
  double get sp => ResponsiveScreenUtil().setSp(this);

  ///[ResponsiveScreenUtil.setSp]
  double get ssp => ResponsiveScreenUtil().setSp(this, allowFontScalingSelf: true);

  ///[ResponsiveScreenUtil.setSp]
  double get nsp => ResponsiveScreenUtil().setSp(this, allowFontScalingSelf: false);

  ///Multiple of screen width
  double get sw => ResponsiveScreenUtil().screenWidth * this;

  ///Multiple of screen height
  double get sh => ResponsiveScreenUtil().screenHeight * this;


}