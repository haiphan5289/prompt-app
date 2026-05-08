import '../../domain/repositories/ai_repository.dart';
import '../datasources/ai_remote_datasource.dart';

class AIRepositoryImpl implements AIRepository {
  const AIRepositoryImpl(this._datasource);

  final AIRemoteDatasource _datasource;

  @override
  Future<String> runPrompt(String enhancedPrompt) =>
      _datasource.runPrompt(enhancedPrompt);
}
