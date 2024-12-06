import 'package:url_launcher/url_launcher.dart';

Future<void> dialerButton(String number) async {
  String phone = "+91$number";
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phone,
  );
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    print('Could not launch $launchUri');
  }
}
