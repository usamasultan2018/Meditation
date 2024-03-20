import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/controller/theme/theme_controller.dart';
class SelectTheme extends StatelessWidget {
  const SelectTheme({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Theme'),
      ),
      body: Consumer<ThemeModeProvider>(
        builder: (context, themeModeProvider, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text('Light Mode'),
                  value: themeModeProvider.themeMode == ThemeMode.light,
                  onChanged: (value) {
                    themeModeProvider.themeMode = value! ? ThemeMode.light : ThemeMode.system;
                  },
                ),
                CheckboxListTile(
                  title: Text('Dark Mode'),
                  value: themeModeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    themeModeProvider.themeMode = value! ? ThemeMode.dark : ThemeMode.system;
                  },
                ),
                CheckboxListTile(
                  title: Text('System Mode'),
                  value: themeModeProvider.themeMode == ThemeMode.system,
                  onChanged: (value) {
                    themeModeProvider.themeMode = value! ? ThemeMode.system : ThemeMode.light;
                  },
                ),
              ],
            ),
          );
        },
      ),
    );;
  }
}
