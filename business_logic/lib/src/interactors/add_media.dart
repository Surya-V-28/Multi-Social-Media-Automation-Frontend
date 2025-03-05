import 'package:business_logic/business_logic.dart';
import 'package:business_logic/src/access_token_repository/access_token_repository.dart';
import 'package:business_logic/src/user_repository.dart';
import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';

class AddMediaInteractor {
  const AddMediaInteractor(
    this._accessTokenRepository, 
    this._userRepository,
    this._backendClient,
    this._dio,
  );

  Future<void> perform(XFile file) async {
    final Uuid uuid = Uuid();

    final accessToken = (await _accessTokenRepository.getToken())!;
    final user = (await _userRepository.getUser())!;

    final fileExtension = file.name.substring(file.name.lastIndexOf(".") + 1);
    final mimeType = MimeType.fromFileExtension(fileExtension);

    final (key, url) = await _backendClient.mediaLibrary
      .getUploadUrl(mimeType, '${uuid.v4()}_${file.name}', accessToken);
    await _uploadToS3(url, file, mimeType);

    final requestBody = CreateMediaRequestBody(
      mediaInfo: CreateMediaMediaInfo(
        id: key,
        name: key,
        mimeType: mimeType,
        size: await file.length(),
      ),
      mediaTypeDetails: (mimeType.type == 'image')
        ? ImageCreateMediaRequestBodyMediaTypeDetails(width: 2000, height: 2000,)
        : VideoCreateMediaRequestBodyMediaTypeDetails(duration: 3000,),
    );
    _backendClient.mediaLibrary.createMedia(requestBody, user.id, accessToken);
  }

  Future<void> _uploadToS3(Uri url, XFile file, MimeType mimeType) async {
    final headers = { 'Content-Type': mimeType.toString() };
    await _dio.putUri(
      url,
      data: await file.readAsBytes(),
      options: Options(headers: headers),
    );
  }


  final AccessTokenRepository _accessTokenRepository;
  final UserRepository _userRepository;
  final BackendClient _backendClient;
  final Dio _dio;
}
