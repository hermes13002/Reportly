import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../endpoints/report_generation_endpoint.dart';

class ReportSchedulerCall extends FutureCall {
  @override
  Future<void> invoke(Session session, object) async {
    session.log('Running ReportScheduler...');

    // 1. Fetch due schedules
    final now = DateTime.now();
    final dueSchedules = await ScheduleConfig.db.find(
      session,
      where: (t) => (t.nextRunAt <= now) & t.isEnabled.equals(true),
    );

    if (dueSchedules.isEmpty) {
      // no reports due, but we must reschedule the checker itself?
      // actually, we plan to schedule this FutureCall to run every X minutes via the system,
      // OR we can self-schedule. A robust way is to run every hour.
      session.log('No reports due at this time.');
      return;
    }

    session.log('Found ${dueSchedules.length} due schedules.');

    final endpoint = ReportGenerationEndpoint();

    for (final schedule in dueSchedules) {
      try {
        session.log('Processing schedule for company ${schedule.companyId}');

        // 2. Calculate date range
        // Logic: if lastRunAt exists, use (lastRunAt -> now).
        // else use (now - frequency -> now)
        final DateTime startDate;
        if (schedule.lastRunAt != null) {
          startDate = schedule.lastRunAt!;
        } else {
          startDate = _calculateStartDate(
            now,
            schedule.frequency,
            schedule.customDays,
          );
        }
        final endDate = now;

        // 3. Generate Report (Draft)
        final report = await endpoint.generate(
          session,
          companyId: schedule.companyId, // companyId is non-nullable
          startDate: startDate,
          endDate: endDate,
        );
        session.log('Generated draft report ${report.id}');

        // 4. Send Report?
        // For now, we only generate drafts for review.
        // If we want to auto-send, we can add a flag later.

        // 5. Update Schedule
        schedule.lastRunAt = now;
        schedule.nextRunAt = _calculateNextRun(now, schedule);
        await ScheduleConfig.db.updateRow(session, schedule);
      } catch (e, stack) {
        session.log(
          'Failed to process schedule for company ${schedule.companyId}: $e',
          level: LogLevel.error,
          exception: e,
          stackTrace: stack,
        );
      }
    }

    // self-schedule next run in 1 hour
    // this acts as a cron job running every hour
    // Serverpod.instance is the safest way to access the method if session.server doesn't present it directly in this version
    await Serverpod.instance.futureCallWithDelay(
      'reportScheduler',
      null,
      const Duration(minutes: 60),
    );
  }

  DateTime _calculateStartDate(
    DateTime now,
    String frequency,
    int? customDays,
  ) {
    switch (frequency) {
      case 'weekly':
        return now.subtract(const Duration(days: 7));
      case 'bi-weekly':
        return now.subtract(const Duration(days: 14));
      case 'monthly':
        return DateTime(now.year, now.month - 1, now.day);
      case 'custom':
        return now.subtract(Duration(days: customDays ?? 7));
      default:
        return now.subtract(const Duration(days: 7));
    }
  }

  DateTime _calculateNextRun(DateTime lastRun, ScheduleConfig config) {
    DateTime next;
    switch (config.frequency) {
      case 'weekly':
        next = lastRun.add(const Duration(days: 7));
        break;
      case 'bi-weekly':
        next = lastRun.add(const Duration(days: 14));
        break;
      case 'monthly':
        next = DateTime(lastRun.year, lastRun.month + 1, lastRun.day);
        break;
      case 'custom':
        next = lastRun.add(Duration(days: config.customDays ?? 7));
        break;
      default:
        next = lastRun.add(const Duration(days: 7));
    }

    // Adjust for specific time if configured (simple adjustment)
    // We keep the calculated date but set the time to the configured hour/minute
    return DateTime(
      next.year,
      next.month,
      next.day,
      config.hourOfDay,
      config.minuteOfHour,
    );
  }
}
