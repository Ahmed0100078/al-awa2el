import 'package:get_it/get_it.dart';
import 'package:madaresco/features/AboutApp/data/data_sources/about_app_remote_data_source.dart';
import 'package:madaresco/features/AboutApp/data/repositories/about_app_repo_impl.dart';
import 'package:madaresco/features/AboutApp/domain/use_cases/get_about_app_use_case.dart';
import 'package:madaresco/features/AboutApp/presentation/manager/about_app_view_model.dart';
import 'package:madaresco/features/Absence/data/data_sources/absence_remote_data_source.dart';
import 'package:madaresco/features/Absence/data/repositories/absence_repo_impl.dart';
import 'package:madaresco/features/Absence/domain/repositories/absence_repo.dart';
import 'package:madaresco/features/Absence/domain/use_cases/get_absence_use_case.dart';
import 'package:madaresco/features/Absence/presentation/manager/absence_view_model.dart';
import 'package:madaresco/features/AddOnlineLesson/data/data_sources/add_online_lesson_remote_data_source.dart';
import 'package:madaresco/features/AddOnlineLesson/data/repositories/add_online_lesson_repo_impl.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/repositories/add_online_lesson_repo.dart';
import 'package:madaresco/features/AddOnlineLesson/domain/use_cases/get_stages_use_case.dart'
    as on;
import 'package:madaresco/features/AddOnlineLesson/domain/use_cases/get_students_use_case.dart';
import 'package:madaresco/features/AddOnlineLesson/presentation/manager/add_online_lesson_view_model.dart';
import 'package:madaresco/features/AllLessons/data/data_sources/all_lessons_remote_data_source.dart';
import 'package:madaresco/features/AllLessons/data/repositories/all_lessons_repo_impl.dart';
import 'package:madaresco/features/AllLessons/domain/repositories/all_lessons_repo.dart';
import 'package:madaresco/features/AllLessons/domain/use_cases/get_lessons_use_case.dart';
import 'package:madaresco/features/AllLessons/presentation/manager/all_lessons_viewmode.dart';
import 'package:madaresco/features/AllTeacher/data/data_sources/all_teachers_data_source.dart';
import 'package:madaresco/features/AllTeacher/data/repositories/all_teachers_repo_impl.dart';
import 'package:madaresco/features/AllTeacher/domain/repositories/all_teachers_repo.dart';
import 'package:madaresco/features/AllTeacher/domain/use_cases/get_all_teachers_use_case.dart';
import 'package:madaresco/features/AllTeacher/presentation/manager/all_teachers_view_model.dart';
import 'package:madaresco/features/Annual/domain/repositories/annual_repo.dart';
import 'package:madaresco/features/Annual/domain/use_cases/get_annuals_use_case.dart';
import 'package:madaresco/features/Annual/presentation/manager/annuals_view_model.dart';
import 'package:madaresco/features/ChatWithPerson/data/data_sources/chat_remote_data_source.dart';
import 'package:madaresco/features/ChatWithPerson/data/repositories/chat_repo_impl.dart';
import 'package:madaresco/features/ChatWithPerson/domain/use_cases/get_chat_use_case.dart';
import 'package:madaresco/features/ChatWithPerson/domain/use_cases/get_pusher_data_use_case.dart';
import 'package:madaresco/features/ChatWithPerson/domain/use_cases/send_message_use_case.dart';
import 'package:madaresco/features/ChatWithPerson/presentation/manager/chat_view_model.dart';
import 'package:madaresco/features/Curricula/data/data_sources/curricula_data_source.dart';
import 'package:madaresco/features/Curricula/domain/repositories/curricula_repo.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_curricula_use_case.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_grades_use_case.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_stages_use_case.dart';
import 'package:madaresco/features/Curricula/domain/use_cases/get_subjects_use_case.dart';
import 'package:madaresco/features/CurriculaDetails/data/data_sources/curricula_details_remote_data_source.dart';
import 'package:madaresco/features/CurriculaDetails/domain/repositories/curricula_details_repo.dart';
import 'package:madaresco/features/CurriculaDetails/domain/use_cases/get_curricula_details.dart';
import 'package:madaresco/features/CurriculaDetails/presentation/manager/curricula_details_view_model.dart';
import 'package:madaresco/features/ExamResult/data/data_sources/exam_results_remote_data_source.dart';
import 'package:madaresco/features/ExamResult/data/repositories/exam_results_repo_impl.dart';
import 'package:madaresco/features/ExamResult/domain/repositories/exam_results_repo.dart';
import 'package:madaresco/features/ExamResult/domain/use_cases/get_exams_results_use_case.dart';
import 'package:madaresco/features/ExamResult/presentation/manager/exam_results_view_model.dart';
import 'package:madaresco/features/ExamSchedule/data/data_sources/exam_schedule_remote_datasource.dart';
import 'package:madaresco/features/ExamSchedule/data/repositories/exam_schedule_repo_impl.dart';
import 'package:madaresco/features/ExamSchedule/domain/use_cases/get_exam_schedule_use_case.dart';
import 'package:madaresco/features/ExamSchedule/presentation/manager/exam_schedule_view_model.dart';
import 'package:madaresco/features/ExamSubjects/data/data_sources/exam_subjects_remote_data_source.dart';
import 'package:madaresco/features/ExamSubjects/data/repositories/exam_subjects_repo_impl.dart';
import 'package:madaresco/features/ExamSubjects/domain/repositories/exam_subjects_repo.dart';
import 'package:madaresco/features/ExamSubjects/domain/use_cases/get_subjects_use_case.dart';
import 'package:madaresco/features/ExamSubjects/presentation/manager/exam_subjects_view_model.dart';
import 'package:madaresco/features/Gallary/data/data_sources/gallarys_remote_data_source.dart';
import 'package:madaresco/features/Gallary/data/repositories/gallarys_repo_impl.dart';
import 'package:madaresco/features/Gallary/domain/repositories/gallary_repo.dart';
import 'package:madaresco/features/Gallary/domain/use_cases/get_gallarys_use_case.dart';
import 'package:madaresco/features/Gallary/presentation/manager/gallary_view_model.dart';
import 'package:madaresco/features/GallaryDetails/data/data_sources/gallary_details_remote_data_source.dart';
import 'package:madaresco/features/GallaryDetails/data/repositories/gallary_details_repo_impl.dart';
import 'package:madaresco/features/GallaryDetails/domain/repositories/gallary_details_repo.dart';
import 'package:madaresco/features/GallaryDetails/domain/use_cases/get_gallary_details_use_case.dart';
import 'package:madaresco/features/GallaryDetails/presentation/manager/gallary_details_view_model.dart';
import 'package:madaresco/features/LessonDetails/data/data_sources/get_lesson_details_remote_data_source.dart';
import 'package:madaresco/features/LessonDetails/data/repositories/get_lesson_details_repo_impl.dart';
import 'package:madaresco/features/LessonDetails/domain/repositories/lesson_details_repo.dart';
import 'package:madaresco/features/LessonDetails/domain/use_cases/get_lessons_details_use_case.dart';
import 'package:madaresco/features/LessonDetails/presentation/manager/lesson_details_view_model.dart';
import 'package:madaresco/features/Login/domain/use_cases/login_use_case.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/repositories/madaresco_lesson_details_repo.dart';
import 'package:madaresco/features/MadarescoLessonDetails/domain/use_cases/get_madaresco_lesson_details_use_case.dart';
import 'package:madaresco/features/MadarescoLessons/data/data_sources/madaresco_lessons_remote_data_source.dart';
import 'package:madaresco/features/MadarescoLessons/data/repositories/madaresco_lessons_repo_impl.dart';
import 'package:madaresco/features/MadarescoLessons/domain/repositories/madaresco_lessons_repo.dart';
import 'package:madaresco/features/MadarescoLessons/domain/use_cases/get_madaresco_lessons_use_case.dart';
import 'package:madaresco/features/MadarescoLessons/presentation/manager/madaresco_view_model.dart';
import 'package:madaresco/features/Main/data/remote/data_sources/main_remote_data_source.dart';
import 'package:madaresco/features/Main/data/repositories/main_repo_impl.dart';
import 'package:madaresco/features/Main/domain/repositories/main_repo.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_NotificationCount.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_main_notifications.dart';
import 'package:madaresco/features/Main/domain/use_cases/get_student_data_use_case.dart';
import 'package:madaresco/features/Main/presentation/manager/MainViewModel.dart';
import 'package:madaresco/features/MainTeacher/data/remote/data_sources/main_teacher_remote_data_source.dart';
import 'package:madaresco/features/MainTeacher/domain/repositories/main_teacher_repo.dart';
import 'package:madaresco/features/MainTeacher/domain/use_cases/get_teacher_data_use_case.dart';
import 'package:madaresco/features/MainTeacher/presentation/manager/main_teacher_view_model.dart';
import 'package:madaresco/features/ManagerWord/domain/repositories/manager_word_repo.dart';
import 'package:madaresco/features/ManagerWord/domain/use_cases/manager_word_use_case.dart';
import 'package:madaresco/features/ManagerWord/presentation/manager/manager_word_view_model.dart';
import 'package:madaresco/features/MyProfile/data/data_sources/my_profile_remote_data_source.dart';
import 'package:madaresco/features/MyProfile/domain/repositories/my_profile_repo.dart';
import 'package:madaresco/features/MyProfile/domain/use_cases/edit_profile_use_case.dart';
import 'package:madaresco/features/MyProfile/domain/use_cases/get_my_profile_use_case.dart';
import 'package:madaresco/features/MyProfile/presentation/manager/my_profile_view_model.dart';
import 'package:madaresco/features/Notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:madaresco/features/Notifications/data/repositories/notifications_repo_impl.dart';
import 'package:madaresco/features/Notifications/domain/repositories/notification_repo.dart';
import 'package:madaresco/features/Notifications/domain/use_cases/get_notifications_use_case.dart';
import 'package:madaresco/features/Notifications/presentation/manager/notifications_view_model.dart';
import 'package:madaresco/features/OnlineLessons/data/data_sources/online_lessons_remote_data_source.dart';
import 'package:madaresco/features/OnlineLessons/domain/repositories/online_lesson_repo.dart';
import 'package:madaresco/features/OnlineLessons/domain/use_cases/get_online_lessons_use_case.dart';
import 'package:madaresco/features/OnlineLessons/presentation/manager/online_lessons_view_model.dart';
import 'package:madaresco/features/Register/data/repositories/register_repo_impl.dart';
import 'package:madaresco/features/Register/domain/repositories/register_repo.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_grades_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_schools_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_sections_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/get_stages_use_case.dart'
    as s;
import 'package:madaresco/features/Register/domain/use_cases/register_school_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/register_student_use_case.dart';
import 'package:madaresco/features/Register/domain/use_cases/register_teacher_use_case.dart';
import 'package:madaresco/features/Register/presentation/manager/register_view_model.dart';
import 'package:madaresco/features/SchoolNews/data/data_sources/school_news_remote_data_source.dart';
import 'package:madaresco/features/SchoolNews/domain/repositories/school_news_repo.dart';
import 'package:madaresco/features/SchoolNews/domain/use_cases/get_school_news_use_case.dart';
import 'package:madaresco/features/SchoolNews/presentation/manager/school_news_view_model.dart';
import 'package:madaresco/features/SchoolNewsDetails/data/repositories/school_news_details_repo_impl.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/repositories/school_news_details_repo.dart';
import 'package:madaresco/features/SchoolNewsDetails/domain/use_cases/get_school_news_details_use_case.dart';
import 'package:madaresco/features/SchoolNewsDetails/presentation/manager/school_news_details_view_model.dart';
import 'package:madaresco/features/StudentBehavior/data/datasources/student_behavior_remote_data_source.dart';
import 'package:madaresco/features/StudentBehavior/data/repositories/student_behavior_repo_impl.dart';
import 'package:madaresco/features/StudentBehavior/domain/repositories/student_behavior_repo.dart';
import 'package:madaresco/features/StudentBehavior/domain/usecases/get_student_behavior_use_case.dart';
import 'package:madaresco/features/StudentBehavior/presentation/manager/student_behavior_view_model.dart';
import 'package:madaresco/features/Subjects/data/data_sources/subjects_remote_data_source.dart';
import 'package:madaresco/features/Subjects/data/repositories/subjects_repo_impl.dart';
import 'package:madaresco/features/Subjects/domain/use_cases/get_subjects_use_case.dart';
import 'package:madaresco/features/Subjects/presentation/manager/subject_viewmodel.dart';
import 'package:madaresco/features/Supervisor/data/remote/data_sources/Supervisor_Data_Sources.dart';
import 'package:madaresco/features/Supervisor/domain/repositories/supervisor_repo.dart';
import 'package:madaresco/features/Supervisor/domain/use_cases/get_supervisor_data_use_case.dart';
import 'package:madaresco/features/Supervisor/presentation/manager/supervisor_view_model.dart';
import 'package:madaresco/features/TeacherRooms/data/data_sources/teachers_rooms_data_source.dart';
import 'package:madaresco/features/TeacherRooms/domain/repositories/teacher_rooms_repo.dart';
import 'package:madaresco/features/TeacherRooms/domain/use_cases/get_teacher_rooms_use_case.dart';
import 'package:madaresco/features/UploadLesson/data/data_sources/upload_lesson_remote_data_source.dart';
import 'package:madaresco/features/UploadLesson/domain/repositories/upload_lesson_repo.dart';
import 'package:madaresco/features/UploadLesson/domain/use_cases/get_stages_use_case.dart';
import 'package:madaresco/features/UploadLesson/domain/use_cases/get_subjects_use_case.dart'
    as su;
import 'package:madaresco/features/UploadLesson/domain/use_cases/upload_lesson_use_case.dart';
import 'package:madaresco/features/UploadLesson/presentation/manager/upload_lesson_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/Network/network.dart';
import 'features/AboutApp/domain/repositories/about_app_repo.dart';
import 'features/AddOnlineLesson/domain/use_cases/add_online_lesson_use_case.dart';
import 'features/Annual/data/remote/data_sources/annuals_remote_data_source.dart';
import 'features/Annual/data/repositories/annual_repo_impl.dart';
import 'features/ChatWithPerson/domain/repositories/chat_repo.dart';
import 'features/Curricula/data/repositories/curricula_repo_impl.dart';
import 'features/Curricula/presentation/manager/curricula_view_model.dart';
import 'features/CurriculaDetails/data/repositories/curricula_details_repo_impl.dart';
import 'features/ExamResult/domain/use_cases/get_exams_results_pdf_use_case.dart';
import 'features/ExamSchedule/domain/repositories/exam_schedule_repo.dart';
import 'features/Login/data/local/data_sources/login_local_datasource.dart';
import 'features/Login/data/remote/data_sources/login_remote_datasource.dart';
import 'features/Login/data/repositories/login_repo.dart';
import 'features/Login/domain/repositories/login_repository.dart';
import 'features/Login/presentation/manager/LoginViewModel.dart';
import 'features/MadarescoLessonDetails/data/data_sources/madaresco_lesson_remote_datasource.dart';
import 'features/MadarescoLessonDetails/data/repositories/madaresco_lesson_details_repo_impl.dart';
import 'features/MadarescoLessonDetails/presentation/manager/madaresco_lesson_details_view_model.dart';
import 'features/MainTeacher/data/repositories/main_teaacher_repo_impl.dart';
import 'features/ManagerWord/data/data_sources/manager_word_remote_data_source.dart';
import 'features/ManagerWord/data/repositories/manager_word_repo_impl.dart';
import 'features/MyProfile/data/repositories/my_profile_repo_impl.dart';
import 'features/OnlineLessons/data/repositories/online_lessons_repo_impl.dart';
import 'features/Register/data/data_sources/register_remote_data_source.dart';
import 'features/Schedule/data/data_sources/schedule_remote_data_source.dart';
import 'features/Schedule/data/repositories/schedule_repo_impl.dart';
import 'features/Schedule/domain/repositories/schedule_repo.dart';
import 'features/Schedule/domain/use_cases/get_schedule_use_case.dart';
import 'features/Schedule/presentation/manager/schedule_view_model.dart';
import 'features/SchoolNews/data/repositories/school_news_repo_impl.dart';
import 'features/SchoolNewsDetails/data/data_sources/school_news_details_remote_data_source.dart';
import 'features/Subjects/domain/repositories/subjects_repo.dart';
import 'features/Supervisor/data/repositories/supervisor_repo_impl.dart';
import 'features/TeacherRooms/data/repositories/teachers_rooms_repo_impl.dart';
import 'features/TeacherRooms/presentation/manager/teachers_rooms_view_model.dart';
import 'features/UploadLesson/data/repositories/upload_lesson_repo_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // region Features -Login
  sl.registerFactory(() => LoginViewModel(loginUseCase: sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton<LoginRepo>(
      () => LoginRepoImpl(localDataSource: sl(), remoteDataSource: sl()));
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(network: sl()));

  //! Core
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Network());
  //! External
  // endregion

  // region Features -MainStudent
  sl.registerFactory(() => MainViewModel(
      studentDataUseCase: sl(),
      mainNotifications: sl(),
      getNotificationsCount: sl()));
  sl.registerLazySingleton(() => GetMainNotifications(repo: sl()));
  sl.registerLazySingleton(() => GetStudentDataUseCase(repo: sl()));
  sl.registerLazySingleton<MainRepo>(
      () => MainRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<MainRemoteDataSource>(
      () => MainRemoteDataSourceImpl(network: sl()));
  //endregion

  // region Features -MainTeacher
  sl.registerFactory(() => MainTeacherViewModel(
        teacherDataUseCase: sl(),
        mainNotifications: sl(),
        getMainNotificationsCount: sl(),
      ));
  sl.registerLazySingleton(() => GetTeacherDataUseCase(repo: sl()));
  sl.registerLazySingleton<MainTeacherRepo>(
      () => MainTeacherRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<MainTeacherRemoteDataSource>(
      () => MainTeacherRemoteDataSourceImpl(network: sl()));
  sl.registerLazySingleton<GetMainNotificationsCount>(
      () => GetMainNotificationsCount(repo: sl()));
  //endregion

  // parent Features -supervisor
  sl.registerFactory(() =>
      SupervisorViewModel(supervisoDataUseCase: sl(), mainNotifications: sl()));
  sl.registerLazySingleton(() => GetSupervisorDataUseCase(repo: sl()));
  sl.registerLazySingleton<SupervisorRepo>(
      () => SupervisorRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<SupervisorRemoteDataSource>(
      () => SupervisorRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -Subjects
  sl.registerFactory(() => SubjectViewModel(subjectsUseCase: sl()));
  sl.registerLazySingleton(() => GetSubjectsUseCase(repo: sl()));
  sl.registerLazySingleton<SubjectsRemoteDataSource>(
      () => SubjectsRemoteDataSourceImpl(network: sl()));
  sl.registerLazySingleton<SubjectsRepo>(
      () => SubjectsRepoImpl(remoteDataSource: sl()));
  //endregion

  //region Features -AllLessons
  sl.registerFactory(() => AllLessonsViewModel(getLessonsUseCase: sl()));
  sl.registerLazySingleton(() => GetLessonsUseCase(repo: sl()));
  sl.registerLazySingleton<AllLessonsRepo>(
      () => AllLessonsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AllLessonsRemoteDataSource>(
      () => AllLessonsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -LessonDetails
  sl.registerFactory(() => LessonDetailsViewModel(lessonsDetailsUseCase: sl()));
  sl.registerLazySingleton(() => GetLessonsDetailsUseCase(repo: sl()));
  sl.registerLazySingleton<LessonDetailsRepo>(
      () => LessonDetailsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<GetLessonDetailsRemoteDataSource>(
      () => GetLessonDetailsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -Absence
  sl.registerFactory(() => AbsenceViewModel(absenceUseCase: sl()));
  sl.registerLazySingleton(() => GetAbsenceUseCase(repo: sl()));
  sl.registerLazySingleton<AbsenceRepo>(
      () => AbsenceRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AbsenceRemoteDataSource>(
      () => AbsenceRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -ExamSubjects
  sl.registerFactory(() => ExamSubjectsViewModel(examSubjectsUseCase: sl()));
  sl.registerLazySingleton(() => GetExamSubjectsUseCase(repo: sl()));
  sl.registerLazySingleton<ExamSubjectsRepo>(
      () => ExamSubjectsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ExamSubjectsRemoteDataSource>(
      () => ExamSubjectsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -ExamSchedule
  sl.registerFactory(() => ExamScheduleViewModel(examScheduleUseCase: sl()));
  sl.registerLazySingleton(() => GetExamScheduleUseCase(repo: sl()));
  sl.registerLazySingleton<ExamScheduleRepo>(
      () => ExamScheduleRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ExamScheduleRemoteDataSource>(
      () => ExamScheduleRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -Schedule
  sl.registerFactory(() => ScheduleViewModel(scheduleUseCase: sl()));
  sl.registerLazySingleton(() => GetScheduleUseCase(repo: sl()));
  sl.registerLazySingleton<ScheduleRepo>(
      () => ScheduleRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ScheduleRemoteDataSource>(
      () => ScheduleRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -StudentBehavior
  sl.registerFactory(
      () => StudentBehaviorViewModel(studentBehaviorUseCase: sl()));
  sl.registerLazySingleton(() => GetStudentBehaviorUseCase(repo: sl()));
  sl.registerLazySingleton<StudentBehaviorRepo>(
      () => StudentBehaviorRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<StudentBehaviorRemoteDataSource>(
      () => StudentBehaviorRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -Annuals
  sl.registerFactory(() => AnnualsViewModel(getAnnualsUseCase: sl()));
  sl.registerLazySingleton(() => GetAnnualsUseCase(repo: sl()));
  sl.registerLazySingleton<AnnualRepo>(
      () => AnnualRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AnnualsRemoteDataSource>(
      () => AnnualsRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -SchoolNews
  sl.registerFactory(() => SchoolNewsViewModel(schoolNewsUseCase: sl()));
  sl.registerLazySingleton(() => GetSchoolNewsUseCase(repo: sl()));
  sl.registerLazySingleton<SchoolNewsRepo>(
      () => SchoolNewsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<SchoolNewsRemoteDataSource>(
      () => SchoolNewsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -Gallary
  sl.registerFactory(() => GallaryViewModel(gallarysUseCase: sl()));
  sl.registerLazySingleton(() => GetGallarysUseCase(repo: sl()));
  sl.registerLazySingleton<GallaryRepo>(
      () => GallarysRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<GallarysRemoteDataSource>(
      () => GallarysRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -GallaryDetails
  sl.registerFactory(
      () => GallaryDetailsViewModel(gallaryDetailsUseCase: sl()));
  sl.registerLazySingleton(() => GetGallaryDetailsUseCase(repo: sl()));
  sl.registerLazySingleton<GallaryDetailsRepo>(
      () => GallaryDetailsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<GallaryDetailsRemoteDataSource>(
      () => GallaryDetailsRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -ExamResults
  sl.registerFactory(() => ExamResultsViewModel(examsResultsUseCase: sl(),getExamsResultsPdfUseCase: sl()));
  sl.registerLazySingleton(() => GetExamsResultsUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetExamsResultsPdfUseCase(repo: sl()));
  sl.registerLazySingleton<ExamResultsRepo>(
      () => ExamResultsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ExamResultsRemoteDataSource>(
      () => ExamResultsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -ManagerWord
  sl.registerFactory(() => ManagerWordViewModel(managerWordUseCase: sl()));
  sl.registerLazySingleton(() => GetManagerWordUseCase(repo: sl()));
  sl.registerLazySingleton<ManagerWordRepo>(
      () => ManagerWordRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ManagerWordRemoteDataSource>(
      () => ManagerWordRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -SchoolNewsDetails
  sl.registerFactory(
      () => SchoolNewsDetailsViewModel(schoolNewsEntityUseCase: sl()));
  sl.registerLazySingleton(() => GetSchoolNewsEntityUseCase(repo: sl()));
  sl.registerLazySingleton<SchoolNewsDetailsRepo>(
      () => SchoolNewsDetailsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<SchoolNewsDetailsRemoteDataSource>(
      () => SchoolNewsDetailsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -MyProfile
  sl.registerFactory(() =>
      MyProfileViewModel(myProfileUseCase: sl(), editProfileUseCase: sl()));
  sl.registerLazySingleton(() => EditProfileUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetMyProfileUseCase(repo: sl()));
  sl.registerLazySingleton<MyProfileRepo>(
      () => MyProfileRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<MyProfileRemoteDataSource>(
      () => MyProfileRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -AllTeachers
  sl.registerFactory(() => AllTeachersViewModel(allTeachersUseCase: sl()));
  sl.registerLazySingleton(() => GetAllTeachersUseCase(repo: sl()));
  sl.registerLazySingleton<AllTeachersRepo>(
      () => AllTeachersRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AllTeachersRemoteDataSource>(
      () => AllTeachersRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -Chat
  sl.registerFactory(() => ChatViewModel(
      chatUseCase: sl(), sendMessageUseCase: sl(), pusherDataUseCase: sl()));
  sl.registerLazySingleton(() => GetChatUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetPusherDataUseCase(repo: sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(repo: sl()));
  sl.registerLazySingleton<ChatRepo>(
      () => ChatRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -TeacherRooms
  sl.registerFactory(() => TeacherRoomViewModel(teacherRoomsUseCase: sl()));
  sl.registerLazySingleton(() => GetTeacherRoomsUseCase(repo: sl()));
  sl.registerLazySingleton<TeacherRoomsRepo>(
      () => TeacherRoomsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<TeachersRoomsRemoteDataSource>(
      () => TeachersRoomsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -UploadLesson
  sl.registerFactory(() => UploadLessonViewModel(
      uploadLessonUseCase: sl(),
      getStagesUseCase: sl(),
      sectionsUseCase: sl(),
      gradesUseCase: sl(),
      subjectsUseCase: sl()));
  sl.registerLazySingleton(() => UploadLessonUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetStagesUseCase(repo: sl()));
  sl.registerLazySingleton(() => su.GetSubjectsUseCase(repo: sl()));
  sl.registerLazySingleton<UploadLessonRepo>(
      () => UploadLessonRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<UploadLessonRemoteDataSource>(
      () => UploadLessonRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -AboutApp
  sl.registerFactory(() => AboutAppViewModel(aboutAppUseCase: sl()));
  sl.registerLazySingleton(() => GetAboutAppUseCase(repo: sl()));
  sl.registerLazySingleton<AboutAppRepo>(
      () => AboutAppRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AboutAppRemoteDataSource>(
      () => AboutAppRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -Notifications
  sl.registerFactory(() => NotificationsViewModel(notificationsUseCase: sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(repo: sl()));
  sl.registerLazySingleton<NotificationRepo>(
      () => NotificationsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<NotificationsRemoteDataSource>(
      () => NotificationsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -Registration
  sl.registerFactory(() => RegisterViewModel(
      registerSchoolUseCase: sl(),
      registerStudentUseCase: sl(),
      registerTeacherUseCase: sl(),
      schoolsWithGrades: sl(),
      gradesUseCase: sl(),
      stagesUseCase: sl(),
      sectionsUseCase: sl()));
  sl.registerLazySingleton(() => RegisterSchoolUseCase(repo: sl()));
  sl.registerLazySingleton(() => RegisterTeacherUseCase(repo: sl()));
  sl.registerLazySingleton(() => RegisterStudentUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetSchoolsUseCase(repo: sl()));
  sl.registerLazySingleton(() => s.GetStagesUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetGradesUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetSectionsUseCase(repo: sl()));
  sl.registerLazySingleton<RegisterRepo>(
      () => RegisterRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -MadarescoLessons
  sl.registerFactory(() => MadarescoLessonsViewModel(
        madarescoLessonsUseCase: sl(),
        stagesUseCase: sl(),
        gradesUseCase: sl(),
      ));
  sl.registerLazySingleton(() => GetMadarescoLessonsUseCase(repo: sl()));
  sl.registerLazySingleton<MadarescoLessonsRepo>(
      () => MadarescoLessonsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<MadarescoLessonsRemoteDataSource>(
      () => MadarescoLessonsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -MadarescoLessonDetails
  sl.registerFactory(() =>
      MadarescoLessonDetailsViewModel(madarescoLessonDetailsUseCase: sl()));
  sl.registerLazySingleton(() => GetMadarescoLessonDetailsUseCase(repo: sl()));
  sl.registerLazySingleton<MadarescoLessonDetailsRepo>(
      () => MadarescoLessonDetailsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<MadarescoLessonDetailsRemoteDataSource>(
      () => MadarescoLessonDetailsRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -CurriculaDetails
  sl.registerFactory(
      () => CurriculaDetailsViewModel(curriculaDetailsUseCase: sl()));
  sl.registerLazySingleton(() => GetCurriculaDetailsUseCase(repo: sl()));
  sl.registerLazySingleton<CurriculaDetailsRepo>(
      () => CurriculaDetailsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CurriculaDetailsRemoteDataSource>(
      () => CurriculaDetailsRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -OnlineLessons
  sl.registerFactory(() => OnlineLessonsViewModel(onlineLessonsUseCase: sl()));
  sl.registerLazySingleton(() => GetOnlineLessonsUseCase(repo: sl()));
  sl.registerLazySingleton<OnlineLessonRepo>(
      () => OnlineLessonsRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<OnlineLessonsRemoteDataSource>(
      () => OnlineLessonsRemoteDataSourceImpl(network: sl()));
  //endregion

  //region Features -AddOnlineLesson
  sl.registerFactory(() => AddOnlineLessonViewModel(
      onlineLessonUseCase: sl(),
      stagesUseCase: sl(),
      studentsUseCase: sl(),
      subjectsUseCase: sl(),
      gradesUseCase: sl(),
      sectionsUseCase: sl()));
  sl.registerLazySingleton(() => AddOnlineLessonUseCase(repo: sl()));
  sl.registerLazySingleton(() => on.GetStagesUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetStudentsUseCase(repo: sl()));
  sl.registerLazySingleton<AddOnlineLessonRepo>(
      () => AddOnlineLessonRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<AddOnlineLessonRemoteDataSource>(
      () => AddOnlineLessonRemoteDataSourceImpl(network: sl()));
  //endregion
  //region Features -Curriculas
  sl.registerFactory(
    () => CurriculaViewModel(
      stagesUseCase: sl(),
      curriculaUseCase: sl(),
      gradesUseCase: sl(),
      subjectsUseCase: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCurriculaStagesUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetCurriculaSubjectsUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetCurriculaUseCase(repo: sl()));
  sl.registerLazySingleton(() => GetCurriculaGradesUseCase(repo: sl()));
  sl.registerLazySingleton<CurriculaRepo>(
      () => CurriculaRepoImpl(remoteDataSource: sl()));
  sl.registerLazySingleton<CurriculaRemoteDataSource>(
      () => CurriculaRemoteDataSourceImpl(network: sl()));
  //endregion
}
