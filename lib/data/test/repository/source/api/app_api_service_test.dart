// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import '../../../../data.dart';
// import '../../../fake_data.dart';

// class MockNoneAuthAppServerApiClient extends Mock implements NoneAuthAppServerApiClient {}

// class MockAuthAppServerApiClient extends Mock implements AuthAppServerApiClient {}

// class MockRandomUserApiClient extends Mock implements RandomUserApiClient {}

// class MockMockApiClient extends Mock implements MockApiClient {}

// void main() {
//   group('happy cases', () {
//     late AppApiService appApiService;
//     final _noneAuthAppServerApiClient = MockNoneAuthAppServerApiClient();
//     final _authAppServerApiClient = MockAuthAppServerApiClient();
//     final _randomUserApiClient = MockRandomUserApiClient();

//     setUp(() {
//       appApiService = AppApiService(
//         _noneAuthAppServerApiClient,
//         _authAppServerApiClient,
//         _randomUserApiClient,
//       );
//     });

//     test('login', () async {
//       when(
//         () => _noneAuthAppServerApiClient.request<DataResponse<AuthResponseData>, AuthResponseData>(
//           method: RestMethod.post,
//           path: '/v1/auth/login',
//           body: {
//             'email': inputEmail,
//             'password': inputPassword,
//           },
//           decoder: AuthResponseData.fromJson,
//         ),
//       ).thenAnswer(
//         (_) => Future.value(DataResponse(data: authResponseData)),
//       );

//       final result = await appApiService.login(inputEmail, inputPassword);

//       expect(
//         result.data,
//         authResponseData,
//       );
//     });

//     tearDown(() {});
//   });
// }
