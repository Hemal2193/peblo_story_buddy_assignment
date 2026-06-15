import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReadButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool enabled;
  const ReadButton({super.key, required this.onPressed, required this.enabled});

  @override
  State<ReadButton> createState() => _ReadButtonState();
}

class _ReadButtonState extends State<ReadButton> {
  bool _pressed = false;

  Future<void> _tap() async {
    setState(() => _pressed = true);

    // Keep the pressed animation visible.
    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) {
      setState(() => _pressed = false);
    }

    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? _tap : null,
      child: SizedBox(
        height: 64,
        width: double.infinity,
        child: Stack(
          children: [
            // Bottom 3D layer
            Positioned(
              left: 4,
              top: 6,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? Colors.deepPurple.shade900
                      : Colors.deepPurple.shade200,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // Top button
            AnimatedPositioned(
              duration: const Duration(milliseconds: 70),
              curve: Curves.easeOut,
              left: _pressed ? 4 : 0,
              top: _pressed ? 4 : 0,
              right: _pressed ? 0 : 4,
              bottom: _pressed ? 0 : 4,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.enabled
                      ? Colors.deepPurple
                      : Colors.deepPurple.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.volume_up_rounded,
                      color: widget.enabled ? Colors.white : Colors.white70,
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.enabled ? "Read Me Story" : "Reading Story...",
                      style: TextStyle(
                        color: widget.enabled ? Colors.white : Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
