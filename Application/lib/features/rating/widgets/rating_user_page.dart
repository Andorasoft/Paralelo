// import 'package:andorasoft_flutter/andorasoft_flutter.dart';
// import 'package:paralelo/core/constants.dart';
// import 'package:paralelo/core/imports.dart';

// class RatingUserModal extends ConsumerWidget {
//   const RatingUserModal({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         spacing: 4.0,
//         children: [
//           RatingBar.builder(
//             minRating: 1,
//             initialRating: 3,
//             allowHalfRating: true,
//             wrapAlignment: WrapAlignment.spaceBetween,

//             onRatingUpdate: (rating) {
//               debugPrint(rating.toString());
//             },

//             itemPadding: Insets.h8,
//             itemBuilder: (_, _) {
//               return const Icon(Icons.star, color: Colors.amber);
//             },
//           ).center(),

//           Text(
//             'modal.rating_user.options.tell_more'.tr(),
//           ).margin(const EdgeInsets.only(top: 12.0)),
//           TextField(
//             minLines: 5,
//             maxLines: null,
//             decoration: const InputDecoration(),
//           ),
//         ],
//       ).margin(Insets.h16v8),
//     );
//   }
// }
