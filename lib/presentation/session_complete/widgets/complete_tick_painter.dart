//Add this CustomPaint widget to the Widget Tree
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// CustomPaint(
// size: Size(WIDTH, (WIDTH*0.9595375722543352).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class CompleteTickPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
paint_0_fill.shader = ui.Gradient.linear(Offset(size.width*0.5028902,size.height*0.09638554), Offset(size.width*0.5028902,size.height*0.8915663), [Colors.white.withOpacity(1),Color(0xffCBCBCB).withOpacity(1)], [0.226264,1]);
canvas.drawCircle(Offset(size.width*0.5028902,size.height*0.4939759),size.width*0.3815029,paint_0_fill);

Paint paint_1_fill = Paint()..style=PaintingStyle.fill;
paint_1_fill.color = Colors.white.withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.05780347,size.height*0.1445783),size.width*0.05780347,paint_1_fill);

Paint paint_2_fill = Paint()..style=PaintingStyle.fill;
paint_2_fill.color = Colors.white.withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.9421965,size.height*0.3373494),size.width*0.05780347,paint_2_fill);

Paint paint_3_fill = Paint()..style=PaintingStyle.fill;
paint_3_fill.color = Color(0xff7A7A7A).withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.4913295,size.height*0.02409639),size.width*0.02312139,paint_3_fill);

Paint paint_4_fill = Paint()..style=PaintingStyle.fill;
paint_4_fill.color = Color(0xff7A7A7A).withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.1387283,size.height*0.8012048),size.width*0.02312139,paint_4_fill);

Paint paint_5_fill = Paint()..style=PaintingStyle.fill;
paint_5_fill.color = Color(0xff7A7A7A).withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.8843931,size.height*0.8012048),size.width*0.02312139,paint_5_fill);

Paint paint_6_fill = Paint()..style=PaintingStyle.fill;
paint_6_fill.color = Colors.white.withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.5000000,size.height*0.9849398),size.width*0.01445087,paint_6_fill);

Path path_7 = Path();
path_7.moveTo(size.width*0.5028902,size.height*0.6288916);
path_7.cubicTo(size.width*0.4314786,size.height*0.6288916,size.width*0.3734341,size.height*0.5683994,size.width*0.3734341,size.height*0.4939765);
path_7.cubicTo(size.width*0.3734341,size.height*0.4195536,size.width*0.4314786,size.height*0.3590614,size.width*0.5028902,size.height*0.3590614);
path_7.cubicTo(size.width*0.5743012,size.height*0.3590614,size.width*0.6323468,size.height*0.4195536,size.width*0.6323468,size.height*0.4939765);
path_7.cubicTo(size.width*0.6323468,size.height*0.5683994,size.width*0.5743012,size.height*0.6288916,size.width*0.5028902,size.height*0.6288916);
path_7.close();
path_7.moveTo(size.width*0.5028902,size.height*0.3778867);
path_7.cubicTo(size.width*0.4414740,size.height*0.3778867,size.width*0.3914977,size.height*0.4299705,size.width*0.3914977,size.height*0.4939765);
path_7.cubicTo(size.width*0.3914977,size.height*0.5579825,size.width*0.4414740,size.height*0.6100663,size.width*0.5028902,size.height*0.6100663);
path_7.cubicTo(size.width*0.5643064,size.height*0.6100663,size.width*0.6142832,size.height*0.5579825,size.width*0.6142832,size.height*0.4939765);
path_7.cubicTo(size.width*0.6142832,size.height*0.4299705,size.width*0.5643064,size.height*0.3778867,size.width*0.5028902,size.height*0.3778867);
path_7.close();

Paint paint_7_fill = Paint()..style=PaintingStyle.fill;
paint_7_fill.color = Colors.black.withOpacity(1.0);
canvas.drawPath(path_7,paint_7_fill);

Path path_8 = Path();
path_8.moveTo(size.width*0.4857902,size.height*0.5389313);
path_8.cubicTo(size.width*0.4833954,size.height*0.5389289,size.width*0.4811000,size.height*0.5379355,size.width*0.4794075,size.height*0.5361699);
path_8.lineTo(size.width*0.4453277,size.height*0.5006530);
path_8.cubicTo(size.width*0.4436480,size.height*0.4988819,size.width*0.4427058,size.height*0.4964916,size.width*0.4427058,size.height*0.4940012);
path_8.cubicTo(size.width*0.4427058,size.height*0.4915108,size.width*0.4436480,size.height*0.4891211,size.width*0.4453277,size.height*0.4873500);
path_8.cubicTo(size.width*0.4488197,size.height*0.4837102,size.width*0.4546000,size.height*0.4837102,size.width*0.4580925,size.height*0.4873500);
path_8.lineTo(size.width*0.4857902,size.height*0.5162151);
path_8.lineTo(size.width*0.5476879,size.height*0.4517072);
path_8.cubicTo(size.width*0.5511803,size.height*0.4480675,size.width*0.5569607,size.height*0.4480675,size.width*0.5604526,size.height*0.4517072);
path_8.cubicTo(size.width*0.5639451,size.height*0.4553470,size.width*0.5639451,size.height*0.4613711,size.width*0.5604526,size.height*0.4650102);
path_8.lineTo(size.width*0.4921723,size.height*0.5361699);
path_8.cubicTo(size.width*0.4904803,size.height*0.5379355,size.width*0.4881844,size.height*0.5389289,size.width*0.4857902,size.height*0.5389313);
path_8.close();

Paint paint_8_fill = Paint()..style=PaintingStyle.fill;
paint_8_fill.color = Colors.black.withOpacity(1.0);
canvas.drawPath(path_8,paint_8_fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}