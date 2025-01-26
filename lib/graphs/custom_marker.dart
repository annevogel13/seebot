import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:ui';

Future<BitmapDescriptor> customMarker(
  int clusterSize,
  Color clusterColor,
  Color textColor,
  int width,
) async {

  final PictureRecorder pictureRecorder = PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint paint = Paint()..color = clusterColor;
  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  final double radius = width / 2;
  canvas.drawCircle(
    Offset(radius, radius),
    radius,
    paint,
  );
  textPainter.text = TextSpan(
    text: clusterSize.toString(),
    style: TextStyle(
      fontSize: radius - 5,
      fontWeight: FontWeight.bold,
      color: textColor,
    ),
  );
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset(
      radius - textPainter.width / 2,
      radius - textPainter.height / 2,
    ),
  );
  final image = await pictureRecorder
      .endRecording()
      .toImage(radius.toInt() * 2, radius.toInt() * 2);
  final data = await image.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.bytes(data!.buffer.asUint8List());
}
