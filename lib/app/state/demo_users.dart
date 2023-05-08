import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

/// Demo application users.
enum AppUser {
  nurlan,
  // alexey,
  // tambi,
  //ilya,
}

/// Convenient class Extension on [AppUser] enum
extension AppUserX on AppUser {
  /// Convenient method Extension to generate an [id] from [AppUser] enum
  String? get id => {
        AppUser.nurlan: 'nurlan-saburov',
        //       AppUser.alexey: 'alexey-shcherbakov',
//        AppUser.tambi: 'tambi-masai',
        //       AppUser.ilya: 'ilya-makarov',
      }[this];

  /// Convenient method Extension to generate a [name] from [AppUser] enum
  String? get name => {
        AppUser.nurlan: 'Вход',
        //    AppUser.alexey: 'Alexey Shcherbakov',
        // AppUser.tambi: 'Аккаунт2',
        //      AppUser.ilya: 'Ilya Makarov',
      }[this];

  /// Convenient method Extension to generate [data] from [AppUser] enum
  Map<String, Object>? get data => {
        AppUser.nurlan: {
          'first_name': 'Nurlan',
          'last_name': 'Saburov',
          'full_name': 'Nurlan Saburov',
        },
        /* AppUser.alexey: {
          'first_name': 'Alexey',
          'last_name': 'Shcherbakov',
          'full_name': 'Alexey Shcherbakov',
        },*/
        /* AppUser.tambi: {
          'first_name': 'Tambi',
          'last_name': 'Masai',
          'full_name': 'Tambi Masai',
        },*/
        /*     AppUser.ilya: {
          'first_name': 'Ilya',
          'last_name': 'Makarov',
          'full_name': 'Ilya Makarov',
       },*/
      }[this];

  /// Convenient method Extension to generate a [token] from [AppUser] enum
  Token? get token => <AppUser, Token>{
        AppUser.nurlan: const Token(// nurlan-saburov
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2ODMzMDQ2MjAsInVzZXJfaWQiOiJudXJsYW4tc2FidXJvdiJ9.-xDqu9P-T5BiyZUw1QkvjrN_bEPFjT6JcOt7sdno4SE'),
        //      AppUser.alexey: const Token(
        //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2ODI1MDA1NTQsInVzZXJfaWQiOiJhbGV4ZXktc2hjaGVyYmFrb3YifQ.XgsfsgN4Z2PR2SbfEwZ3YALMmUulREDFbIBLw2QKltw'),
        //    AppUser.tambi: const Token(
        //        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2ODI1MDY3MDYsInVzZXJfaWQiOiJ0YW1iaS1tYXNhaSJ9.jU5y8YMWS6uEDpUuij6VqwKGS-rxZl8a4lAUg_XAbi4'),
        //     AppUser.ilya: const Token(
        //         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2ODI1MDA2MzAsInVzZXJfaWQiOiJpbHlhLW1ha2Fyb3YifQ.9vZICVLr9UDPU12o-zWan8ZS5QJyNHZ3XDSJ8nTpoyM'),
      }[this];
}
