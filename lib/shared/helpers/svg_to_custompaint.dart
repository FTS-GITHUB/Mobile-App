import 'dart:ui' as ui;

import 'package:flutter/material.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Path path_0 = Path();
path_0.moveTo(size.width*0.02126260,size.height*0.9905772);
path_0.lineTo(size.width*0.02126260,size.height*0.3529146);
path_0.lineTo(0,size.height*0.3529146);
path_0.lineTo(0,size.height*0.2276423);
path_0.lineTo(size.width*0.07372188,size.height*0.2276423);
path_0.lineTo(size.width*0.07372188,size.height*0.3529146);
path_0.lineTo(size.width*0.05263359,size.height*0.3529146);
path_0.lineTo(size.width*0.05263359,size.height*0.9905772);
path_0.lineTo(size.width*0.02126260,size.height*0.9905772);
path_0.close();

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_0,paint0Fill);

Path path_1 = Path();
path_1.moveTo(size.width*0.08475623,size.height*0.9905772);
path_1.lineTo(size.width*0.08475623,size.height*0.2276423);
path_1.lineTo(size.width*0.1129903,size.height*0.2276423);
path_1.lineTo(size.width*0.1129903,size.height*0.4942000);
path_1.cubicTo(size.width*0.1167084,size.height*0.4741057,size.width*0.1206008,size.height*0.4596634,size.width*0.1246672,size.height*0.4508724);
path_1.cubicTo(size.width*0.1287338,size.height*0.4414537,size.width*0.1330911,size.height*0.4367439,size.width*0.1377384,size.height*0.4367439);
path_1.cubicTo(size.width*0.1418051,size.height*0.4367439,size.width*0.1451746,size.height*0.4423951,size.width*0.1478471,size.height*0.4536984);
path_1.cubicTo(size.width*0.1506356,size.height*0.4643732,size.width*0.1527270,size.height*0.4794431,size.width*0.1541211,size.height*0.4989098);
path_1.cubicTo(size.width*0.1555155,size.height*0.5177472,size.width*0.1562127,size.height*0.5394114,size.width*0.1562127,size.height*0.5639008);
path_1.lineTo(size.width*0.1562127,size.height*0.9905772);
path_1.lineTo(size.width*0.1279786,size.height*0.9905772);
path_1.lineTo(size.width*0.1279786,size.height*0.5855642);
path_1.cubicTo(size.width*0.1279786,size.height*0.5723772,size.width*0.1275720,size.height*0.5623309,size.width*0.1267588,size.height*0.5554236);
path_1.cubicTo(size.width*0.1259453,size.height*0.5485163,size.width*0.1244349,size.height*0.5450626,size.width*0.1222272,size.height*0.5450626);
path_1.cubicTo(size.width*0.1210654,size.height*0.5450626,size.width*0.1196712,size.height*0.5469463,size.width*0.1180445,size.height*0.5507138);
path_1.cubicTo(size.width*0.1164178,size.height*0.5538537,size.width*0.1147331,size.height*0.5585634,size.width*0.1129903,size.height*0.5648423);
path_1.lineTo(size.width*0.1129903,size.height*0.9905772);
path_1.lineTo(size.width*0.08475623,size.height*0.9905772);
path_1.close();

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_1,paint1Fill);

Path path_2 = Path();
path_2.moveTo(size.width*0.2061952,size.height);
path_2.cubicTo(size.width*0.1988753,size.height,size.width*0.1926010,size.height*0.9930894,size.width*0.1873725,size.height*0.9792764);
path_2.cubicTo(size.width*0.1821440,size.height*0.9648374,size.width*0.1781356,size.height*0.9441138,size.width*0.1753471,size.height*0.9171138);
path_2.cubicTo(size.width*0.1725585,size.height*0.8894878,size.width*0.1711641,size.height*0.8565203,size.width*0.1711641,size.height*0.8182114);
path_2.lineTo(size.width*0.1711641,size.height*0.6185309);
path_2.cubicTo(size.width*0.1711641,size.height*0.5795984,size.width*0.1725585,size.height*0.5466325,size.width*0.1753471,size.height*0.5196309);
path_2.cubicTo(size.width*0.1781356,size.height*0.4926301,size.width*0.1821440,size.height*0.4722220,size.width*0.1873725,size.height*0.4584081);
path_2.cubicTo(size.width*0.1927173,size.height*0.4439650,size.width*0.1989916,size.height*0.4367439,size.width*0.2061952,size.height*0.4367439);
path_2.cubicTo(size.width*0.2136313,size.height*0.4367439,size.width*0.2197893,size.height*0.4436512,size.width*0.2246692,size.height*0.4574659);
path_2.cubicTo(size.width*0.2296654,size.height*0.4712805,size.width*0.2333835,size.height*0.4916878,size.width*0.2358234,size.height*0.5186894);
path_2.cubicTo(size.width*0.2383796,size.height*0.5456902,size.width*0.2396578,size.height*0.5789707,size.width*0.2396578,size.height*0.6185309);
path_2.lineTo(size.width*0.2396578,size.height*0.7277911);
path_2.lineTo(size.width*0.1992239,size.height*0.7277911);
path_2.lineTo(size.width*0.1992239,size.height*0.8323415);
path_2.cubicTo(size.width*0.1992239,size.height*0.8461545,size.width*0.1995142,size.height*0.8574553,size.width*0.2000954,size.height*0.8662520);
path_2.cubicTo(size.width*0.2006763,size.height*0.8750407,size.width*0.2014896,size.height*0.8813171,size.width*0.2025354,size.height*0.8850894);
path_2.cubicTo(size.width*0.2035809,size.height*0.8888537,size.width*0.2048010,size.height*0.8907398,size.width*0.2061952,size.height*0.8907398);
path_2.cubicTo(size.width*0.2075896,size.height*0.8907398,size.width*0.2088094,size.height*0.8891707,size.width*0.2098552,size.height*0.8860325);
path_2.cubicTo(size.width*0.2110170,size.height*0.8822602,size.width*0.2118885,size.height*0.8766098,size.width*0.2124695,size.height*0.8690732);
path_2.cubicTo(size.width*0.2131667,size.height*0.8615447,size.width*0.2135153,size.height*0.8511789,size.width*0.2135153,size.height*0.8379919);
path_2.lineTo(size.width*0.2135153,size.height*0.7805374);
path_2.lineTo(size.width*0.2396578,size.height*0.7805374);
path_2.lineTo(size.width*0.2396578,size.height*0.8332846);
path_2.cubicTo(size.width*0.2396578,size.height*0.8885447,size.width*0.2366949,size.height*0.9303008,size.width*0.2307692,size.height*0.9585528);
path_2.cubicTo(size.width*0.2248435,size.height*0.9861870,size.width*0.2166522,size.height,size.width*0.2061952,size.height);
path_2.close();
path_2.moveTo(size.width*0.1992239,size.height*0.6562065);
path_2.lineTo(size.width*0.2135153,size.height*0.6562065);
path_2.lineTo(size.width*0.2135153,size.height*0.6015764);
path_2.cubicTo(size.width*0.2135153,size.height*0.5871341,size.width*0.2131667,size.height*0.5758309,size.width*0.2124695,size.height*0.5676683);
path_2.cubicTo(size.width*0.2118885,size.height*0.5595049,size.width*0.2110170,size.height*0.5538537,size.width*0.2098552,size.height*0.5507138);
path_2.cubicTo(size.width*0.2088094,size.height*0.5475740,size.width*0.2075316,size.height*0.5460041,size.width*0.2060209,size.height*0.5460041);
path_2.cubicTo(size.width*0.2046267,size.height*0.5460041,size.width*0.2034066,size.height*0.5478878,size.width*0.2023611,size.height*0.5516561);
path_2.cubicTo(size.width*0.2014316,size.height*0.5554236,size.width*0.2006763,size.height*0.5620171,size.width*0.2000954,size.height*0.5714358);
path_2.cubicTo(size.width*0.1995142,size.height*0.5802268,size.width*0.1992239,size.height*0.5930992,size.width*0.1992239,size.height*0.6100537);
path_2.lineTo(size.width*0.1992239,size.height*0.6562065);
path_2.close();

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_2,paint2Fill);

Path path_3 = Path();
path_3.moveTo(size.width*0.3000611,size.height*0.9905772);
path_3.lineTo(size.width*0.3000611,size.height*0.4461634);
path_3.lineTo(size.width*0.3284707,size.height*0.4461634);
path_3.lineTo(size.width*0.3284707,size.height*0.5365854);
path_3.cubicTo(size.width*0.3317226,size.height*0.5051886,size.width*0.3349771,size.height*0.4813276,size.width*0.3382290,size.height*0.4650008);
path_3.cubicTo(size.width*0.3414835,size.height*0.4480472,size.width*0.3454326,size.height*0.4395699,size.width*0.3500814,size.height*0.4395699);
path_3.cubicTo(size.width*0.3510102,size.height*0.4395699,size.width*0.3518244,size.height*0.4398837,size.width*0.3525216,size.height*0.4405114);
path_3.cubicTo(size.width*0.3532188,size.height*0.4405114,size.width*0.3538575,size.height*0.4411398,size.width*0.3544377,size.height*0.4423951);
path_3.lineTo(size.width*0.3544377,size.height*0.5949829);
path_3.cubicTo(size.width*0.3531603,size.height*0.5918431,size.width*0.3517074,size.height*0.5893317,size.width*0.3500814,size.height*0.5874480);
path_3.cubicTo(size.width*0.3485700,size.height*0.5849366,size.width*0.3469440,size.height*0.5836805,size.width*0.3452010,size.height*0.5836805);
path_3.cubicTo(size.width*0.3419491,size.height*0.5836805,size.width*0.3389262,size.height*0.5883894,size.width*0.3361374,size.height*0.5978089);
path_3.cubicTo(size.width*0.3333511,size.height*0.6072276,size.width*0.3307939,size.height*0.6201008,size.width*0.3284707,size.height*0.6364268);
path_3.lineTo(size.width*0.3284707,size.height*0.9905772);
path_3.lineTo(size.width*0.3000611,size.height*0.9905772);
path_3.close();

Paint paint3Fill = Paint()..style=PaintingStyle.fill;
paint3Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_3,paint3Fill);

Path path_4 = Path();
path_4.moveTo(size.width*0.3993715,size.height);
path_4.cubicTo(size.width*0.3920509,size.height,size.width*0.3857761,size.height*0.9930894,size.width*0.3805471,size.height*0.9792764);
path_4.cubicTo(size.width*0.3753206,size.height*0.9648374,size.width*0.3713104,size.height*0.9441138,size.width*0.3685216,size.height*0.9171138);
path_4.cubicTo(size.width*0.3657354,size.height*0.8894878,size.width*0.3643410,size.height*0.8565203,size.width*0.3643410,size.height*0.8182114);
path_4.lineTo(size.width*0.3643410,size.height*0.6185309);
path_4.cubicTo(size.width*0.3643410,size.height*0.5795984,size.width*0.3657354,size.height*0.5466325,size.width*0.3685216,size.height*0.5196309);
path_4.cubicTo(size.width*0.3713104,size.height*0.4926301,size.width*0.3753206,size.height*0.4722220,size.width*0.3805471,size.height*0.4584081);
path_4.cubicTo(size.width*0.3858931,size.height*0.4439650,size.width*0.3921679,size.height*0.4367439,size.width*0.3993715,size.height*0.4367439);
path_4.cubicTo(size.width*0.4068066,size.height*0.4367439,size.width*0.4129644,size.height*0.4436512,size.width*0.4178448,size.height*0.4574659);
path_4.cubicTo(size.width*0.4228422,size.height*0.4712805,size.width*0.4265598,size.height*0.4916878,size.width*0.4290000,size.height*0.5186894);
path_4.cubicTo(size.width*0.4315547,size.height*0.5456902,size.width*0.4328346,size.height*0.5789707,size.width*0.4328346,size.height*0.6185309);
path_4.lineTo(size.width*0.4328346,size.height*0.7277911);
path_4.lineTo(size.width*0.3923995,size.height*0.7277911);
path_4.lineTo(size.width*0.3923995,size.height*0.8323415);
path_4.cubicTo(size.width*0.3923995,size.height*0.8461545,size.width*0.3926896,size.height*0.8574553,size.width*0.3932723,size.height*0.8662520);
path_4.cubicTo(size.width*0.3938524,size.height*0.8750407,size.width*0.3946641,size.height*0.8813171,size.width*0.3957099,size.height*0.8850894);
path_4.cubicTo(size.width*0.3967557,size.height*0.8888537,size.width*0.3979771,size.height*0.8907398,size.width*0.3993715,size.height*0.8907398);
path_4.cubicTo(size.width*0.4007659,size.height*0.8907398,size.width*0.4019847,size.height*0.8891707,size.width*0.4030305,size.height*0.8860325);
path_4.cubicTo(size.width*0.4041934,size.height*0.8822602,size.width*0.4050636,size.height*0.8766098,size.width*0.4056463,size.height*0.8690732);
path_4.cubicTo(size.width*0.4063435,size.height*0.8615447,size.width*0.4066896,size.height*0.8511789,size.width*0.4066896,size.height*0.8379919);
path_4.lineTo(size.width*0.4066896,size.height*0.7805374);
path_4.lineTo(size.width*0.4328346,size.height*0.7805374);
path_4.lineTo(size.width*0.4328346,size.height*0.8332846);
path_4.cubicTo(size.width*0.4328346,size.height*0.8885447,size.width*0.4298702,size.height*0.9303008,size.width*0.4239440,size.height*0.9585528);
path_4.cubicTo(size.width*0.4180204,size.height*0.9861870,size.width*0.4098270,size.height,size.width*0.3993715,size.height);
path_4.close();
path_4.moveTo(size.width*0.3923995,size.height*0.6562065);
path_4.lineTo(size.width*0.4066896,size.height*0.6562065);
path_4.lineTo(size.width*0.4066896,size.height*0.6015764);
path_4.cubicTo(size.width*0.4066896,size.height*0.5871341,size.width*0.4063435,size.height*0.5758309,size.width*0.4056463,size.height*0.5676683);
path_4.cubicTo(size.width*0.4050636,size.height*0.5595049,size.width*0.4041934,size.height*0.5538537,size.width*0.4030305,size.height*0.5507138);
path_4.cubicTo(size.width*0.4019847,size.height*0.5475740,size.width*0.4007074,size.height*0.5460041,size.width*0.3991959,size.height*0.5460041);
path_4.cubicTo(size.width*0.3978015,size.height*0.5460041,size.width*0.3965827,size.height*0.5478878,size.width*0.3955369,size.height*0.5516561);
path_4.cubicTo(size.width*0.3946081,size.height*0.5554236,size.width*0.3938524,size.height*0.5620171,size.width*0.3932723,size.height*0.5714358);
path_4.cubicTo(size.width*0.3926896,size.height*0.5802268,size.width*0.3923995,size.height*0.5930992,size.width*0.3923995,size.height*0.6100537);
path_4.lineTo(size.width*0.3923995,size.height*0.6562065);
path_4.close();

Paint paint4Fill = Paint()..style=PaintingStyle.fill;
paint4Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_4,paint4Fill);

Path path_5 = Path();
path_5.moveTo(size.width*0.4700814,size.height);
path_5.cubicTo(size.width*0.4626463,size.height,size.width*0.4568957,size.height*0.9858699,size.width*0.4528295,size.height*0.9576179);
path_5.cubicTo(size.width*0.4487608,size.height*0.9293577,size.width*0.4467277,size.height*0.8876016,size.width*0.4467277,size.height*0.8323415);
path_5.lineTo(size.width*0.4467277,size.height*0.6072276);
path_5.cubicTo(size.width*0.4467277,size.height*0.5733195,size.width*0.4476005,size.height*0.5438065,size.width*0.4493435,size.height*0.5186894);
path_5.cubicTo(size.width*0.4510865,size.height*0.4929439,size.width*0.4536997,size.height*0.4728504,size.width*0.4571858,size.height*0.4584081);
path_5.cubicTo(size.width*0.4606718,size.height*0.4439650,size.width*0.4649695,size.height*0.4367439,size.width*0.4700814,size.height*0.4367439);
path_5.cubicTo(size.width*0.4738015,size.height*0.4367439,size.width*0.4773435,size.height*0.4408252,size.width*0.4807150,size.height*0.4489886);
path_5.cubicTo(size.width*0.4840840,size.height*0.4565236,size.width*0.4871628,size.height*0.4668846,size.width*0.4899517,size.height*0.4800715);
path_5.lineTo(size.width*0.4862901,size.height*0.004065041);
path_5.lineTo(size.width*0.5183588,size.height*0.004065041);
path_5.lineTo(size.width*0.5183588,size.height*0.9905772);
path_5.lineTo(size.width*0.4899517,size.height*0.9905772);
path_5.lineTo(size.width*0.4899517,size.height*0.9481951);
path_5.cubicTo(size.width*0.4868142,size.height*0.9645203,size.width*0.4835598,size.height*0.9773984,size.width*0.4801908,size.height*0.9868130);
path_5.cubicTo(size.width*0.4768219,size.height*0.9956016,size.width*0.4734529,size.height,size.width*0.4700814,size.height);
path_5.close();
path_5.moveTo(size.width*0.4824555,size.height*0.9020407);
path_5.cubicTo(size.width*0.4833868,size.height*0.9020407,size.width*0.4844911,size.height*0.9007886,size.width*0.4857684,size.height*0.8982764);
path_5.cubicTo(size.width*0.4871628,size.height*0.8957642,size.width*0.4885573,size.height*0.8923089,size.width*0.4899517,size.height*0.8879106);
path_5.lineTo(size.width*0.4899517,size.height*0.5441203);
path_5.cubicTo(size.width*0.4887888,size.height*0.5409805,size.width*0.4875700,size.height*0.5381553,size.width*0.4862901,size.height*0.5356431);
path_5.cubicTo(size.width*0.4850127,size.height*0.5331317,size.width*0.4837939,size.height*0.5318756,size.width*0.4826310,size.height*0.5318756);
path_5.cubicTo(size.width*0.4800738,size.height*0.5318756,size.width*0.4782163,size.height*0.5378415,size.width*0.4770534,size.height*0.5497715);
path_5.cubicTo(size.width*0.4758931,size.height*0.5610748,size.width*0.4753104,size.height*0.5748894,size.width*0.4753104,size.height*0.5912154);
path_5.lineTo(size.width*0.4753104,size.height*0.8417642);
path_5.cubicTo(size.width*0.4753104,size.height*0.8530650,size.width*0.4755445,size.height*0.8634228,size.width*0.4760076,size.height*0.8728455);
path_5.cubicTo(size.width*0.4764733,size.height*0.8816341,size.width*0.4772290,size.height*0.8888537,size.width*0.4782748,size.height*0.8945041);
path_5.cubicTo(size.width*0.4793206,size.height*0.8995285,size.width*0.4807150,size.height*0.9020407,size.width*0.4824555,size.height*0.9020407);
path_5.close();

Paint paint5Fill = Paint()..style=PaintingStyle.fill;
paint5Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_5,paint5Fill);

Path path_6 = Path();
path_6.moveTo(size.width*0.6305598,size.height);
path_6.cubicTo(size.width*0.6268422,size.height,size.width*0.6231247,size.height*0.9956016,size.width*0.6194071,size.height*0.9868130);
path_6.cubicTo(size.width*0.6158041,size.height*0.9773984,size.width*0.6123181,size.height*0.9648374,size.width*0.6089491,size.height*0.9491382);
path_6.lineTo(size.width*0.6089491,size.height*0.9905772);
path_6.lineTo(size.width*0.5805420,size.height*0.9905772);
path_6.lineTo(size.width*0.5805420,size.height*0.004065041);
path_6.lineTo(size.width*0.6089491,size.height*0.004065041);
path_6.lineTo(size.width*0.6089491,size.height*0.4857228);
path_6.cubicTo(size.width*0.6124351,size.height*0.4693967,size.width*0.6160382,size.height*0.4571520,size.width*0.6197557,size.height*0.4489886);
path_6.cubicTo(size.width*0.6235903,size.height*0.4408252,size.width*0.6273079,size.height*0.4367439,size.width*0.6309084,size.height*0.4367439);
path_6.cubicTo(size.width*0.6347430,size.height*0.4367439,size.width*0.6379975,size.height*0.4408252,size.width*0.6406692,size.height*0.4489886);
path_6.cubicTo(size.width*0.6434580,size.height*0.4571520,size.width*0.6457226,size.height*0.4687683,size.width*0.6474656,size.height*0.4838390);
path_6.cubicTo(size.width*0.6492087,size.height*0.4982813,size.width*0.6504885,size.height*0.5152358,size.width*0.6513003,size.height*0.5347016);
path_6.cubicTo(size.width*0.6521145,size.height*0.5541675,size.width*0.6525216,size.height*0.5748894,size.width*0.6525216,size.height*0.5968667);
path_6.lineTo(size.width*0.6525216,size.height*0.8313984);
path_6.cubicTo(size.width*0.6525216,size.height*0.8653089,size.width*0.6516489,size.height*0.8948211,size.width*0.6499059,size.height*0.9199350);
path_6.cubicTo(size.width*0.6482799,size.height*0.9450569,size.width*0.6458397,size.height*0.9648374,size.width*0.6425852,size.height*0.9792764);
path_6.cubicTo(size.width*0.6393333,size.height*0.9930894,size.width*0.6353257,size.height,size.width*0.6305598,size.height);
path_6.close();
path_6.moveTo(size.width*0.6167913,size.height*0.9010976);
path_6.cubicTo(size.width*0.6186514,size.height*0.9010976,size.width*0.6201043,size.height*0.8982764,size.width*0.6211501,size.height*0.8926260);
path_6.cubicTo(size.width*0.6221959,size.height*0.8869756,size.width*0.6229517,size.height*0.8797480,size.width*0.6234148,size.height*0.8709593);
path_6.cubicTo(size.width*0.6238804,size.height*0.8615447,size.width*0.6241120,size.height*0.8511789,size.width*0.6241120,size.height*0.8398780);
path_6.lineTo(size.width*0.6241120,size.height*0.5855642);
path_6.cubicTo(size.width*0.6241120,size.height*0.5748894,size.width*0.6238804,size.height*0.5654699,size.width*0.6234148,size.height*0.5573073);
path_6.cubicTo(size.width*0.6229517,size.height*0.5485163,size.width*0.6221959,size.height*0.5416089,size.width*0.6211501,size.height*0.5365854);
path_6.cubicTo(size.width*0.6202188,size.height*0.5315618,size.width*0.6188830,size.height*0.5290504,size.width*0.6171399,size.height*0.5290504);
path_6.cubicTo(size.width*0.6156310,size.height*0.5290504,size.width*0.6141781,size.height*0.5309341,size.width*0.6127837,size.height*0.5347016);
path_6.cubicTo(size.width*0.6115064,size.height*0.5378415,size.width*0.6102290,size.height*0.5419228,size.width*0.6089491,size.height*0.5469463);
path_6.lineTo(size.width*0.6089491,size.height*0.8860325);
path_6.cubicTo(size.width*0.6102290,size.height*0.8904228,size.width*0.6115064,size.height*0.8941951,size.width*0.6127837,size.height*0.8973333);
path_6.cubicTo(size.width*0.6141781,size.height*0.8998455,size.width*0.6155140,size.height*0.9010976,size.width*0.6167913,size.height*0.9010976);
path_6.close();

Paint paint6Fill = Paint()..style=PaintingStyle.fill;
paint6Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_6,paint6Fill);

Path path_7 = Path();
path_7.moveTo(size.width*0.6864809,size.height);
path_7.cubicTo(size.width*0.6824148,size.height,size.width*0.6789288,size.height*0.9946585,size.width*0.6760254,size.height*0.9839837);
path_7.cubicTo(size.width*0.6732366,size.height*0.9726829,size.width*0.6711450,size.height*0.9573008,size.width*0.6697506,size.height*0.9378374);
path_7.cubicTo(size.width*0.6683562,size.height*0.9183659,size.width*0.6676590,size.height*0.8967073,size.width*0.6676590,size.height*0.8728455);
path_7.lineTo(size.width*0.6676590,size.height*0.4461634);
path_7.lineTo(size.width*0.6960662,size.height*0.4461634);
path_7.lineTo(size.width*0.6960662,size.height*0.8549512);
path_7.cubicTo(size.width*0.6960662,size.height*0.8681301,size.width*0.6964733,size.height*0.8784959,size.width*0.6972875,size.height*0.8860325);
path_7.cubicTo(size.width*0.6982163,size.height*0.8929350,size.width*0.6997863,size.height*0.8963902,size.width*0.7019924,size.height*0.8963902);
path_7.cubicTo(size.width*0.7032697,size.height*0.8963902,size.width*0.7046081,size.height*0.8948211,size.width*0.7060000,size.height*0.8916829);
path_7.cubicTo(size.width*0.7073944,size.height*0.8879106,size.width*0.7088473,size.height*0.8838293,size.width*0.7103588,size.height*0.8794390);
path_7.lineTo(size.width*0.7103588,size.height*0.4461634);
path_7.lineTo(size.width*0.7385929,size.height*0.4461634);
path_7.lineTo(size.width*0.7385929,size.height*0.9905772);
path_7.lineTo(size.width*0.7103588,size.height*0.9905772);
path_7.lineTo(size.width*0.7103588,size.height*0.9406585);
path_7.cubicTo(size.width*0.7067557,size.height*0.9588699,size.width*0.7029211,size.height*0.9733089,size.width*0.6988550,size.height*0.9839837);
path_7.cubicTo(size.width*0.6949059,size.height*0.9946585,size.width*0.6907812,size.height,size.width*0.6864809,size.height);
path_7.close();

Paint paint7Fill = Paint()..style=PaintingStyle.fill;
paint7Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_7,paint7Fill);

Path path_8 = Path();
path_8.moveTo(size.width*0.7567023,size.height*0.9905772);
path_8.lineTo(size.width*0.7567023,size.height*0.4461634);
path_8.lineTo(size.width*0.7851094,size.height*0.4461634);
path_8.lineTo(size.width*0.7851094,size.height*0.9905772);
path_8.lineTo(size.width*0.7567023,size.height*0.9905772);
path_8.close();
path_8.moveTo(size.width*0.7565267,size.height*0.3538569);
path_8.lineTo(size.width*0.7565267,size.height*0.2474220);
path_8.lineTo(size.width*0.7851094,size.height*0.2474220);
path_8.lineTo(size.width*0.7851094,size.height*0.3538569);
path_8.lineTo(size.width*0.7565267,size.height*0.3538569);
path_8.close();

Paint paint8Fill = Paint()..style=PaintingStyle.fill;
paint8Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_8,paint8Fill);

Path path_9 = Path();
path_9.moveTo(size.width*0.8038702,size.height*0.9905772);
path_9.lineTo(size.width*0.8038702,size.height*0.2276423);
path_9.lineTo(size.width*0.8321043,size.height*0.2276423);
path_9.lineTo(size.width*0.8321043,size.height*0.9905772);
path_9.lineTo(size.width*0.8038702,size.height*0.9905772);
path_9.close();

Paint paint9Fill = Paint()..style=PaintingStyle.fill;
paint9Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_9,paint9Fill);

Path path_10 = Path();
path_10.moveTo(size.width*0.8722621,size.height);
path_10.cubicTo(size.width*0.8648270,size.height,size.width*0.8590738,size.height*0.9858699,size.width*0.8550076,size.height*0.9576179);
path_10.cubicTo(size.width*0.8509415,size.height*0.9293577,size.width*0.8489084,size.height*0.8876016,size.width*0.8489084,size.height*0.8323415);
path_10.lineTo(size.width*0.8489084,size.height*0.6072276);
path_10.cubicTo(size.width*0.8489084,size.height*0.5733195,size.width*0.8497786,size.height*0.5438065,size.width*0.8515216,size.height*0.5186894);
path_10.cubicTo(size.width*0.8532646,size.height*0.4929439,size.width*0.8558804,size.height*0.4728504,size.width*0.8593664,size.height*0.4584081);
path_10.cubicTo(size.width*0.8628499,size.height*0.4439650,size.width*0.8671501,size.height*0.4367439,size.width*0.8722621,size.height*0.4367439);
path_10.cubicTo(size.width*0.8759796,size.height*0.4367439,size.width*0.8795242,size.height*0.4408252,size.width*0.8828931,size.height*0.4489886);
path_10.cubicTo(size.width*0.8862621,size.height*0.4565236,size.width*0.8893410,size.height*0.4668846,size.width*0.8921298,size.height*0.4800715);
path_10.lineTo(size.width*0.8921298,size.height*0.2276423);
path_10.lineTo(size.width*0.9205394,size.height*0.2276423);
path_10.lineTo(size.width*0.9205394,size.height*0.9905772);
path_10.lineTo(size.width*0.8921298,size.height*0.9905772);
path_10.lineTo(size.width*0.8921298,size.height*0.9481951);
path_10.cubicTo(size.width*0.8889924,size.height*0.9645203,size.width*0.8857405,size.height*0.9773984,size.width*0.8823715,size.height*0.9868130);
path_10.cubicTo(size.width*0.8790025,size.height*0.9956016,size.width*0.8756310,size.height,size.width*0.8722621,size.height);
path_10.close();
path_10.moveTo(size.width*0.8846361,size.height*0.9020407);
path_10.cubicTo(size.width*0.8855649,size.height*0.9020407,size.width*0.8866692,size.height*0.9007886,size.width*0.8879491,size.height*0.8982764);
path_10.cubicTo(size.width*0.8893410,size.height*0.8957642,size.width*0.8907354,size.height*0.8923089,size.width*0.8921298,size.height*0.8879106);
path_10.lineTo(size.width*0.8921298,size.height*0.5441203);
path_10.cubicTo(size.width*0.8909695,size.height*0.5409805,size.width*0.8897481,size.height*0.5381553,size.width*0.8884707,size.height*0.5356431);
path_10.cubicTo(size.width*0.8871934,size.height*0.5331317,size.width*0.8859720,size.height*0.5318756,size.width*0.8848117,size.height*0.5318756);
path_10.cubicTo(size.width*0.8822545,size.height*0.5318756,size.width*0.8803944,size.height*0.5378415,size.width*0.8792341,size.height*0.5497715);
path_10.cubicTo(size.width*0.8780712,size.height*0.5610748,size.width*0.8774911,size.height*0.5748894,size.width*0.8774911,size.height*0.5912154);
path_10.lineTo(size.width*0.8774911,size.height*0.8417642);
path_10.cubicTo(size.width*0.8774911,size.height*0.8530650,size.width*0.8777226,size.height*0.8634228,size.width*0.8781883,size.height*0.8728455);
path_10.cubicTo(size.width*0.8786539,size.height*0.8816341,size.width*0.8794071,size.height*0.8888537,size.width*0.8804529,size.height*0.8945041);
path_10.cubicTo(size.width*0.8814987,size.height*0.8995285,size.width*0.8828931,size.height*0.9020407,size.width*0.8846361,size.height*0.9020407);
path_10.close();

Paint paint10Fill = Paint()..style=PaintingStyle.fill;
paint10Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_10,paint10Fill);

Path path_11 = Path();
path_11.moveTo(size.width*0.9691527,size.height);
path_11.cubicTo(size.width*0.9603206,size.height,size.width*0.9529440,size.height*0.9893252,size.width*0.9470178,size.height*0.9679756);
path_11.cubicTo(size.width*0.9412087,size.height*0.9466260,size.width*0.9364453,size.height*0.9117724,size.width*0.9327277,size.height*0.8634228);
path_11.lineTo(size.width*0.9520712,size.height*0.8172683);
path_11.cubicTo(size.width*0.9539313,size.height*0.8417642,size.width*0.9560814,size.height*0.8612276,size.width*0.9585216,size.height*0.8756667);
path_11.cubicTo(size.width*0.9610763,size.height*0.8894878,size.width*0.9638651,size.height*0.8963902,size.width*0.9668855,size.height*0.8963902);
path_11.cubicTo(size.width*0.9690941,size.height*0.8963902,size.width*0.9707201,size.height*0.8938780,size.width*0.9717659,size.height*0.8888537);
path_11.cubicTo(size.width*0.9729288,size.height*0.8838293,size.width*0.9735089,size.height*0.8769268,size.width*0.9735089,size.height*0.8681301);
path_11.cubicTo(size.width*0.9735089,size.height*0.8536911,size.width*0.9724631,size.height*0.8405041,size.width*0.9703715,size.height*0.8285772);
path_11.cubicTo(size.width*0.9683969,size.height*0.8166423,size.width*0.9647939,size.height*0.7990610,size.width*0.9595674,size.height*0.7758276);
path_11.lineTo(size.width*0.9522468,size.height*0.7428610);
path_11.cubicTo(size.width*0.9469008,size.height*0.7183724,size.width*0.9426616,size.height*0.6948244,size.width*0.9395242,size.height*0.6722187);
path_11.cubicTo(size.width*0.9365038,size.height*0.6489854,size.width*0.9349924,size.height*0.6204146,size.width*0.9349924,size.height*0.5865057);
path_11.cubicTo(size.width*0.9349924,size.height*0.5569935,size.width*0.9363868,size.height*0.5309341,size.width*0.9391756,size.height*0.5083285);
path_11.cubicTo(size.width*0.9420789,size.height*0.4857228,size.width*0.9459135,size.height*0.4681407,size.width*0.9506768,size.height*0.4555821);
path_11.cubicTo(size.width*0.9554427,size.height*0.4430236,size.width*0.9605547,size.height*0.4367439,size.width*0.9660153,size.height*0.4367439);
path_11.cubicTo(size.width*0.9742646,size.height*0.4367439,size.width*0.9811781,size.height*0.4489886,size.width*0.9867532,size.height*0.4734780);
path_11.cubicTo(size.width*0.9923308,size.height*0.4979675,size.width*0.9962239,size.height*0.5325041,size.width*0.9984326,size.height*0.5770870);
path_11.lineTo(size.width*0.9801323,size.height*0.6222984);
path_11.cubicTo(size.width*0.9794351,size.height*0.6103675,size.width*0.9784478,size.height*0.5984366,size.width*0.9771679,size.height*0.5865057);
path_11.cubicTo(size.width*0.9758906,size.height*0.5745756,size.width*0.9743232,size.height*0.5645285,size.width*0.9724631,size.height*0.5563650);
path_11.cubicTo(size.width*0.9707201,size.height*0.5482024,size.width*0.9688041,size.height*0.5441203,size.width*0.9667125,size.height*0.5441203);
path_11.cubicTo(size.width*0.9648524,size.height*0.5441203,size.width*0.9633435,size.height*0.5469463,size.width*0.9621807,size.height*0.5525976);
path_11.cubicTo(size.width*0.9611349,size.height*0.5582488,size.width*0.9606107,size.height*0.5657846,size.width*0.9606107,size.height*0.5752033);
path_11.cubicTo(size.width*0.9606107,size.height*0.5871341,size.width*0.9618321,size.height*0.6000065,size.width*0.9642723,size.height*0.6138211);
path_11.cubicTo(size.width*0.9668270,size.height*0.6276358,size.width*0.9703130,size.height*0.6442756,size.width*0.9747277,size.height*0.6637415);
path_11.lineTo(size.width*0.9818753,size.height*0.6976504);
path_11.cubicTo(size.width*0.9847786,size.height*0.7108366,size.width*0.9876260,size.height*0.7249650,size.width*0.9904148,size.height*0.7400358);
path_11.cubicTo(size.width*0.9932036,size.height*0.7551065,size.width*0.9954682,size.height*0.7717463,size.width*0.9972112,size.height*0.7899561);
path_11.cubicTo(size.width*0.9990712,size.height*0.8081667,size.width,size.height*0.8288862,size.width,size.height*0.8521220);
path_11.cubicTo(size.width,size.height*0.8835203,size.width*0.9985471,size.height*0.9105203,size.width*0.9956438,size.height*0.9331220);
path_11.cubicTo(size.width*0.9927379,size.height*0.9551057,size.width*0.9889033,size.height*0.9717398,size.width*0.9841399,size.height*0.9830488);
path_11.cubicTo(size.width*0.9794936,size.height*0.9943496,size.width*0.9744962,size.height,size.width*0.9691527,size.height);
path_11.close();

Paint paint11Fill = Paint()..style=PaintingStyle.fill;
paint11Fill.shader = ui.Gradient.linear(Offset(size.width*0.6315802,size.height*0.8279756), Offset(size.width*0.5492036,size.height*-28.90447), [const Color(0xff444439).withOpacity(1),const Color(0xff514D39).withOpacity(1)], [0.317708,1]);
canvas.drawPath(path_11,paint11Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}