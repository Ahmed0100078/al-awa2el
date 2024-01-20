import 'package:dartz/dartz.dart';
import 'package:madaresco/core/error/exception.dart';
import 'package:madaresco/core/error/failures.dart';
import 'package:madaresco/features/ChatWithPerson/data/data_sources/chat_remote_data_source.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/chat_entity.dart';
import 'package:madaresco/features/ChatWithPerson/domain/entities/pusher_entity.dart';
import 'package:madaresco/features/ChatWithPerson/domain/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  ChatRemoteDataSource _remoteDataSource;

  ChatRepoImpl({
    required ChatRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, ChatEntity>> getConversationByUser(String url,
      [int page = 1]) async {
    try {
      return Right(await _remoteDataSource.getChatByUser(url, page));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage(
      int roomId, String message, String socketID) async {
    try {
      return Right(
          await _remoteDataSource.sendMessage(roomId, message, socketID));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, PusherEntity>> getPusherData() async {
    try {
      return Right(await _remoteDataSource.getPusher());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
