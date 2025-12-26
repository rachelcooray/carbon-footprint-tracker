import 'package:flutter/material.dart';

class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxContentWidth;
  final EdgeInsets padding;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxContentWidth = 1400, // Much wider "Fit to Screen" feel
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if we are on a "wide" screen (Tablet/Desktop)
        bool isWide = constraints.maxWidth > 800;

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Padding(
              padding: padding,
              // If Wide: Scale text up by 25% to fill space better and look "bigger"
              child: isWide 
                ? MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1.25),
                    ),
                    child: child,
                  )
                : child,
            ),
          ),
        );
      },
    );
  }
}
