import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_snkrs_clone/features/database/database_repository_impl.dart';
import 'package:nike_snkrs_clone/models/user_model.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;

  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserData);
  }

  _fetchUserData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
    List<UserModel> listofUserData =
        await _databaseRepository.retrieveUserData();
    emit(DatabaseSuccess(listofUserData, event.displayName));
  }
}
