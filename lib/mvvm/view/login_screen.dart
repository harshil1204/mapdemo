import 'package:flutter/material.dart';
import 'package:mapdemo/mvvm/utils/utils.dart';
import 'package:mapdemo/mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

import '../res/components/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final ValueNotifier _obscurePass=ValueNotifier(true);
  final TextEditingController _emailController= TextEditingController();
  final TextEditingController _passwordController= TextEditingController();

  FocusNode emailFocusNode=FocusNode();
  FocusNode passFocusNode=FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final authViewModel= Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login page"),
      ),
      body:SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             TextFormField(
              controller: _emailController,
               keyboardType: TextInputType.emailAddress,
               focusNode: emailFocusNode,
               decoration: const InputDecoration(
                 //hintText: 'Email',
                 labelText: 'Emial',
                 prefixIcon: Icon(Icons.alternate_email)
               ),
               onFieldSubmitted: (val){
                 Utils.fieldFocusChange(context,emailFocusNode,passFocusNode);
               },
             ),
             ValueListenableBuilder(
               valueListenable: _obscurePass,
               builder: (context,value,child) {
                 return TextFormField(
                  controller: _passwordController,
                   obscureText: _obscurePass.value,
                   obscuringCharacter: "*",
                   focusNode: passFocusNode,
                   decoration:  InputDecoration(
                     //hintText: 'Email',
                     labelText: 'Password',
                     prefixIcon: const Icon(Icons.password_outlined),
                     suffixIcon: InkWell(
                         onTap: (){
                           _obscurePass.value =!_obscurePass.value;
                         },
                         child:  Icon(_obscurePass.value ? Icons.visibility_off:Icons.visibility)),
                   ),
                 );
               }
             ),

              const SizedBox(height: 20),
             RoundButton(
               title: 'login',
               onPress: (){
                 if(_emailController.text.isEmpty){
                   Utils.flushBarErrorMessage('please enter mail', context);
                 } else if(_passwordController.text.isEmpty){
                   Utils.flushBarErrorMessage('please enter pass', context);
                 } else if(_passwordController.text.length < 6){
                   Utils.flushBarErrorMessage('please enter 6 charcter pass', context);
                 }
                  else{
                    Map data={
                      'email':_emailController.text.toString(),
                      'password':_passwordController.text.toString()
                    };
                   authViewModel.loginApi(data,context);
                 }
               },
             )
           ],
        ),
      )
    );
  }
}
