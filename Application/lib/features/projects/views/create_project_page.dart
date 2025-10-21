import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:paralelo/core/constants.dart';
import 'package:paralelo/core/imports.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class CreateProjectPage extends ConsumerStatefulWidget {
  static const routePath = '/create-project';

  const CreateProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CreateProjectPageState();
  }
}

class _CreateProjectPageState extends ConsumerState<CreateProjectPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        leading: const NavigationButton(type: NavigationButtonType.close),
        title: Text('Publish a project'),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Form(
          key: formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 4.0,

            children: [
              Text('Project title'),
              TextFormField(),

              Text(
                'Project description',
              ).margin(const EdgeInsets.only(top: 12.0)),
              TextFormField(minLines: 3, maxLines: null),

              Text('Category').margin(const EdgeInsets.only(top: 12.0)),
              TextFormField(),

              Text('Skills').margin(const EdgeInsets.only(top: 12.0)),
              Wrap(
                runSpacing: -4.0,
                spacing: 8.0,

                children: [
                  Chip(label: Text('UI/UX Design')),
                  Chip(label: Text('Mobile Development')),
                  Chip(label: Text('Web Development')),
                  Chip(label: Text('Data Analysis')),
                  IconButton.filledTonal(
                    onPressed: () {},

                    style: Theme.of(context).iconButtonTheme.style?.copyWith(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      minimumSize: WidgetStateProperty.all(
                        const Size(36.0, 36.0),
                      ),
                    ),

                    icon: const Icon(LucideIcons.plus),
                  ),
                ],
              ),

              Text('Budget').margin(const EdgeInsets.only(top: 12.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 16.0,

                children: [
                  TextFormField().expanded(),
                  TextFormField().expanded(),
                ],
              ),

              Text('Budget type').margin(const EdgeInsets.only(top: 12.0)),
              DropdownButtonFormField<String>(
                initialValue: ProjectPaymentType.fixed,
                onChanged: (v) {},

                items: ProjectPaymentType.values
                    .map(
                      (i) => DropdownMenuItem(
                        value: i,
                        child: Text(ProjectPaymentType.labels[i]!),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ).margin(const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)),
      ),

      bottomNavigationBar:
          FilledButton(
            onPressed: () {},
            child: const Text('Publish project'),
          ).useSafeArea().margin(
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
    ).hideKeyboardOnTap(context);
  }
}
