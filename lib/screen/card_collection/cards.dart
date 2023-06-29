

import 'package:flutter/material.dart';
import 'package:the_test_naruto_arena/elements/appbar.dart';

class CardCollection extends StatelessWidget {
  const CardCollection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarPages.getAppBar('Card Collection'),
      body: Center(child: Container(
        decoration: BoxDecoration(
                color: Color.fromARGB(255, 133, 131, 131),
                border: Border.all(
                  width: 1.0,
                  color: Colors.black26,
                ),
              ),
              width: 300,
              alignment: Alignment.topCenter,
        child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 4,
                children: List.generate(100, (index) {
                  return Card(
                                child: Stack(
                                  children: [
                                    Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 3,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(Icons.abc)
                                  ),
                                    Column(
                                      children: [
                                        Text('Name'),
                                      ],
                                    )
                                  ],
                                ),
                              );
                }),),
      )),
    );
  }
}