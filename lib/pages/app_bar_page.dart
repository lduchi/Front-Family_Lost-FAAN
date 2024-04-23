import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({super.key});

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent, // Hace la AppBar transparente
          title: const Text('Hola, Usuario!'),
          leading: Center(
            child: CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(AssetManager.exampleImage),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement Filter action
                    },
                    child: Text(AppStrings.navigationLost),
                  ),
                  const SizedBox(width: 8),
                  Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement Filter action
                    },
                    child: Text(AppStrings.navigationFound),
                  ),
                  const SizedBox(width: 8),
                  Spacer(),
                  OutlinedButton(
                    onPressed: () {
                      // TODO: Implement Filter action
                    },
                    child: Text(AppStrings.navigationAdoption),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: AppIcons.notificationIcon,
            ),
          ],
          pinned:
              false, // Hace que el SliverAppBar permanezca fijo en la parte superior
          floating:
              true, // Hace que el SliverAppBar se muestre nuevamente al desplazarse hacia arriba
          snap: true,
        ),
      ],
    );
  }
}
