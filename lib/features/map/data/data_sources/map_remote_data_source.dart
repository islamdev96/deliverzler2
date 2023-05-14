import 'package:deliverzler/core/data/network/google_map_api/api_callers/google_map_api_caller.dart';
import 'package:deliverzler/core/data/network/google_map_api/google_map_api_config.dart';
import 'package:deliverzler/core/data/network/i_api_caller.dart';
import 'package:deliverzler/features/map/data/models/place_autocomplete_model.dart';
import 'package:deliverzler/features/map/data/models/place_details_model.dart';
import 'package:deliverzler/features/map/data/models/place_directions_model.dart';
import 'package:deliverzler/features/map/domain/use_cases/get_place_autocomplete_uc.dart';
import 'package:deliverzler/features/map/domain/use_cases/get_place_details_uc.dart';
import 'package:deliverzler/features/map/domain/use_cases/get_place_directions_uc.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_remote_data_source.g.dart';

abstract class IMapRemoteDataSource {
  /// Calls the api endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<PlaceAutocompleteModel>> getPlaceAutocomplete(
      GetPlaceAutocompleteParams params);

  Future<PlaceDetailsModel> getPlaceDetails(GetPlaceDetailsParams params);

  Future<PlaceDirectionsModel> getPlaceDirections(
      GetPlaceDirectionsParams params);
}

@Riverpod(keepAlive: true)
IMapRemoteDataSource mapRemoteDataSource(MapRemoteDataSourceRef ref) {
  return MapRemoteDataSource(
    ref,
    apiCaller: ref.watch(googleMapApiCallerProvider),
  );
}

class MapRemoteDataSource implements IMapRemoteDataSource {
  MapRemoteDataSource(
    this.ref, {
    required this.apiCaller,
  });

  final Ref ref;
  final IApiCaller apiCaller;

  static const String googleMapAutoCompletePath = '/place/autocomplete/json';
  static const String googleMapPlaceDetailsPath = '/place/details/json';
  static const String googleMapDirectionsPath = '/directions/json';

  @override
  Future<List<PlaceAutocompleteModel>> getPlaceAutocomplete(
      GetPlaceAutocompleteParams params) async {
    final Response response = await apiCaller.getData(
      path: googleMapAutoCompletePath,
      queryParameters: {
        'types': '(cities)',
        //Add countries you desire for search suggestions.
        'components': 'country:eg',
        ...params.toMap(),
      },
      options: Options(
        extra: {GoogleMapApiConfig.withSessionTokenExtraKey: true},
      ),
      cancelToken: params.cancelToken,
    );
    return PlaceAutocompleteModel.parseListOfMap(response.data['predictions']);
  }

  @override
  Future<PlaceDetailsModel> getPlaceDetails(
      GetPlaceDetailsParams params) async {
    final Response response = await apiCaller.getData(
      path: googleMapPlaceDetailsPath,
      queryParameters: {
        'fields': 'geometry', //Specify wanted fields to lower billing rate
        ...params.toMap(),
      },
      options: Options(
        extra: {GoogleMapApiConfig.withSessionTokenExtraKey: true},
      ),
      cancelToken: params.cancelToken,
    );
    return PlaceDetailsModel.fromMap(response.data['result']);
  }

  @override
  Future<PlaceDirectionsModel> getPlaceDirections(
      GetPlaceDirectionsParams params) async {
    final Response response = await apiCaller.getData(
      path: googleMapDirectionsPath,
      queryParameters: params.toMap(),
      cancelToken: params.cancelToken,
    );
    return PlaceDirectionsModel.fromMap(response.data);
  }
}
