import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditation/view/setting/language/select_language.dart';
import 'package:meditation/view/setting/select_theme/select_theme.dart';
import 'package:package_info_plus/package_info_plus.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  var auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }
  Widget build(BuildContext context) {
    print(_packageInfo.version);
    return  Scaffold(
      appBar: AppBar(
        title: Text("Setting Screen"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.lightGreenAccent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text("Get Pro Version",style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),),
                ),
                SizedBox(height: 5,),
                Text("Account",style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),),

                ListTile(
                  leading: Icon(Icons.deblur),
                  title: Text("Debug Menu"),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Email Address"),
                  subtitle: Text("${auth.currentUser!.email}"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return SelectTheme();
                    }));
                  },
                  leading: Icon(Icons.dark_mode),
                  title: Text("Select Theme"),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx){
                      return SelectLanguage();
                    }));
                  },
                  leading: Icon(Icons.language),
                  title: Text("Language"),
                ),
                ListTile(
                  leading: Icon(Icons.star_rate),
                  title: Text("Rate my app"),
                ),
                Text("Info",style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),),
                ListTile(
                  leading: Icon(Icons.privacy_tip_sharp),
                  title: Text("Privacy Policy"),
                ),
                ListTile(
                  leading: Icon(Icons.terminal_sharp),
                  title: Text("Term of Service"),
                ),
                ListTile(
                  leading: Icon(Icons.sms),
                  title: Text("Contact"),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("Version"),
                  subtitle: Text(_packageInfo != null ? _packageInfo.version:''),
                ),
                Text("Session",style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Logout"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
