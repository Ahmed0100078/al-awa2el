
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madaresco/features/TeacherRooms/data/data_sources/teachers_rooms_data_source.dart';
import 'package:madaresco/features/TeacherRooms/data/models/GradesListModel.dart';

part 'getgrades_state.dart';

class GetgradesCubit extends Cubit<GetgradesState> {
  GetgradesCubit(this._roomsRemoteDataSource) : super(GetgradesInitial());
  TeachersRoomsRemoteDataSource _roomsRemoteDataSource;

  getGrades() async {
    emit(GetgradesLoading());
    //   try {
    GradesListModel gradesModel = await _roomsRemoteDataSource.getGrades();
    emit(GetgradesSuccess(gradesModel));
    // }
    //  on DioError catch (e) {
    //   log('Exception ${e.response.data}');
    //   emit(
    //     GetgradesFailier(
    //       e.response.data['message'].toString(),
    //     ),
    //   );
    // } catch (e) {
    //   log('Exception ${e.toString}');
    //   emit(GetgradesFailier(
    //     'من فضلك حاول مجددا في وقت لاحق',
    //   ));
    // }
  }
}
