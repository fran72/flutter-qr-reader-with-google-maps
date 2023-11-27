import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/models.dart';

Future<void> launchUrlFuture(BuildContext context, ScanModel scan) async {
  final Uri url = Uri.parse(scan.value);

  debugPrint('enttaaararararraff');

  if (scan.type == 'http') {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  } else {
    debugPrint('geo!!');
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
