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

class ProjectPaymentType {
  static const String fixed = 'FIXED';
  static const String hourly = 'HOURLY';

  static List<String> values = [fixed, hourly];

  static Map<String, String> labels = {
    fixed: 'const.project_payment_type.fixed'.tr(),
    hourly: 'const.project_payment_type.hourly'.tr(),
  };
}

class PlanPeriodUnit {
  static const String month = 'MONTH';
  static const String year = 'YEAR';

  static List<String> values = [month, year];

  static Map<String, String> labels = {month: 'mes', year: 'año'};
}

class Plans {
  static const String free = 'Free';
  static const String pro = 'Pro';
  static const String premium = 'Premium';

  static List<String> values = [free, pro, premium];

  static Map<String, String> labels = {
    free: 'Gratis',
    pro: 'Pro',
    premium: 'Premium',
  };
}

@immutable
class Insets {
  const Insets._internal();

  static const h16v8 = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
  static const h16 = EdgeInsets.symmetric(horizontal: 16.0);
  static const h8 = EdgeInsets.symmetric(horizontal: 8.0);
  static const v16 = EdgeInsets.symmetric(vertical: 16.0);
  static const v8 = EdgeInsets.symmetric(vertical: 8.0);
  static const a24 = EdgeInsets.all(24.0);
  static const a16 = EdgeInsets.all(16.0);
  static const a12 = EdgeInsets.all(12.0);
  static const a8 = EdgeInsets.all(8.0);
}
