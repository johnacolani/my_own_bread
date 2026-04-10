import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_spacing.dart';

/// Circular analog-style countdown: dial, sweeping hand, and mm:ss readout.
class AnalogTimer extends StatefulWidget {
  const AnalogTimer({
    super.key,
    required this.duration,
    this.label,
  });

  /// Countdown length (ignored if zero or negative — widget shows nothing).
  final Duration duration;
  final String? label;

  @override
  State<AnalogTimer> createState() => _AnalogTimerState();
}

class _AnalogTimerState extends State<AnalogTimer> {
  Timer? _ticker;
  late int _remainingSec;
  late int _totalSec;
  bool _running = false;

  @override
  void initState() {
    super.initState();
    _totalSec = math.max(1, widget.duration.inSeconds);
    _remainingSec = _totalSec;
  }

  @override
  void didUpdateWidget(covariant AnalogTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _ticker?.cancel();
      _ticker = null;
      _running = false;
      _totalSec = math.max(1, widget.duration.inSeconds);
      _remainingSec = _totalSec;
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _start() {
    if (_remainingSec <= 0) return;
    setState(() => _running = true);
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        _remainingSec = math.max(0, _remainingSec - 1);
        if (_remainingSec <= 0) {
          _running = false;
          _ticker?.cancel();
          _ticker = null;
        }
      });
    });
  }

  void _pause() {
    _ticker?.cancel();
    _ticker = null;
    setState(() => _running = false);
  }

  void _reset() {
    _ticker?.cancel();
    _ticker = null;
    setState(() {
      _running = false;
      _remainingSec = _totalSec;
    });
  }

  String _mmss(int sec) {
    final m = sec ~/ 60;
    final s = sec % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (widget.duration.inSeconds <= 0) {
      return const SizedBox.shrink();
    }

    final textTheme = Theme.of(context).textTheme;
    final done = _remainingSec <= 0 && !_running;

    return Semantics(
      label: widget.label != null
          ? '${widget.label}, ${_mmss(_remainingSec)} remaining'
          : 'Timer, ${_mmss(_remainingSec)} remaining',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: textTheme.labelLarge,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          SizedBox(
            width: 200,
            height: 200,
            child: CustomPaint(
              painter: _AnalogDialPainter(
                progressElapsed: 1 - (_remainingSec / _totalSec),
                done: done,
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 52),
                  child: Text(
                    _mmss(_remainingSec),
                    style: textTheme.titleLarge?.copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!_running && _remainingSec > 0) ...[
                IconButton.filled(
                  onPressed: _start,
                  icon: const Icon(Icons.play_arrow),
                  tooltip: 'Start',
                ),
                const SizedBox(width: AppSpacing.xs),
              ] else if (_running) ...[
                IconButton.filledTonal(
                  onPressed: _pause,
                  icon: const Icon(Icons.pause),
                  tooltip: 'Pause',
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              IconButton.outlined(
                onPressed: _reset,
                icon: const Icon(Icons.restart_alt),
                tooltip: 'Reset',
              ),
            ],
          ),
          if (done)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.sm),
              child: Text(
                'Time’s up',
                style: textTheme.labelLarge?.copyWith(color: AppColors.success),
              ),
            ),
        ],
      ),
    );
  }
}

class _AnalogDialPainter extends CustomPainter {
  _AnalogDialPainter({
    required this.progressElapsed,
    required this.done,
  });

  /// 0 = start, 1 = finished.
  final double progressElapsed;
  final bool done;

  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.shortestSide / 2 - 8;

    final fill = Paint()
      ..color = AppColors.surfaceMuted
      ..style = PaintingStyle.fill;
    canvas.drawCircle(c, r, fill);

    final border = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(c, r, border);

    final tickPaint = Paint()
      ..color = AppColors.textSecondary.withValues(alpha: 0.7)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 12; i++) {
      final a = -math.pi / 2 + (2 * math.pi * i / 12);
      final inner = r - 14;
      final outer = r - 4;
      canvas.drawLine(
        Offset(c.dx + inner * math.cos(a), c.dy + inner * math.sin(a)),
        Offset(c.dx + outer * math.cos(a), c.dy + outer * math.sin(a)),
        tickPaint,
      );
    }

    final sweep = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.22)
      ..style = PaintingStyle.fill;
    final sweepAngle = 2 * math.pi * progressElapsed.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: r),
      -math.pi / 2,
      sweepAngle,
      true,
      sweep,
    );

    final handLen = r - 18;
    final handAngle = -math.pi / 2 + 2 * math.pi * progressElapsed.clamp(0.0, 1.0);
    final handPaint = Paint()
      ..color = done ? AppColors.success : AppColors.coral
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      c,
      Offset(
        c.dx + handLen * math.cos(handAngle),
        c.dy + handLen * math.sin(handAngle),
      ),
      handPaint,
    );

    canvas.drawCircle(c, 6, Paint()..color = AppColors.textPrimary);
    canvas.drawCircle(c, 4, Paint()..color = AppColors.surface);
  }

  @override
  bool shouldRepaint(covariant _AnalogDialPainter oldDelegate) {
    return oldDelegate.progressElapsed != progressElapsed ||
        oldDelegate.done != done;
  }
}
