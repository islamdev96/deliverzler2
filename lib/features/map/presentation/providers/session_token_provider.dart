import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

//Note: Should Generate a fresh token for each session (refresh the provider).
//The session begins when the user starts typing a query, and concludes when they select a place and a call to Place Details is made.
//For more details about using session token with google maps:
//https://developers.google.com/maps/documentation/places/web-service/session-tokens
final sessionTokenProvider = StateProvider<String>((ref) {
  return const Uuid().v4();
});
