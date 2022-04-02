import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localdatabase/adspagebanner.dart';

import 'adspageints.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _updateController = TextEditingController();


  Box? contactBox;
  @override
  void initState() {
    contactBox = Hive.box("contact-list");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ElevatedButton(onPressed: (){Navigator.push(context, CupertinoPageRoute(builder: (context)=>AdsPageBanner()));}, child: Text("Ads Page Banner")),
              ElevatedButton(onPressed: (){Navigator.push(context, CupertinoPageRoute(builder: (context)=>AdsPageInts()));}, child: Text("Ads Page Ints")),
              TextField(
                controller: _controller,
              ),
              SizedBox(width: double.maxFinite,child: ElevatedButton(onPressed: ()async{
                final userInput = _controller.text;
                await contactBox?.add(userInput);
                _controller.clear();
                print("added");
              }, child: Text("Add user number"))),
              Expanded(child: ValueListenableBuilder(
                  valueListenable: Hive.box("contact-list").listenable(),
                builder: (context,box,widget){
                    return ListView.builder(
                        itemCount: contactBox?.keys.toList().length,
                        itemBuilder: (_,index){
                          return Card(
                            child: ListTile(
                              dense: true,
                              leading: Text(contactBox!.getAt(index).toString()),
                              trailing: Container(
                                width: 100,
                                child: Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      showDialog(context: context, builder: (context){
                                        return AlertDialog(
                                          title: Text("Update"),
                                          content: Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                TextField(
                                                  controller: _updateController,
                                                ),
                                                SizedBox(width: double.maxFinite,child: ElevatedButton(onPressed: ()async{
                                                  contactBox?.putAt(index, _updateController.text);
                                                  Navigator.pop(context);
                                                }, child: Text("Update"))),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    }, icon: Icon(Icons.edit_outlined,color: Colors.amber,)),
                                    IconButton(onPressed: (){
                                      showDialog(context: (context), builder: (context){
                                        return AlertDialog(
                                          title: Text("Are you sure, you want to delete ?"),
                                          content: Container(
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    ElevatedButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    }, child: Text("No")),
                                                    ElevatedButton(onPressed: ()async{
                                                      await contactBox?.deleteAt(index);
                                                      Navigator.pop(context);
                                                    }, child: Text("Yes")),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                      print("Done");
                                    }, icon: Icon(Icons.close,color: Colors.red,)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
              },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

