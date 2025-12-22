import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ProjectionService {
  /// Calculates the projected Net Zero date for a user.
  /// Net Zero is defined here as the point where cumulative CO2 saved equals the cumulative "Carbon Debt".
  static Future<Ecotrajectory> calculateTrajectory(Session session, int userId) async {
    // 1. Fetch User Profile for baseline debt (monthly budget)
    final profile = await UserProfile.db.findFirstRow(session, where: (t) => t.userId.equals(userId));
    final monthlyBudget = profile?.monthlyBudget ?? 200.0;
    
    // Yearly baseline debt (approx)
    final yearlyDebt = monthlyBudget * 12;

    // 2. Fetch all ActionLog entries to find the savings rate
    final logs = await ActionLog.db.find(session, where: (t) => t.userId.equals(userId));

    if (logs.isEmpty) {
      return Ecotrajectory(
        netZeroDate: DateTime.now().add(const Duration(days: 365 * 10)), // 10 years default if no data
        savingsRate: 0.0,
        isAchievable: false,
        daysToNetZero: 3650,
        currentCarbonDebt: yearlyDebt,
      );
    }

    // Sort logs by date
    logs.sort((a, b) => a.date.compareTo(b.date));
    final firstLogDate = logs.first.date;
    final lastLogDate = logs.last.date;
    
    final durationDays = lastLogDate.difference(firstLogDate).inDays.clamp(1, 365 * 10);
    double totalSaved = 0;
    for (var log in logs) {
      totalSaved += log.co2Saved;
    }

    // Savings per day
    final savingsRate = totalSaved / durationDays;

    // Projected Net Zero
    // Debt = (Daily Budget * total_days)
    // Savings = (Daily Savings * total_days)
    // We want Savings >= Debt. 
    // This is hard to calculate without a fixed starting point for "Debt".
    // Let's simplify: Years to Net Zero = yearlyDebt / (savingsRate * 365)
    
    if (savingsRate <= 0) {
       return Ecotrajectory(
        netZeroDate: DateTime.now().add(const Duration(days: 365 * 20)),
        savingsRate: 0.0,
        isAchievable: false,
        daysToNetZero: 365 * 20,
        currentCarbonDebt: yearlyDebt,
      );
    }

    final double daysToNetZeroDouble = yearlyDebt / savingsRate;
    final int daysToNetZero = daysToNetZeroDouble.toInt().clamp(1, 365 * 50); // Cap at 50 years
    final netZeroDate = DateTime.now().add(Duration(days: daysToNetZero));

    return Ecotrajectory(
      netZeroDate: netZeroDate,
      savingsRate: savingsRate,
      isAchievable: daysToNetZero < (365 * 2), // Aim for Net Zero within 2 years
      daysToNetZero: daysToNetZero,
      currentCarbonDebt: yearlyDebt,
    );
  }
}
