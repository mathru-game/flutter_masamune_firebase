part of masamune_firebase;

@immutable
class FirebaseModuleAdapter extends ModuleAdapter<
    FirestoreDynamicDocumentModel,
    FirestoreDynamicCollectionModel,
    ModelProvider<FirestoreDynamicDocumentModel>,
    ModelProvider<FirestoreDynamicCollectionModel>> {
  const FirebaseModuleAdapter();

  @override
  T collectionProvider<
              T extends ModelProvider<FirestoreDynamicCollectionModel>>(
          String path) =>
      firestoreCollectionProvider(path) as T;

  @override
  T documentProvider<T extends ModelProvider<FirestoreDynamicDocumentModel>>(
          String path) =>
      firestoreDocumentProvider(path) as T;

  @override
  FirestoreDynamicDocumentModel loadDocument(
      FirestoreDynamicDocumentModel document) {
    return document..listen();
  }

  @override
  FirestoreDynamicCollectionModel loadCollection(
      FirestoreDynamicCollectionModel collection) {
    return collection..listen();
  }

  @override
  final bool enabledAuth = true;

  @override
  Future<void> registerInEmailAndPassword(
      {required String email, required String password}) async {
    await EmailAndPasswordAuth.register(email: email, password: password);
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await EmailAndPasswordAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> signInAnonymously() async {
    await AnonymouslyAuth.signIn();
  }

  @override
  Future<void> signInEmailAndPassword(
      {required String email, required String password}) async {
    await EmailAndPasswordAuth.signIn(email: email, password: password);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuthCore.signOut();
  }

  @override
  Future<void> tryRestoreAuth() async {
    await FirebaseAuthCore.tryRestoreAuth();
  }
}
