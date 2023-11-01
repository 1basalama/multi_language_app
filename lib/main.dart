import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_language_app/translations/locale_keys.g.dart';

/// طريقة انشاء تطبيق فلتر متعدد اللغات
/// Source : https://pub.dev/packages/easy_localization
///  قم بانشاء مشروع فلتر جديد وانسخ الكود المرفق هذا

//1)  easy_localization تثبيت الحزمة
//1) install easy_localization: ^3.0.0

//2) تعريف ملفات الترجمة
//2) Declare an assets folder in pubspec.yaml file:
//   assets:
//     - assets/Translations/

//3)  انشاء ملفات الترجمة
//3) Create translation files in assets/Translations/[en.json , ar.json]
// ex {"appTitle": "العنوان", "hi": "اهلا"}

//4) تنفيذ الكود التالي
//4) Generate locale_keys by running the following code:
// flutter pub run easy_localization:generate -S assets/Translations -f keys -O lib/translations -o locale_keys.g.dart
// عند اضافة ترجمات جديدة في الملفات يجب تنفيذ الكود مرة أخرى

//5) طريقة الاستخدام
//5) how to use :
// context.setLocale(Locale('ar')); كود تغيير اللغة
//LocaleKeys.appTitle.tr()  كود استخدام النص المترجم

class Translations {
  static final all = [
    const Locale('en'),
    const Locale('ar'),
  ];
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: Translations.all,
    path: 'assets/Translations',
    fallbackLocale: Translations.all[0],

    // هذا الكود لتحديد اللغة الافتراضية .عند ازالته  يكون على حسب لغة النظام
    //startLocale: const Locale('ar'),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _CVAppState createState() => _CVAppState();
}

class _CVAppState extends State<MyApp> {
  bool isDarkModeEnabled = false;
  bool isArabicEnabled = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      title: "appTitle".tr(),

      ///يتم ترجمة النص و وتحويل اتجاه الكتابة وفقا للغة   [.tr()] عند اضافة
      theme: isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),

      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: MyText('appTitle',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
          actions: [
            Icon(
              !isDarkModeEnabled ? Icons.sunny : Icons.dark_mode,
              color: !isDarkModeEnabled ? Colors.yellow : Colors.white,
            ),
            Switch(
              value: isDarkModeEnabled,
              onChanged: (value) {
                setState(() {
                  isDarkModeEnabled = value;
                });
              },
            ),
            IconButton(
                onPressed: () {
                  if (isArabicEnabled) {
                    context.setLocale(Locale('en'));
                    //context.setLocale(Locale('ar', 'EG'));
                    isArabicEnabled = false;
                  } else {
                    context.setLocale(Locale('ar'));
                    isArabicEnabled = true;
                  }
                },
                icon: Icon(Icons.language))
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Center(
              child: CircleAvatar(
                radius: 80.0,
                backgroundImage: AssetImage('assets/drawables/photo.jpg'),
              ),

            ),
            //Image(image:AssetImage('assets/drawables/photo.jpg')),
            SizedBox(height: 16.0),
            MyText(
              'name',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            MyText(
              'jop',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            MyListTitle(
              title: 'mobile',
              subtitle: '775516556',
              leadingIcon: Icons.mobile_friendly,
            ),
            MyListTitle(
              title: 'Email',
              subtitle: '0.basalama.1@gmail.com',
              leadingIcon: Icons.email,
            ),
            MyListTitle(
              title: 'Location',
              subtitle: 'CityCountry',
              leadingIcon: Icons.location_on,
            ),

            SizedBox(height: 16.0),
            MyText(
              'Experience',
            ),
            SizedBox(height: 8.0),

            MyListTitle(
              title: 'Company',
              subtitle: 'PositionDate',
              leadingIcon: Icons.work,
              trailingIcon: Icons.arrow_forward,
            ),
            MyListTitle(
              title: 'Company2',
              subtitle: 'PositionDate2',
              leadingIcon: Icons.work,
              trailingIcon: Icons.arrow_forward,
            ),

            // Add more experience items as needed
            SizedBox(height: 16.0),
            MyText('Education'),
            SizedBox(height: 8.0),
            MyListTitle(
              title: 'University',
              subtitle: 'DegreeDate',
              leadingIcon: Icons.school,
              trailingIcon: Icons.arrow_forward,
            ),

            // Add more education items as needed
            SizedBox(height: 16.0),
            MyText(
              'Skills',
            ),
            SizedBox(height: 8.0),

            SkillBar(
              skill: 'Programming',
              level: 0.7,
            ),
            SkillBar(
              skill: 'Design',
              level: 0.65,
            ),
            // Add more skills as needed
            SizedBox(height: 16.0),
            MyText('Languages'),
            SizedBox(height: 8.0),

            SkillBar(
              skill: 'English',
              level: 0.8,
            ),
            SkillBar(
              skill: 'French',
              level: 0.65,
            ),

            // Add more languages as needed
          ],
        ),
      ),
    );
  }
}

class MyText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;

  const MyText(this.text, {this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    );

    return Text(
      text,
      style: style ?? defaultStyle,
      textAlign: textAlign ?? TextAlign.start,
    ).tr();
  }
}

class MyListTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  MyListTitle({
    required this.title,
    required this.subtitle,
    this.leadingIcon,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: Colors.blue,
      leading:
          leadingIcon != null ? Icon(leadingIcon) : const SizedBox.shrink(),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ).tr(),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 14.0,
        ),
      ).tr(),
      trailing:
          trailingIcon != null ? Icon(trailingIcon) : const SizedBox.shrink(),
    );
  }
}

class SkillBar extends StatelessWidget {
  final String skill;
  final double level;

  const SkillBar({super.key, required this.skill, required this.level});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          skill,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          height: 8.0,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: FractionallySizedBox(
            widthFactor: level,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
