import 'dart:async';

import 'package:ota_update/ota_update.dart';

class OTAManager{


  Future<Stream<OtaEvent>?> tryOtaUpdate() async {
    Stream<OtaEvent>? stream = null;
    try {
      print('ABI Platform: ${await OtaUpdate().getAbi()}');
     stream = OtaUpdate()
          .execute(
       'https://appdistribution.firebase.google.com/testerapps/1:44382695843:android:22ce0fa6bac879d1cbea16/releases/1ke6vu5hqrmu0?utm_source=firebase-console',
       // 'https://internal1.4q.sk/flutter_hello_world.apk',
        // sha256checksum: 'd6da28451a1e15cf7a75f2c3f151befad3b80ad0bb232ab15c20897e54f21478',
      );

      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      print('Failed to make OTA update. Details: $e');
      rethrow;
    }
    return stream;
  }

}