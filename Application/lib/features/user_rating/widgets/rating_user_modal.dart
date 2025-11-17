import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/widgets/modal_bottom_sheet.dart';

class _RatingUserModal extends ConsumerWidget {
  _RatingUserModal();

  double rating = 3.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ModalBottomSheet(
      title: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: Text('modal.rating_user.title'.tr()).center(),
      ),

      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(44.0),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).pop(rating);
          },
          child: Text('button.send_rating'.tr()),
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4.0,
        children: [
          RatingBar.builder(
            minRating: 1,
            initialRating: rating,
            allowHalfRating: true,
            wrapAlignment: WrapAlignment.spaceBetween,

            onRatingUpdate: (value) {
              rating = value;
            },

            itemPadding: Insets.h8,
            itemBuilder: (_, _) {
              return const Icon(Icons.star, color: Colors.amber);
            },
          ).center().margin(const EdgeInsets.only(top: 20.0)),

          Text(
            'modal.rating_user.options.tell_more'.tr(),
          ).margin(const EdgeInsets.only(top: 20.0)),
          TextField(
            minLines: 3,
            maxLines: null,
            decoration: const InputDecoration(),
          ),
        ],
      ),
    );
  }
}

Future<double?> showRatingUserModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return _RatingUserModal();
    },
  );
}
