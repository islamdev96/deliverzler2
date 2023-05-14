import 'dart:async';

import 'package:deliverzler/core/presentation/extensions/auto_dispose_ref_extension.dart';
import 'package:deliverzler/features/map/domain/entities/place_autocomplete.dart';
import 'package:deliverzler/features/map/domain/use_cases/get_place_autocomplete_uc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'place_autocomplete_provider.g.dart';

@riverpod
AsyncValue<List<PlaceAutocomplete>> placeAutocompleteState(
  PlaceAutocompleteStateRef ref,
) {
  final query = ref.watch(placeAutocompleteQueryProvider);
  return query.match(
    () => const AsyncData([]),
    (query) => ref.watch(getPlaceAutocompleteProvider(query)),
  );
}

final placeAutocompleteQueryProvider =
    StateProvider.autoDispose<Option<String>>((ref) {
  return const None();
});

class AbortedException implements Exception {}

@riverpod
Future<List<PlaceAutocomplete>> getPlaceAutocomplete(
  GetPlaceAutocompleteRef ref,
  String autocompleteQuery,
) async {
  final cancelToken = ref.cancelToken();

  // Debouncing the request. By having this delay, it leaves the opportunity
  // for consumers to subscribe to a different `autocompleteQuery` parameter.
  // In which case, this request will be aborted.
  await Future<void>.delayed(const Duration(milliseconds: 300));
  if (cancelToken.isCancelled) throw AbortedException();

  final params = GetPlaceAutocompleteParams(
    cancelToken: cancelToken,
    placeName: autocompleteQuery,
  );
  final places = await ref.watch(getPlaceAutocompleteUCProvider).call(params);
  return places;
}
