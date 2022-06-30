
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:assignment_flutter/constants/app_constants.dart';
import 'package:assignment_flutter/providers/encryption_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Encryption extends StatelessWidget {
  static const route = '/encryption';
  const Encryption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EncryptionProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.padSixteen),
        child: Column(
            children:  [
               TextField(
                maxLines: 5,
                decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Message',
                    errorText: provider.tfMessage.error
                ),
                onChanged: (String value){
                  provider.validateMessageField(value);
                },
              ),
              const SizedBox(height: AppConstants.padSixteen,),
               TextField(
                 maxLength: 32,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter 32 bit Secret Key',
                  errorText: provider.tfSecretKey.error
                ),
                onChanged: (String value){
                  provider.validateKeyField(value);
                },
              ),
              const SizedBox(height: AppConstants.padSixteen,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  ElevatedButton(onPressed: (){
                    provider.encryptData();
                  }, child: const Text('Encrypt')),
                  ElevatedButton(onPressed: (){
                    provider.decryptData();
                  }, child: const Text('Decrypt'))
                ],
              ),
              const SizedBox(height: AppConstants.padSixteen,),
              const Text('Encrpted/Decrypted String', style: TextStyle(fontSize: 26),),
              const SizedBox(height: AppConstants.padSixteen,),
              Consumer<EncryptionProvider>(
                  builder:  (context, provider, child){
                    return Text(provider.encryptedText == null ? ""
                        : provider.encryptedText is encrypt.Encrypted ?
                    provider.encryptedText.base64 : provider.encryptedText, style: const TextStyle(
                      fontSize: 16
                    ),);
                  })
            ],
          ),
      ),
    );

  }
}



