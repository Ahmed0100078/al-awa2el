import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:madaresco/features/TeacherRooms/data/data_sources/teachers_rooms_data_source.dart';
import 'package:madaresco/features/TeacherRooms/data/models/SectionsListModel.dart';

part 'get_sections_state.dart';

class GetSectionsCubit extends Cubit<GetSectionsState> {
  GetSectionsCubit(this._roomsRemoteDataSource) : super(GetSectionsInitial());
  TeachersRoomsRemoteDataSource _roomsRemoteDataSource;

  getSections() async {
    emit(GetSectionsLoading());
    try {
      SectionsListModel sectionsModel = await _roomsRemoteDataSource.getSections();
      emit(GetSectionsSucess(sectionsModel));
    } on DioError catch (e) {
      log('Exception ${e.response!.data}');
      emit(
        GetSectionsFailier(
          e.response!.data['message'].toString(),
        ),
      );
    } catch (e) {
      log('Exception ${e.toString}');
      emit(GetSectionsFailier(
        'من فضلك حاول مجددا في وقت لاحق',
      ));
    }
  }
}
