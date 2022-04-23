import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String? title;
  final String? image;
  final GestureTapCallback? onTap;
  const CustomListTile(this.title, this.onTap , this.image ,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 10),
        child: Row(children: [
          if (image !=null) Image.asset(image! , scale: 2,),
          if (image !=null) const SizedBox(width: 10,),
          CustomText(title , fontWeight: FontWeight.bold,),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios,size: 20,)
        ],),
      ),
    );
  }
}
