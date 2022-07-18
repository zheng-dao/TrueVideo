import 'package:truvideo_enterprise/model/camera/video_session.dart';
import 'package:truvideo_enterprise/model/camera/video_session_file.dart';

abstract class VideoSessionService {
  Future<VideoSessionModel> create({String tag = "", int? orderID});

  Future<void> addVideo(String uid, VideoSessionFileModel file, {int? orderID});

  Future<void> addPicture(String uid, VideoSessionFileModel file, {int? orderID});

  Future<VideoSessionModel?> getByTag(String tag);

  Stream<VideoSessionModel?> streamByTag(String tag);

  Future<VideoSessionModel?> getByUID(String uid);

  Stream<VideoSessionModel?> streamByUID(String uid);

  Future<List<VideoSessionModel>> getAll();

  Stream<List<VideoSessionModel>> streamAll();

  Future<void> deleteByTag(String tag, {bool deleteFiles = true});

  Future<void> deleteByUID(String uid, {bool deleteFiles = true});
}
