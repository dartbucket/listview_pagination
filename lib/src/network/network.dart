import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final networkHandlerProvider = Provider((ref) => NetworkHandler());

class NetworkHandler{
  Future<Response?> getRequest({ required String url }) async {
    final uri = Uri.parse(url);
    try{
      final response = await get(uri);
      return response;
    }catch(e){
      log("Fialed to complete request");
      return null;
    }
  }
}