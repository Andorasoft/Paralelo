import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:andorasoft_flutter/andorasoft_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:paralelo/widgets/navigation_button.dart';

class CreateProjectPage extends ConsumerStatefulWidget {
  static const routeName = 'CreateProjectPage';
  static const routePath = '/create-project';

  const CreateProjectPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return CreateProjectPageState();
  }
}

class CreateProjectPageState extends ConsumerState<CreateProjectPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        automaticallyImplyLeading: false,

        leading: const NavigationButton(type: NavigationButtonType.close),

        centerTitle: true,
        title: Text('Publish a project'),
      ),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,

        child: Form(
          key: _formKey,

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
              DropdownButtonFormField<int>(
                initialValue: 1,
                onChanged: (v) {},

                items: [
                  DropdownMenuItem(value: 1, child: Text('Project')),
                  DropdownMenuItem(value: 2, child: Text('Hourly')),
                ],
              ),
            ],
          ),
        ).margin(const EdgeInsets.all(8.0)),
      ),

      bottomNavigationBar: FilledButton(
        onPressed: () {},
        child: const Text('Publish project'),
      ).margin(const EdgeInsets.symmetric(horizontal: 8.0)).useSafeArea(),
    ).hideKeyboardOnTap(context);
  }
}
