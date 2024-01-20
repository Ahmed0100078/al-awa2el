import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:madaresco/features/TeacherRooms/data/data_sources/teachers_rooms_data_source.dart';
import 'package:madaresco/features/TeacherRooms/data/models/Filterd%20studentsModel.dart';

part 'getfilterdstudents_state.dart';

class GetfilterdstudentsCubit extends Cubit<GetfilterdstudentsState> {
  GetfilterdstudentsCubit(this._roomsRemoteDataSource)
      : super(GetfilterdstudentsInitial());
  TeachersRoomsRemoteDataSource _roomsRemoteDataSource;

  getFilterdStudents({int? section, int? grade}) async {
    emit(GetfilterdstudentsLoading());
    // try {
    FilteredStudentsModels studentModel =
        await _roomsRemoteDataSource.getFilterdStudents(section!, grade!);
    emit(GetfilterdstudentsSuccess(studentModel));
    // } on DioError catch (e) {
    //   log('Exception ${e.response.data}');
    //   emit(
    //     GetfilterdstudentsFailier(
    //       e.response.data['message'].toString(),
    //     ),
    //   );
    // } catch (e) {
    //   log('Exception ${e.toString}');
    //   emit(GetfilterdstudentsFailier(
    //     'من فضلك حاول مجددا في وقت لاحق',
    //   ));
    // }
  }
}
