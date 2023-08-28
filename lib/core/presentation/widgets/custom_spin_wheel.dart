import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../core.dart';

class SpinItem {
  String label;
  Color color;

  SpinItem({required this.label, required this.color});
}

class MySpinner extends StatefulWidget {
  bool isSpin = false;
  final MySpinController mySpinController;
  final List<SpinItem> itemList;
  final double wheelSize;
  final Function(void) onFinished;
  MySpinner({
    Key? key,
    required this.mySpinController,
    required this.onFinished,
    required this.itemList,
    required this.wheelSize,
    required this.isSpin,
  }) : super(key: key);

  @override
  State<MySpinner> createState() => _MySpinnerState();
}

class _MySpinnerState extends State<MySpinner> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.mySpinController.initLoad(
      tickerProvider: this,
      itemList: widget.itemList,
    );
  }

  @override
  void dispose() {
    super.dispose();
    null;
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedBuilder(
          animation: widget.mySpinController._baseAnimation,
          builder: (context, child) {
            double value = widget.mySpinController._baseAnimation.value;
            double rotationValue = (360 * value);
            return RotationTransition(
              turns: AlwaysStoppedAnimation(rotationValue / 360),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: Container(
                      width: widget.wheelSize,
                      height: widget.wheelSize,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(68, 176, 251, 1.0),
                        shape: BoxShape.circle,
                      ),
                      child: CustomPaint(
                        painter: SpinWheelPainter(items: widget.itemList),
                      ),
                    ),
                  ),
                  ...widget.itemList.map((each) {
                    int index = widget.itemList.indexOf(each);
                    double rotateInterval = 360 / widget.itemList.length;
                    double rotateAmount = (index + 0.5) * rotateInterval;
                    return RotationTransition(
                      turns: AlwaysStoppedAnimation(rotateAmount / 360),
                      child: Transform.translate(
                        offset: Offset(0, -widget.wheelSize / 4),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Transform.rotate(
                            angle: math.pi / 2,
                            child: widget.isSpin
                                ? Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: blue,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        each.label,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(
                                    each.label,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  Container(
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(68, 176, 251, 1.0),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Container(
          height: widget.wheelSize / 2,
          width: 4,
          // decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
        ),
      ],
    );
  }
}

class MySpinController {
  late AnimationController _baseAnimation;
  late TickerProvider _tickerProvider;
  bool _xSpinning = false;
  List<SpinItem> _itemList = [];

  Future<void> initLoad({
    required TickerProvider tickerProvider,
    required List<SpinItem> itemList,
  }) async {
    _tickerProvider = tickerProvider;
    _itemList = itemList;
    await setAnimations(_tickerProvider);
  }

  Future<void> setAnimations(TickerProvider tickerProvider) async {
    _baseAnimation = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 200),
    );
  }

  Future<void> spinNow(
      {required int luckyIndex,
      int totalSpin = 100,
      int baseSpinDuration = 100}) async {
    //getWhereToStop
    int itemsLength = _itemList.length;
    int factor = luckyIndex % itemsLength;
    if (factor == 0) factor = itemsLength;
    double spinInterval = 1 / itemsLength;
    double target = 1 - ((spinInterval * factor) - (spinInterval / 2));

    if (!_xSpinning) {
      _xSpinning = true;
      int spinCount = 0;

      do {
        _baseAnimation.reset();
        _baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        if (spinCount == totalSpin) {
          await _baseAnimation.animateTo(target);
        } else {
          await _baseAnimation.forward();
        }
        baseSpinDuration = baseSpinDuration;
        _baseAnimation.duration = Duration(milliseconds: baseSpinDuration);
        spinCount++;
      } while (spinCount <= totalSpin);

      _xSpinning = false;
    }
  }
}

class SpinWheelPainter extends CustomPainter {
  final List<SpinItem> items;

  SpinWheelPainter({required this.items});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    final paint = Paint()..style = PaintingStyle.fill;

    final sectionAngle = 2 * math.pi / items.length;

    for (var i = 0; i < items.length; i++) {
      final startAngle = i * sectionAngle;
      // final endAngle = startAngle + sectionAngle;

      paint.color = items[i].color;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngle,
        true,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
