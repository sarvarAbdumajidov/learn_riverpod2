import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_riverpod2/core/services/local_db_service.dart';

final dbServiceProvider = Provider<LocalDBService>((ref) => LocalDBService());
