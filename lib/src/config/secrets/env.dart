import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'lock.env')
abstract class Env {
  @EnviedField(useConstantCase: true, obfuscate: true)
  static final String apiKey = _Env.apiKey;
}
