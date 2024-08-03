import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:midjo/src/model/location_model.dart';

class AuthFirebase {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final user = _auth.currentUser;
  String? userDocId;
  // Variable statique pour stocker l'ID du document utilisateur
  static String? userDoc;

  static bool FunctionState = false;

  static Future<void> SignIn(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      FunctionState = true;
      print('create good');
    } on FirebaseAuthException catch (e) {
      print('message ${e}');

      FunctionState = true;
    }
  }

  static Future <void> testConnectSuccessAfterCreateAccount  ({
     required String nom,
    required String prenom,
    required String password,
    required String email,
    required String phoneNumber,
  }) async {
       try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      FunctionState = true;
        if( FunctionState == true ){

            try {
      final user = _auth.currentUser;


       if (user == null) {
        print('Aucun utilisateur connecté');
        return;
      }

      print('debut de creation du compte');

       final userId = <String, dynamic>{
        'id': '123654789654123',
        'Nom': nom,
        'Prenom': prenom,
        'email': email,
        'phoneNumber': phoneNumber,
      };

       print('Informations de l\'utilisateur: $userId');


      try {
        final DocumentReference doc =
            await _firestore.collection("users").add(userId);
        print("Compte utilisateur créé avec l'ID: ${doc.id}");
      } catch (firestoreError) {
        print(
            'Erreur lors de l\'ajout des données dans Firestore: $firestoreError');
        // You can also throw the error to be handled by the outer catch block if needed
        throw firestoreError;
      }

        print('Création terminée, merci beaucoup');

 
    } catch (e) {
      print('Erreur lors de la création de l\'utilisateur: $e');
    }



        }
    } on FirebaseAuthException catch (e) {
      print('message ${e}');

      FunctionState = false;
    }


  }

  static Future<void> Login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      FunctionState = true;
    } on FirebaseAuthException catch (e) {
      print('message ${e}');
    }
  }

  static Future<void> createAccount({
    required String nom,
    required String prenom,
    required String email,
    required String phoneNumber,
  }) async {
    try {
      final user = _auth.currentUser;


       if (user == null) {
        print('Aucun utilisateur connecté');
        return;
      }

      print('debut de creation du compte');

       final userId = <String, dynamic>{
        'id': '123654789654123',
        'Nom': nom,
        'Prenom': prenom,
        'email': email,
        'phoneNumber': phoneNumber,
      };

       print('Informations de l\'utilisateur: $userId');


      try {
        final DocumentReference doc =
            await _firestore.collection("users").add(userId);
        print("Compte utilisateur créé avec l'ID: ${doc.id}");
      } catch (firestoreError) {
        print(
            'Erreur lors de l\'ajout des données dans Firestore: $firestoreError');
        // You can also throw the error to be handled by the outer catch block if needed
        throw firestoreError;
      }

        print('Création terminée, merci beaucoup');

 
    } catch (e) {
      print('Erreur lors de la création de l\'utilisateur: $e');
    }
  }

  static Future<void> RegisterAccount({
    required String nom,
    required String prenom,
    required String phoneNumber,
    required String email,
  }) async {
    try {
      final user = _auth.currentUser;

      if (user != null) {
        final NewUser = <String, dynamic>{
          'id': user.uid,
          'nom': nom,
          'prenom': prenom,
          'phoneNumber': phoneNumber,
          'email': email
        };
      
        await _firestore.collection("users").add(NewUser).then(
            (DocumentReference doc) =>
                print("user Account created : ${doc.id}"));
      }
    } catch (e) {
      print('${e} create probleme');
    }
  }

  static Future<void> Singout() async {
    await _auth.signOut();
  }

  static Future<Map<String, dynamic>?> getUserInfo() async {
    if (userDoc! == null) {
      print(
          "L'ID du document utilisateur est nul. Assurez-vous de créer un compte ou de définir l'ID du document.");
      return null;
    }

    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection("users").doc(userDoc!).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        print("Données utilisateur: $userData");
        return userData;
      } else {
        print("Aucun document utilisateur trouvé pour l'ID: $userDoc!");
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des informations utilisateur: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUserByUid() async {
    try {
      final user = _auth!.currentUser;
      print(user!.email);
      if (user != null) {
        final String uid = user.uid;
        print("User UID: $uid");

        // Requête Firestore pour récupérer les données de l'utilisateur
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("users")
            .where("email", isEqualTo: "${user!.email}")
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          print("User found in Firestore");

          // Récupère le premier document trouvé
          final DocumentSnapshot docSnapshot = querySnapshot.docs.first;

          // Vérification de l'existence des données et conversion en Map
          final Map<String, dynamic>? userData =
              docSnapshot.data() as Map<String, dynamic>?;

          if (userData != null) {
            userData['docId'] = docSnapshot.id;
            print("Document ID: ${userData['docId']}");
            print("User Data: $userData");
            return userData;
          } else {
            print("User data is null for UID: $uid");
          }
        } else {
          print("No user document found for UID: $uid");
        }
      } else {
        print("No user is currently logged in.");
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getUserByUidForDocId() async {
    print("${user!.uid}");
    print('debut de test');
    if (user != null) {
      ('cets pas null');
      final QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .where("id", isEqualTo: user!.uid)
          .get();
      print('avant la recherche');
      print(querySnapshot.docs);
      if (querySnapshot.docs.isNotEmpty) {
        print("nous l'avons trouve");
        final DocumentSnapshot docSnapshot = querySnapshot.docs.first;

        // Ajout de l'ID du document aux données utilisateur
        final userData = docSnapshot.data() as Map<String, dynamic>;
        userData['docId'] = docSnapshot.id;

        return userData;
      }
    }
    return null;
  }

  static Future<List<LocationPLace>> getStations() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection("station").get();

      print('debug firebase');

      print(querySnapshot.docs);

      print("debug mode beg");

      return querySnapshot.docs
          .map((doc) => LocationPLace.fromFirestore(doc))
          .toList();
    } catch (e) {
      print("Error fetching stations: $e");
      return [];
    }
  }

  static Future<void> updateUserDataNom({required String nom}) async {
    try {
      final userData = await getUserByUid();

      if (userData != null) {
        final userId = userData['docId'] as String?;

        if (userId != null) {
          print('Starting update for user ID: $userId');

          final userDocRef = _firestore.collection("users").doc(userId);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            print('Updating user information');

            await userDocRef.update({
              'Nom': nom,
            });

            print("User information updated successfully");
          } else {
            print("Error: User document does not exist.");
          }
        } else {
          print("Error: User document ID not found.");
        }
      } else {
        print("Error: User not found.");
      }
    } catch (e) {
      print("Error updating user information: $e");
    }
  }

  static Future<void> updateUserDataNumero({required String numero}) async {
    try {
      final userData = await getUserByUid();

      if (userData != null) {
        final userId = userData['docId'] as String?;

        if (userId != null) {
          print('Starting update for user ID: $userId');

          final userDocRef = _firestore.collection("users").doc(userId);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            print('Updating user information');

            await userDocRef.update({
              'phoneNumber': numero,
            });

            print("User information updated successfully");
          } else {
            print("Error: User document does not exist.");
          }
        } else {
          print("Error: User document ID not found.");
        }
      } else {
        print("Error: User not found.");
      }
    } catch (e) {
      print("Error updating user information: $e");
    }
  }

  static Future<void> updateUserDataEmail({required String email}) async {
    try {
      final userData = await getUserByUid();

      if (userData != null) {
        final userId = userData['docId'] as String?;

        if (userId != null) {
          print('Starting update for user ID: $userId');


          final userDocRef = _firestore.collection("users").doc(userId);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            print('Updating user information');

            await userDocRef.update({
              'email': email,
            });

            print("User information updated successfully");
          } else {
            print("Error: User document does not exist.");
          }
        } else {
          print("Error: User document ID not found.");
        }
      } else {
        print("Error: User not found.");
      }
    } catch (e) {
      print("Error updating user information: $e");
    }
  }

  static Future<Map<String, dynamic>?> getUserInfoV() async {
    if (userDoc == null) {
      print(
          "L'ID du document utilisateur est nul. Assurez-vous de créer un compte ou de définir l'ID du document.");
      return null;
    }

    try {
      // Récupère le document utilisateur depuis Firestore en utilisant l'ID du document
      DocumentSnapshot docSnapshot =
          await _firestore.collection("users").doc(userDoc).get();
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        print("Données utilisateur: $userData");
        return userData;
      } else {
        print("Aucun document utilisateur trouvé pour l'ID: $userDoc");
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des informations utilisateur: $e');
      return null;
    }
  }
}























/**
 * import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthFirebase {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static bool functionState = false;

  static Future<void> CreateAccount(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('User ${userCredential.user!.email}');
      functionState = true;
    } on FirebaseAuthException catch (e) {
      // ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //    SnackBar(content: Text('${e.message}')));
      functionState = false;
    }
  }

  static Future<void> LoginAccount(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      functionState = true;
      //   ScaffoldMessenger.of(context as BuildContext)
      //    .showSnackBar(SnackBar(content: Text('compte creer avec succes')));
    } on FirebaseAuthException catch (e) {
      functionState = false;
      //ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      //   SnackBar(content: Text('${e.message}')));
    }
  }

  Future<void> SignOut() async {
    await _auth.signOut();
  }

  static Future<String> registerUser({
    required String phoneUser,
    required String email,
    required String location,
    required String NomComplet,
    required String handicap,
  }) async {
    try {
      // Récupérer l'utilisateur actuellement connecté
      final user = _auth.currentUser;

      print(user);

      if (user != null) {
        // Create a new user with a first and last name
        final userId = <String, dynamic>{
          'id': user.uid,
          'Email': email,
          'NomComplet': NomComplet,
          'handicap': handicap,
          'numero': phoneUser,
          'location': location
        };

        print(userId);

        // Add a new document with a generated ID
        await _firestore.collection("user").add(userId).then(
            (DocumentReference doc) =>
                print('DocumentSnapshot added with ID: ${doc.id}'));
        print(user);
        // Enregistrer les données de l'utilisateur dans Firestore

        print("Utilisateur enregistré avec succès");
        return "Success";
      } else {
        return "Error: No user is currently logged in.";
      }
    } catch (e) {
      print("Erreur lors de l'enregistrement de l'utilisateur: $e");
      return "Error: $e";
    }
  }

  static Future<Map<String, dynamic>?> getUserByUid() async {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        final QuerySnapshot querySnapshot = await _firestore
            .collection("user")
            .where("id", isEqualTo: user.uid)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          print("nous l'avons trouve");
          final DocumentSnapshot docSnapshot = querySnapshot.docs.first;

          // Ajout de l'ID du document aux données utilisateur
          final userData = docSnapshot.data() as Map<String, dynamic>  ;

          userData['docId'] = docSnapshot.id;

          return userData;
        }
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<void> updateUserData({
    required String docId,
    required String phoneUser,
    required String NomUser,
    required String age,
    required String email,
    required String sexe,
    required String niveauSColaire,
    required String SituationMatrimoniale,
    required String emploi,
  }) async {
    try {
      print('Début de la modification');

      // Récupérer la référence du document de l'utilisateur
      final userDocRef = _firestore.collection("users").doc(docId);

      // Vérifier si le document de l'utilisateur existe
      final userDoc = await userDocRef.get();
      if (userDoc.exists) {
        print('Début de la mise à jour des informations');

        // Mettre à jour les informations de l'utilisateur
        await userDocRef.update({
          'phoneUser': phoneUser,
          'NomUser': NomUser,
          'age': age,
          'email': email,
          'sexe': sexe,
          'niveauSColaire': niveauSColaire,
          'SituationMatrimoniale': SituationMatrimoniale,
          'emploi': emploi,
        });

        print("Informations de l'utilisateur mises à jour avec succès");
      } else {
        print("Erreur: Le document de l'utilisateur n'existe pas.");
      }
    } catch (e) {
      print(
          "Erreur lors de la mise à jour des informations de l'utilisateur: $e");
    }
  }
}

 */