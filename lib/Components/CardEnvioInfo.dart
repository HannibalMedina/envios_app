import 'package:flutter/material.dart';

//Aqui se construye el componente de carta de informacion del envio

class CardEnvioInfo extends StatefulWidget {
  //Informacion requerida para este widget
  final conductor;
  final calle;
  final ciudad;
  final area;
  final telefono;
  final codigoZip;
  const CardEnvioInfo(
      {Key? key,
      this.conductor,
      this.calle,
      this.area,
      this.ciudad,
      this.telefono,
      this.codigoZip})
      : super(key: key);

  @override
  State<CardEnvioInfo> createState() => _CardEnvioInfoState();
}

class _CardEnvioInfoState extends State<CardEnvioInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width / 100) * 75,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Conductor:'),
                    SizedBox(
                      width: 15,
                    ),
                    Text(widget.conductor)
                  ],
                ),
                Row(
                  children: [
                    Text('Calle:'),
                    SizedBox(
                      width: 50,
                    ),
                    Text(widget.calle)
                  ],
                ),
                Row(
                  children: [
                    Text('Ciudad:'),
                    SizedBox(
                      width: 35,
                    ),
                    Text(widget.ciudad)
                  ],
                ),
                Row(
                  children: [
                    Text('Area:'),
                    SizedBox(
                      width: 50,
                    ),
                    Text(widget.area)
                  ],
                ),
                Row(
                  children: [
                    Text('Telefono:'),
                    SizedBox(
                      width: 25,
                    ),
                    Text(widget.telefono)
                  ],
                ),
                Row(
                  children: [
                    Text('CodigoZip:'),
                    SizedBox(
                      width: 15,
                    ),
                    Text(widget.codigoZip)
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width / 100) * 10,
            child: Center(
              child: Icon(Icons.directions_car),
            ),
          )
        ],
      ),
    );
  }
}
