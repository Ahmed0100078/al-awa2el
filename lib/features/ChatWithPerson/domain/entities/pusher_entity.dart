import 'package:equatable/equatable.dart';

class PusherEntity extends Equatable {
  final String key, appId, cluster, host, port;
  final bool encrypted;

  const PusherEntity({
    required this.key,
    required this.appId,
    required this.cluster,
    required this.encrypted,
    required this.host,
    required this.port,
  });

  @override
  List<Object> get props => [key, appId, cluster, encrypted, host, port];
}
