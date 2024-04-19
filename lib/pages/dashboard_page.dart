import 'package:familylost_faan/pages/animal_item_page.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/icons/app_icons.dart';
import 'package:familylost_faan/utilities/texts/app_strings.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  ButtonStyle enabledFilledButtonStyle(bool selected, ColorScheme colors) {
    return IconButton.styleFrom(
      foregroundColor: selected ? colors.onPrimary : colors.primary,
      backgroundColor: selected ? colors.primary : colors.surfaceVariant,
      disabledForegroundColor: colors.onSurface.withOpacity(0.38),
      disabledBackgroundColor: colors.onSurface.withOpacity(0.12),
      hoverColor: selected
          ? colors.onPrimary.withOpacity(0.08)
          : colors.primary.withOpacity(0.08),
      focusColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
      highlightColor: selected
          ? colors.onPrimary.withOpacity(0.12)
          : colors.primary.withOpacity(0.12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
          ElevatedButton(
            onPressed: () {
              // TODO: Implement Filter action
            },
            child: Text(AppStrings.navigationLost),
          ),
          const SizedBox(width: 8),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement Filter action
            },
            child: Text(AppStrings.navigationFound),
          ),
          const SizedBox(width: 8),
          Spacer(),
          ElevatedButton(
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
  pinned: true, // Hace que el SliverAppBar permanezca fijo en la parte superior
  floating: true, // Hace que el SliverAppBar se muestre nuevamente al desplazarse hacia arriba
),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final String image = AssetManager.exampleImage;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: AnimalItemPage(
                        image: image,
                      ),
                    ),
                  ),
                );
              },
              childCount: 6,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.navigationHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: AppStrings.hintSearch,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: AppStrings.navigationAdd,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.navigationProfile,
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey[600],
        onTap: (index) {
          // TODO: Implement navigation action
        },
      ),
    );
  }
}