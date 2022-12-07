import 'package:envios_app/Components/CardEnvioInfo.dart';
import 'package:envios_app/Components/SearchBar.dart';
import 'package:envios_app/Screens/Envios/datos.dart';
import 'package:envios_app/Screens/Envios/funciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

//construccion de la pantalla donde se mostrara todos los envios asignados

class Envios extends StatefulWidget {
  const Envios({Key? key}) : super(key: key);

  @override
  State<Envios> createState() => _EnviosState();
}

class _EnviosState extends State<Envios> {
  List<dynamic> listaValores = [];
  List<dynamic> listAux = [];
  //Funcion que contruira las lista de las tarjetas de envios con su respectiva informacion
  List<Widget> dibujarTarjetas(dataTarjetas) {
    List<Widget> arregloW = [];
    for (int i = 0; i < dataTarjetas.length; i++) {
      arregloW.add(CardEnvioInfo(
          conductor: dataTarjetas[i]["Conductor"],
          calle: dataTarjetas[i]["Calle"],
          ciudad: dataTarjetas[i]["Ciudad"],
          area: dataTarjetas[i]["Area"],
          telefono: dataTarjetas[i]["Telefono"],
          codigoZip: dataTarjetas[i]["CodigoZip"]));
    }
    return arregloW;
  }

  //Funcion que  busca en la lista de valores los conductores que contengan las cadenas ingresadas
  void busqueda(String texto) {
    var textoModificado = texto.replaceAll(' ', '').toUpperCase();
    listAux.clear;
    setState(() {
      listAux = listaValores
          .where((s) => s["Conductor"]
              .replaceAll(' ', '')
              .toUpperCase()
              .contains(textoModificado))
          .toList();
    });
  }

  @override
  void initState() {
    var envios = direccciones;
    var conduct = conductores;
    asignarEnvios(envios, conduct);
    listaValores = obtenerInformacionDeTarjeta(
        envios, arreglosGemeloCunductor, arreglosGemeloCalle);
    listAux = listaValores;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Envios asignados',
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
      body: Container(
          margin: EdgeInsets.only(top: 15, right: 15, left: 15),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: SearchBar(callback: busqueda),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: dibujarTarjetas(listAux),
                ),
              )
            ],
          )),
    );
  }
}
