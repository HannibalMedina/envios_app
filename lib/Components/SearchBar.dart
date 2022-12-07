import 'package:flutter/material.dart';

//Aqui se construye el componente de barra de busqueda
class SearchBar extends StatefulWidget {
  final callback;
  const SearchBar({Key? key, this.callback}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
        hintText: 'Busque un conductor',
        hintStyle: TextStyle(color: Colors.black, fontSize: 18),
        border: InputBorder.none,
      ),
      onChanged: (text) {
        var call = widget.callback;
        call(text);
      },
    );
  }
}
