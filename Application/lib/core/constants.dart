import 'package:paralelo/core/imports.dart';

class ProjectStatus {
  static const String open = 'OPEN';
  static const String inProgress = 'IN_PROGRESS';
  static const String completed = 'COMPLETED';
  static const String canceled = 'CANCELED';

  static const List<String> values = [open, inProgress, completed, canceled];

  static Map<String, String> labels = {
    open: 'const.project_status.open'.tr(),
    inProgress: 'const.project_status.in_progress'.tr(),
    completed: 'const.project_status.completed'.tr(),
    canceled: 'const.project_status.canceled'.tr(),
  };
}

class ProposalMode {
  static const String remote = 'REMOTE';
  static const String inPerson = 'IN_PERSON';
  static const String hybrid = 'HYBRID';

  static const List<String> values = [remote, inPerson, hybrid];

  static Map<String, String> labels = {
    remote: 'const.proposal_mode.remote'.tr(),
    inPerson: 'const.proposal_mode.in_person'.tr(),
    hybrid: 'const.proposal_mode.hybrid'.tr(),
  };
}

class ProposalStatus {
  static const String pending = 'PENDING';
  static const String accepted = 'ACCEPTED';
  static const String rejected = 'REJECTED';
  static const String canceled = 'CANCELED';

  static const List<String> values = [pending, accepted, rejected, canceled];

  static Map<String, String> labels = {
    pending: 'const.proposal_status.pending'.tr(),
    accepted: 'const.proposal_status.accepted'.tr(),
    rejected: 'const.proposal_status.rejected'.tr(),
    canceled: 'const.proposal_status.canceled'.tr(),
  };
}

class ProposalEstimatedDurationUnit {
  static const String hours = 'HOURS';
  static const String days = 'DAYS';

  static const List<String> values = [hours, days];

  static Map<String, String> labels = {
    hours: 'const.proposal_estimated_duration_unit.hours'.tr(),
    days: 'const.proposal_estimated_duration_unit.days'.tr(),
  };
}

class ProjectPaymentType {
  static const String fixed = 'FIXED';
  static const String hourly = 'HOURLY';

  static List<String> values = [fixed, hourly];

  static Map<String, String> labels = {
    fixed: 'const.project_payment_type.fixed'.tr(),
    hourly: 'const.project_payment_type.hourly'.tr(),
  };
}
