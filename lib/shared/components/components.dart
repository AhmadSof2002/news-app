import 'package:application/shared/cubit/cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  double radius = 10,
  Color color = Colors.blue,
  required VoidCallback function,
  required String text,
}) =>
    Container(
      height: 40,
      width: width,
      child: MaterialButton(
        elevation: 5,
        onPressed: function,
        color: color,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius)),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        Function? onChanged,
        VoidCallback? onTap,
        required String label,
        required IconData prefix,
        required String? Function(String?)? validator,
        bool isPassword = false,
        bool Cursor = true,
        bool readOnly = false,
        VoidCallback? suffixPressed,
        IconData? suffix}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          fillColor: Colors.grey,
          focusColor: Colors.grey,
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefix),
          suffixIcon: suffix != null
              ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
              : null),
      obscureText: isPassword,
      validator: validator,
      onTap: onTap,
      keyboardType: type,
      showCursor: Cursor,
      readOnly: readOnly,
    );

Widget buildTaskItem(Map model,BuildContext context) => Dismissible(
  key:Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child:   Padding(
  
        padding: const EdgeInsets.all(20.0),
  
        child: Row(
  
          children: [
  
            CircleAvatar(
  
              radius: 40.0,
  
              child: Text('${model['time']}'),
  
            ),
  
            const SizedBox(
  
              width: 20.0,
  
            ),
  
            Expanded(
  
              child: Column(
  
                mainAxisSize: MainAxisSize.min,
  
                children: [
  
                  Text('${model['title']} ',
  
                      style:
  
                          TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
  
                  Text('${model['date']}', style: TextStyle(color: Colors.grey))
  
                ],
  
              ),
  
            ),
  
            const SizedBox(
  
              width: 20.0,
  
            ),
  
            IconButton(onPressed: () {
  
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
  
            }, icon: Icon(Icons.check_box,color: Colors.green,)),
  
            IconButton(onPressed: () {
  
              AppCubit.get(context).updateData(status:'archived', id: model['id']);
  
            }, icon: Icon(Icons.archive,color: Colors.black45,)) 
  
          ],
  
        ),
  
      ),
);

Widget taskBuilder({required List<Map> tasks}) => ConditionalBuilder(
          builder: (BuildContext context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildTaskItem(tasks[index], context),
              separatorBuilder: (context, index) => Container(
                    height: 1.0,
                    width: double.infinity,
                    color: Colors.grey[200],
                  ),
              itemCount: tasks.length),
          condition: tasks.length > 0,
          fallback: (BuildContext context) => Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.menu,size: 100,color: Colors.grey,),
                SizedBox(height: 15,),
                Text('No Tasks Yet, Please Add Some Tasks',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black45),),
              ],
            ),
          ),
        );

Widget buildArticleItem(article,context) => Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [

          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image:article['urlToImage']==null ? CachedNetworkImageProvider('https://4.bp.blogspot.com/-OCutvC4wPps/XfNnRz5PvhI/AAAAAAAAEfo/qJ8P1sqLWesMdOSiEoUH85s3hs_vn97HACLcBGAsYHQ/s1600/no-image-found-360x260.png'): CachedNetworkImageProvider(
                                            
                        '${article['urlToImage']}'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    Widget myDivider(){
     return  Container(
                    height: 1.0,
                    width: double.infinity,
                    color: Colors.grey[200],
     );
    }
     Widget articleBuilder( list) => ConditionalBuilder(
          condition: list.length>0,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildArticleItem(list[index],context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: list.length),
          fallback: (context) => Center(child: CircularProgressIndicator()));
    
    
        void navigateTo(BuildContext context,widget)=>
      Navigator.push(context, MaterialPageRoute(builder: (context)=> widget));

