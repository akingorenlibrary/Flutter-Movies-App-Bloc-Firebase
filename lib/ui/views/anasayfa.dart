import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmler_app/data/entity/filmler.dart';
import 'package:filmler_app/ui/cubit/anasayfa_cubit.dart';
import 'package:filmler_app/ui/views/detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  @override
  void initState() {
    // TODO: implement initState
    context.read<AnasayfaCubit>().filmleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fimler"),
      ),
      body: BlocBuilder<AnasayfaCubit,List<Filmler>>(
        builder: (context,fimlerListesi){
          if(fimlerListesi.isNotEmpty){
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1/1.8
                ),
              itemCount: fimlerListesi.length,
              itemBuilder: (context, indeks){
                var film=fimlerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetaySayfa(film: film)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network("http://kasimadalan.pe.hu/filmler_yeni/resimler/${film.resim}"),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                          Text("${film.fiyat} tl",style: TextStyle(fontSize: 24),),
                          ElevatedButton(onPressed: (){
                            print("${film.ad} sepete eklendi.");
                          }, child: const Text("Sepet",style: TextStyle(color: Colors.black),))
                        ],)
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return const Center();
          }
        }),
    );
  }
}