import 'package:familylost_faan/pages/animal_item_page.dart';
import 'package:familylost_faan/utilities/AssetManager/asset_manager.dart';
import 'package:familylost_faan/utilities/fonts/app_fonts.dart';
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
      appBar: AppBar(
        title: const Text('Hola, Usuario!'),
        scrolledUnderElevation: 4.0,
        shadowColor: Theme.of(context).shadowColor,
        leading: Center(
          child: CircleAvatar(
            radius: 16,
            child: AppIcons.profileIcon,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(140.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SegmentedButton(
                  multiSelectionEnabled: false,
                  showSelectedIcon: false,
                  segments: [
                    ButtonSegment(
                        value: 'Perdidos',
                        icon: AppIcons.lostIcon,
                        label: Text(
                          AppStrings.navigationLost,
                          style: AppFonts.caption,
                        ),
                        enabled: true),
                    ButtonSegment(
                        value: 'Encontrados',
                        icon: AppIcons.foundIcon,
                        label: Text(
                          AppStrings.navigationFound,
                          style: AppFonts.caption,
                        ),
                        enabled: true),
                    ButtonSegment(
                      value: 'Adopción',
                      icon: AppIcons.adoptionIcon,
                      label: Text(
                        AppStrings.navigationAdoption,
                        style: AppFonts.caption,
                      ),
                      enabled: true,
                    ),
                  ],
                  selected: Set.from(['Perdidos']),
                  onSelectionChanged: (selected) {},
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: AppStrings.hintSearch,
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surfaceVariant,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: AppIcons.searchIcon,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            style:
                enabledFilledButtonStyle(true, Theme.of(context).colorScheme),
            icon: AppIcons.notificationIcon,
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 20 / 15,
        ),
        itemBuilder: (context, index) {
          final String image = AssetManager.exampleImage;
          return Card(
            child: InkWell(
              onTap: () {},
              child: AnimalItemPage(
                image: image,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: AppIcons.homeIcon,
            label: AppStrings.navigationHome,
          ),
          NavigationDestination(
            //Needs to be replaced with lost icon
            icon: AppIcons.lostIcon,
            label: AppStrings.navigationLost,
          ),
          NavigationDestination(
            icon: AppIcons.addIcon,
            label: AppStrings.navigationAdd,
          ),
          NavigationDestination(
            //Needs to be replaced with found icon
            icon: AppIcons.foundIcon,
            label: AppStrings.navigationFound,
          ),
          NavigationDestination(
            icon: AppIcons.profileIcon,
            label: AppStrings.navigationProfile,
          ),
        ],
        selectedIndex: 0,
      ),
    );
  }
}
