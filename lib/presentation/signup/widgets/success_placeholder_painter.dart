
import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
// size: Size(WIDTH, (WIDTH*0.9595375722543352).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class SuccessPlaceholderPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.color = Colors.black.withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.5028902,size.height*0.4939759),size.width*0.3815029,paint0Fill);

Path path_1 = Path();
path_1.moveTo(size.width*0.6112948,size.height*0.6189759);
path_1.cubicTo(size.width*0.6112948,size.height*0.5694355,size.width*0.5640035,size.height*0.5293675,size.width*0.5057809,size.height*0.5293675);
path_1.cubicTo(size.width*0.4475584,size.height*0.5293675,size.width*0.4002676,size.height*0.5694355,size.width*0.4002676,size.height*0.6189759);
path_1.moveTo(size.width*0.5057809,size.height*0.4909639);
path_1.cubicTo(size.width*0.5220694,size.height*0.4909639,size.width*0.5376908,size.height*0.4842205,size.width*0.5492087,size.height*0.4722169);
path_1.cubicTo(size.width*0.5607266,size.height*0.4602133,size.width*0.5671971,size.height*0.4439331,size.width*0.5671971,size.height*0.4269578);
path_1.cubicTo(size.width*0.5671971,size.height*0.4099825,size.width*0.5607266,size.height*0.3937024,size.width*0.5492087,size.height*0.3816988);
path_1.cubicTo(size.width*0.5376908,size.height*0.3696952,size.width*0.5220694,size.height*0.3629518,size.width*0.5057809,size.height*0.3629518);
path_1.cubicTo(size.width*0.4894925,size.height*0.3629518,size.width*0.4738711,size.height*0.3696952,size.width*0.4623532,size.height*0.3816988);
path_1.cubicTo(size.width*0.4508353,size.height*0.3937024,size.width*0.4443647,size.height*0.4099825,size.width*0.4443647,size.height*0.4269578);
path_1.cubicTo(size.width*0.4443647,size.height*0.4439331,size.width*0.4508353,size.height*0.4602133,size.width*0.4623532,size.height*0.4722169);
path_1.cubicTo(size.width*0.4738711,size.height*0.4842205,size.width*0.4894925,size.height*0.4909639,size.width*0.5057809,size.height*0.4909639);
path_1.close();

Paint paint1Stroke = Paint()..style=PaintingStyle.stroke..strokeWidth=size.width*0.008670520;
paint1Stroke.color=Colors.white.withOpacity(1.0);
paint1Stroke.strokeCap = StrokeCap.round;
paint1Stroke.strokeJoin = StrokeJoin.round;
canvas.drawPath(path_1,paint1Stroke);

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.color = const Color(0xff000000).withOpacity(1.0);
canvas.drawPath(path_1,paint1Fill);

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.color = Colors.black.withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.05780347,size.height*0.1445783),size.width*0.05780347,paint2Fill);

Paint paint3Fill = Paint()..style=PaintingStyle.fill;
paint3Fill.color = Colors.black.withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.9421965,size.height*0.3373494),size.width*0.05780347,paint3Fill);

Paint paint4Fill = Paint()..style=PaintingStyle.fill;
paint4Fill.color = const Color(0xff3F3F3F).withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.4913295,size.height*0.02409639),size.width*0.02312139,paint4Fill);

Paint paint5Fill = Paint()..style=PaintingStyle.fill;
paint5Fill.color = const Color(0xff3F3F3F).withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.1387283,size.height*0.8012048),size.width*0.02312139,paint5Fill);

Paint paint6Fill = Paint()..style=PaintingStyle.fill;
paint6Fill.color = const Color(0xff3F3F3F).withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.8843931,size.height*0.8012048),size.width*0.02312139,paint6Fill);

Paint paint7Fill = Paint()..style=PaintingStyle.fill;
paint7Fill.color = Colors.black.withOpacity(1.0);
canvas.drawCircle(Offset(size.width*0.5000000,size.height*0.9849398),size.width*0.01445087,paint7Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}