import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/services/auth/auth_provider.dart';
import 'package:notes/services/auth/auth_user.dart';
import 'package:notes/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class firebase_authprovider implements provider{
  @override
  Future<void> SendEmailVerification() async{
    final user=FirebaseAuth.instance.currentUser;
    if (user!= null){
      await user.sendEmailVerification();

    }
    else{
      throw user_not_loged_in_authexception();
    }
  }

  @override
  Future<auth_user> create_user({required String password, required String email}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = current_user;
      if (user != null){
        return user;
      }
      else{
        throw user_not_loged_in_authexception();
      }
    }on FirebaseAuthException catch(e) {

      if(e.code=="email-already-in-use"){
        throw email_already_usedauthexception();

      }
      else if(e.code=="invalid-email"){
        throw invalid_email_authexception();

      }
      else{
        throw generic_authexception();

      }


    }catch (e){
     throw generic_authexception();
  }
  }

  @override
  // TODO: implement current_user
  auth_user? get current_user {
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null){
      return auth_user.fromFirebase(user);
    }
    else{
      return null;
    }

  }

  @override
  Future<void> log_out() async{
    final user=FirebaseAuth.instance.currentUser;
    if(user!= null){
      await FirebaseAuth.instance.signOut();
    }
    else{
      throw user_not_loged_in_authexception();
    }
  }

  @override
  Future<auth_user> login({required String password, required String email}) async{
    try{
      FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final user=current_user;

      if (user!=null){
        return user;
      }
      else{
        throw user_not_loged_in_authexception();
      }



    } on FirebaseAuthException catch (e){
      if(e.code=="INVALID_LOGIN_CREDENTIALS"){
        throw invalid_email_authexception();
      }
      else{
        throw invalid_email_authexception();

      }


    } catch (e){
      throw generic_authexception();
    }

  }
  
  
}