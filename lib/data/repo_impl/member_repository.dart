import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/firestore_service.dart';
import 'package:where_my_team/domain/repositories/member_repository.dart';
import 'package:where_my_team/domain/repositories/role_repository.dart';
import 'package:where_my_team/domain/repositories/team_repository.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';
import 'package:where_my_team/models/model.dart';
import 'package:where_my_team/models/model_member.dart';
import 'package:where_my_team/models/model_role.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_user.dart';

@Injectable(as: MemberRepository)
class MemberRepositoryImpl implements MemberRepository {
  final FirestoreService firestore;
  final UserRepository userRepo;
  final RoleRepository roleRepo;
  final TeamRepository teamRepo;
  MemberRepositoryImpl(
      {required this.firestore,
      required this.userRepo,
      required this.roleRepo,
      required this.teamRepo});

  @override
  Future<void> delete(IModel model) {
    if (model is! ModelMember) {
      throw ArgumentError('Request ModelTransaction');
    }

    return firestore.service
        .collection(getPath(model.team?.id))
        .doc(model.id)
        .delete();
  }

  @override
  Future<bool> deleteMember({required ModelMember member}) async {
    try {
      await delete(member);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  CollectionReference<Map<String, dynamic>> getCollectionRef() {
    return firestore.service.collection(getPath(user?.uid));
  }

  @override
  Future<ModelMember?> getMember(
      {required ModelTeam team, required ModelUser user}) async {
    DocumentSnapshot<ModelMember> snapshot = await firestore.service
        .collection(getPath(team.id))
        .doc(user.id)
        .withConverter(
            fromFirestore: ModelMember.fromFirestore,
            toFirestore: (ModelMember model, _) => model.toFirestore())
        .get();
    return snapshot.exists ? snapshot.data() : null;
  }

  @override
  Future<ModelMember?> getModelByRef(DocumentReference<Object?> ref) async {
    try {
      DocumentSnapshot<ModelMember> snapshot = await ref
          .withConverter(
              fromFirestore: ModelMember.fromFirestore,
              toFirestore: (ModelMember model, _) => model.toFirestore())
          .get();
      return snapshot.data();
    } on FirebaseException {
      return null;
    }
  }

  @override
  String getPath(String? uid) => '/team/$uid/member';

  @override
  DocumentReference<Map<String, dynamic>> getRef(IModel model) {
    if (model is! ModelMember) {
      throw ArgumentError('Request ModelTransaction');
    }

    return firestore.service.collection(getPath(model.team?.id)).doc(model.id);
  }

  @override
  DocumentReference<Map<String, dynamic>> getRefById(String id) {
    // TODO: implement getRefById
    throw UnimplementedError();
  }

  @override
  Future<void> insert(IModel model) {
    if (model is! ModelMember) {
      throw ArgumentError('Request ModelTransaction');
    }

    return firestore.service
        .collection(getPath(model.team?.id))
        .doc(model.id)
        .set(model.toFirestore(), SetOptions(merge: true));
  }

  @override
  Future<bool> postMember(
      {required ModelTeam team,
      required ModelUser user,
      required ModelRole role,
      String? nickname}) async {
    ModelUser? addBy = await userRepo.getCurrentUser();
    if (addBy != null) {
      ModelMember? member = await getMember(team: team, user: addBy);
      if (member != null) {
        ModelRole? roleMemberAdd =
            (await roleRepo.getModelByRef(member.role!)) as ModelRole?;
        if (roleMemberAdd != null &&
            await roleRepo.allowExecute(source: roleMemberAdd, target: role)) {
          await insert(ModelMember(
              id: user.id,
              role: roleRepo.getRef(role),
              joinTime: Timestamp.now(),
              team: teamRepo.getRef(team)));
          return true;
        }
      }
    }
    return false;
  }

  @override
  Future<bool> putNickname(
      {required ModelMember member, required String nickname}) async {
    await update(member, member.copyWith(nickname: nickname));
    return true;
  }

  @override
  Future<bool> putRole(
      {required ModelMember member, required ModelRole role}) async {
    await update(member, member.copyWith(role: roleRepo.getRef(role)));
    return true;
  }

  @override
  Future<List<IModel>?> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> update(IModel was, IModel update) {
    if (was is! ModelMember && update is! ModelMember) {
      throw ArgumentError('Request ModelTransaction');
    }

    return firestore.service
        .collection(getPath((was as ModelMember).team?.id))
        .doc(was.id)
        .update(update.updateFirestore());
  }

  @override
  User? get user => null;
}
