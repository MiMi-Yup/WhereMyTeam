import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:where_my_team/data/data_source/remote/firebase_auth_service.dart';
import 'package:where_my_team/data/data_source/remote/firestore_service.dart';
import 'package:where_my_team/domain/repositories/team_user_repository.dart';
import 'package:where_my_team/domain/repositories/user_repository.dart';
import 'package:where_my_team/models/model_team.dart';
import 'package:where_my_team/models/model_team_user.dart';
import 'package:where_my_team/models/model_user.dart';
import 'package:where_my_team/models/model.dart';

@Injectable(as: TeamUserRepository)
class TeamUserRepositoryImpl extends TeamUserRepository {
  final FirestoreService firestore;
  final FirebaseAuthService authService;
  final UserRepository userRepo;

  TeamUserRepositoryImpl(
      {required this.firestore,
      required this.authService,
      required this.userRepo});

  @override
  Future<bool> addFavourite(
      {required ModelTeam team, List<ModelUser>? users}) async {
    Iterable<DocumentReference>? usersRef = users?.map((e) => getRef(e));
    ModelTeamUser? teamUser = await getModelByRef(getRefById(team.id ?? ''));
    if (usersRef != null &&
        teamUser != null &&
        teamUser.favourite != null &&
        teamUser.favourite?.isNotEmpty == true) {
      usersRef = usersRef.where((element) =>
          teamUser.favourite!.any((current) => element.id == current.id));
      teamUser.favourite!.addAll(usersRef);
      await update(teamUser, teamUser);
    } else {
      insert(ModelTeamUser(id: team.id, favourite: usersRef?.toSet()));
    }
    return true;
  }

  @override
  Future<void> delete(IModel model) {
    if (model is! ModelTeamUser) {
      throw ArgumentError('Request ModelTransaction');
    }

    return firestore.service
        .collection(getPath(user?.uid))
        .doc(model.id)
        .delete();
  }

  @override
  FirebaseFirestore get firestoreService => firestore.service;

  @override
  Future<Set<ModelUser>?> getFavourites({required String teamId}) async {
    ModelTeamUser? teamUser = await getModelByRef(getRefById(teamId));
    if (teamUser != null) {
      Set<DocumentReference>? ref = teamUser.favourite;
      if (ref != null && ref.isNotEmpty) {
        return (await Future.wait<ModelUser?>(ref
                .map((e) => userRepo.getModelByRef(e))
                .cast<Future<ModelUser?>>()))
            .where((element) => element != null)
            .cast<ModelUser>()
            .toSet();
      }
    }
    return null;
  }

  @override
  Future<ModelTeamUser?> getModelByRef(DocumentReference<Object?> ref) async {
    try {
      DocumentSnapshot<ModelTeamUser> snapshot = await ref
          .withConverter(
              fromFirestore: ModelTeamUser.fromFirestore,
              toFirestore: (ModelTeamUser model, _) => model.toFirestore())
          .get();
      return snapshot.exists ? snapshot.data() : null;
    } on FirebaseException {
      return null;
    }
  }

  @override
  Future<List<ModelTeamUser>?> getTeams() async {
    QuerySnapshot<ModelTeamUser> snapshot = await firestore.service
        .collection(getPath(user?.uid))
        .withConverter(
            fromFirestore: ModelTeamUser.fromFirestore,
            toFirestore: (ModelTeamUser model, _) => model.toFirestore())
        .get();
    return snapshot.size > 0
        ? snapshot.docs.map((e) => e.data()).toList()
        : null;
  }

  @override
  String getPath(String? uid) => '/user/$uid/team';

  @override
  Future<List<IModel>?> read() {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> removeFavourite(
      {required String teamId, required ModelUser user}) {
    // TODO: implement removeFavourite
    throw UnimplementedError();
  }

  @override
  User? get user => authService.service.currentUser;

  @override
  Stream<QuerySnapshot<ModelTeamUser>> getStream() {
    return firestoreService
        .collection(getPath(user?.uid))
        .withConverter(
            fromFirestore: ModelTeamUser.fromFirestore,
            toFirestore: (ModelTeamUser model, _) => model.toFirestore())
        .snapshots(includeMetadataChanges: true);
  }
}
