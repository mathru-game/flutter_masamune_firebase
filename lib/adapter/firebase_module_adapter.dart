part of masamune_firebase;

@immutable
class FirebaseModuleAdapter extends ModuleAdapter {
  const FirebaseModuleAdapter();

  @override
  ModelProvider<T> collectionProvider<T extends DynamicCollectionModel>(
          String path) =>
      firestoreCollectionProvider(path) as ModelProvider<T>;

  @override
  ModelProvider<T> documentProvider<T extends DynamicDocumentModel>(
          String path) =>
      firestoreDocumentProvider(path) as ModelProvider<T>;

  @override
  T loadDocument<T extends DynamicDocumentModel>(T document) {
    if (document is FirestoreDynamicDocumentModel) {
      document.listen();
    }
    return document;
  }

  @override
  T loadCollection<T extends DynamicCollectionModel>(T collection) {
    if (collection is FirestoreDynamicCollectionModel) {
      collection.listen();
    }
    return collection;
  }

  @override
  // ignore: avoid_field_initializers_in_const_classes
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

  @override
  String get email => FirebaseAuthCore.email;

  @override
  bool get isAnonymously => FirebaseAuthCore.isAnonymously;

  @override
  bool get isSignedIn => FirebaseAuthCore.isSignedIn;

  @override
  bool get isVerified => FirebaseAuthCore.isVerified;

  @override
  String get name => FirebaseAuthCore.name;

  @override
  String get phoneNumber => FirebaseAuthCore.phoneNumber;

  @override
  String get photoURL => FirebaseAuthCore.photoURL;

  @override
  String get userId => FirebaseAuthCore.uid;
}
