import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:wmteam/data/data_source/remote/firestore_service.dart';
import 'package:wmteam/domain/repositories/role_repository.dart';
import 'package:wmteam/domain/repositories/team_repository.dart';
import 'package:wmteam/models/model_team.dart';
import 'package:wmteam/models/model_member.dart';
import 'package:wmteam/models/model.dart';

@Injectable(as: TeamRepository)
class TeamRepositoryImpl extends TeamRepository {
  final FirestoreService firestore;
  final RoleRepository roleRepo;

  TeamRepositoryImpl({required this.firestore, required this.roleRepo});

  @override
  Future<void> delete(IModel model) {
    if (model is! ModelTeam) {
      throw ArgumentError('Request ModelTransaction');
    }

    return firestore.service.collection(getPath(null)).doc(model.id).delete();
  }

  @override
  Future<bool> deleteTeam({required ModelTeam team}) async {
    try {
      await delete(team);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  Future<List<ModelMember>?> getMembers({required String teamId}) async {
    ModelTeam? team = await getModelByRef(getRefById(teamId));
    if (team != null) {
      QuerySnapshot<ModelMember> snapshot = await firestore.service
          .collection('${getPath(null)}/${team.id}/member')
          .withConverter(
              fromFirestore: ModelMember.fromFirestore,
              toFirestore: (ModelMember model, _) => model.toFirestore())
          .get();
      return snapshot.size > 0
          ? snapshot.docs.map((e) => e.data()).toList()
          : null;
    }
    return null;
  }

  @override
  Future<ModelTeam?> getModelByRef(DocumentReference<Object?> ref) async {
    try {
      DocumentSnapshot<ModelTeam> snapshot = await ref
          .withConverter(
              fromFirestore: ModelTeam.fromFirestore,
              toFirestore: (ModelTeam model, _) => model.toFirestore())
          .get();
      return snapshot.exists ? snapshot.data() : null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  String getPath(String? uid) => '/team';

  @override
  Future<ModelTeam?> getTeam({required String teamId}) {
    return getModelByRef(getRefById(teamId));
  }

  @override
  Future<bool> postTeam({required ModelTeam team}) async {
    try {
      await insert(team);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> putAvatar(
      {required ModelTeam team, required String path}) async {
    try {
      await update(team, team.copyWith(avatar: path));
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> putName({required ModelTeam team, required String name}) async {
    try {
      await update(team, team.copyWith(name: name));
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<IModel>?> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> insert(IModel model) async {
    if (model is! ModelTeam) {
      throw ArgumentError('Request ModelTransaction');
    }

    DocumentReference ref = await firestoreService
        .collection(getPath(null))
        .add(model.toFirestore());
    model.id = ref.id;
  }

  @override
  // TODO: implement user
  User? get user => null;

  @override
  Future<int> getNumberOfMembers({required String teamId}) async {
    ModelTeam? team = await getModelByRef(getRefById(teamId));
    if (team != null) {
      final count = await firestoreService
          .collection('${getPath(null)}/${team.id}/member')
          .count()
          .get();
      return count.count;
    }
    return 0;
  }

  @override
  Stream<QuerySnapshot<ModelMember>> getStream({required ModelTeam team}) {
    return firestoreService
        .collection('${getPath(null)}/${team.id}/member')
        .withConverter(
            fromFirestore: ModelMember.fromFirestore,
            toFirestore: (ModelMember model, _) => model.toFirestore())
        .snapshots(includeMetadataChanges: true);
  }

  @override
  Future<ModelMember?> adminOfTeam({required ModelTeam team}) async {
    final members = await firestore.service
        .collection('${getPath(null)}/${team.id}/member')
        .where('role', isEqualTo: roleRepo.getRefById('NtU957r3xX70qa260YeL'))
        .withConverter(
            fromFirestore: ModelMember.fromFirestore,
            toFirestore: (ModelMember model, _) => model.toFirestore())
        .get();
    if (members.size == 1) {
      return members.docs.first.data();
    }
    return null;
  }
}
