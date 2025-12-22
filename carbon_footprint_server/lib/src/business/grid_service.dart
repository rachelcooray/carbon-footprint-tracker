import 'dart:math';

/// A service to simulate and provide real-time Carbon Intensity of the power grid.
/// In a production environment, this would call an external API like Electricity Maps.
class GridService {
  static final Random _random = Random();

  /// Returns the current carbon intensity in gCO2/kWh.
  /// Standard ranges: < 100 (Clean), 100-300 (Moderate), > 300 (High)
  static double getCurrentIntensity() {
    // Simulate fluctuations based on "time of day"
    int hour = DateTime.now().hour;
    
    // Cleaner at night/morning (Wind/Solar), dirtier during evening peak
    if (hour >= 17 && hour <= 21) {
      return 350.0 + _random.nextDouble() * 100; // Peak
    } else if (hour >= 10 && hour <= 15) {
      return 80.0 + _random.nextDouble() * 50; // Solar Peak
    } else {
      return 150.0 + _random.nextDouble() * 100; // Neutral
    }
  }

  static String getGridStatus() {
    double intensity = getCurrentIntensity();
    if (intensity < 150) return 'CLEAN';
    if (intensity < 300) return 'NEUTRAL';
    return 'DIRTY';
  }

  static String getGridAdvice() {
    String status = getGridStatus();
    switch (status) {
      case 'CLEAN':
        return 'The grid is currently powered by high renewables! Perfect time to run high-energy appliances.';
      case 'NEUTRAL':
        return 'Grid intensity is average. Use power normally, but avoid unnecessary heavy loads.';
      case 'DIRTY':
        return 'Grid intensity is high right now (fossil fuels). If possible, delay laundry or EV charging until the morning.';
      default:
        return 'Stay conscious of your energy usage.';
    }
  }
}
