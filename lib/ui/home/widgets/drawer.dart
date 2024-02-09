import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../data/local/storage_repo/storage_repo.dart';
import '../../../providers/auth_provider.dart';
import '../../../utils/colors.dart';

class DrawerWid extends StatelessWidget {
  const DrawerWid({super.key});

  @override
  Widget build(BuildContext context) {
    String username = StorageRepository.getString('username');
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 50,),
          TextButton(onPressed: (){
            context.read<AuthProviderr>().logOutUser(context);
          }, child:const Row(children: [Text('LogOut'),SizedBox(width: 7,),Icon(Icons.logout)],)),
          const SizedBox(height: 48,),
        ],
      ),
    );
  }
}
