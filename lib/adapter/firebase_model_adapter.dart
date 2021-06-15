part of masamune_firebase;

@immutable
class FirebaseModelAdapter extends ModelAdapter<FirestoreDynamicDocumentModel,
    FirestoreDynamicCollectionModel> {
  const FirebaseModelAdapter();

  @override
  ModelProvider<FirestoreDynamicCollectionModel> collectionProvider(
          String path) =>
      firestoreCollectionProvider(path);

  @override
  ModelProvider<FirestoreDynamicDocumentModel> documentProvider(String path) =>
      firestoreDocumentProvider(path);

  @override
  FirestoreDynamicDocumentModel loadDocument(
      FirestoreDynamicDocumentModel document) {
    document.listen();
    return document;
  }

  @override
  FirestoreDynamicCollectionModel loadCollection(
      FirestoreDynamicCollectionModel collection) {
    collection.listen();
    return collection;
  }

  @override
  FirestoreDynamicDocumentModel createDocument(
      FirestoreDynamicCollectionModel collection,
      [String? id]) {
    return collection.create(id);
  }

  @override
  Future<void> deleteDocument(FirestoreDynamicDocumentModel document) async {
    await document.delete();
  }

  @override
  Future<void> saveDocument(FirestoreDynamicDocumentModel document) async {
    await document.save();
  }

  @override
  Future<String> uploadMedia(String path) {
    return FirebaseStorageCore.upload(path);
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

  @override
  FirebaseModelAdapter? fromMap(DynamicMap map) {
    if (map.get("type", "") != type) {
      return null;
    }
    return const FirebaseModelAdapter();
  }

  @override
  DynamicMap toMap() {
    return <String, dynamic>{
      "type": type,
    };
  }
}
