//Variables globales que obtendran el conductor y la calle
var arreglosGemeloCalle = [];
var arreglosGemeloCunductor = [];

//Funcion que calcula la puntuacion basica de idoneidad
dynamic obtenerSSbasico(String calle, String conductor) {
  var ssBasico;
  if (calle.length % 2 == 0) {
    ssBasico = numVocales(conductor) * 1.5;
  } else {
    ssBasico = numConsonantes(conductor);
  }
  return ssBasico;
}

//funcion que obtiene la cantidad de vocales de un string
int numVocales(String conductor) {
  var num = 0;
  var arreglo = conductor.split('');
  for (int i = 0; i < conductor.length; i++) {
    if (arreglo[i] == 'A' ||
        arreglo[i] == 'E' ||
        arreglo[i] == 'I' ||
        arreglo[i] == 'O' ||
        arreglo[i] == 'U') {
      num = num + 1;
    }
  }
  return num;
}

//funcion que obtiene la cantidad de vocales de un string
int numConsonantes(String conductor) {
  var num = 0;
  var arreglo = conductor.split('');
  for (int i = 0; i < conductor.length; i++) {
    if (arreglo[i] != 'A' &&
        arreglo[i] != 'E' &&
        arreglo[i] != 'I' &&
        arreglo[i] != 'O' &&
        arreglo[i] != 'U') {
      num = num + 1;
    }
  }
  return num;
}

//funcion que verifica se hay factores en comun entre dos cadenas y
//que la cantidad de estos se mayor a uno
bool factorComun(String calle, String conductor) {
  var comun = 0;
  var arreglo1 = calle.split('');
  var arreglo2 = conductor.split('');
  if (calle.length == conductor.length) {
    comun = comun + 1;
  }
  for (int i = 0; i < calle.length; i++) {
    for (int j = 0; j < conductor.length; j++) {
      if (arreglo1[i] == arreglo2[j]) {
        comun = comun + 1;
      }
    }
  }
  if (comun > 1) {
    return true;
  } else {
    return false;
  }
}

//Funcion que obtiene el 50% de la puntuacion de idoneidad basica
dynamic obtenerCincuentaPorcientoSsBasico(ssBasico) {
  return (ssBasico / 100) * 50;
}

//Funcion que la puntuacion de idoneidad total
dynamic obtenerSsTotal(String calle, String conductor) {
  var ssBasic = obtenerSSbasico(calle, conductor);
  if (factorComun(calle, conductor)) {
    var ciencuentaPorciento = obtenerCincuentaPorcientoSsBasico(ssBasic);
    return ssBasic + ciencuentaPorciento;
  } else {
    return ssBasic;
  }
}

//Funcion que quita el numero de la calle y solo deja el nombre de esta
//igualmente quita especios en blancos y pone toda la cadena en mayusculas para su posterior uso
String obtenerNombreCalle(calleEnvio) {
  var calleNombreCompleto = calleEnvio.split(' ');
  calleNombreCompleto.removeAt(0);
  return calleNombreCompleto.join().toUpperCase();
}

//Funcion que quita especios en blancos y pone toda la cadena en mayusculas para su posterior uso
String obtenerNombreConductorMayusSinSpaces(conductor) {
  var conductorNombreCompleto = conductor.replaceAll(' ', '');
  return conductorNombreCompleto.toUpperCase();
}

//Funcion que obtiene el mejor conductor de pendidendo del(SS) para el envio
String obtenerMejorConductor(valoresAux) {
  var valorMayor;
  var conductor = '';
  for (int i = 0; i < valoresAux.length; i++) {
    if (i == 0) {
      valorMayor = valoresAux[i]['valor'];
      conductor = valoresAux[i]['Conductor'];
    } else {
      if (valoresAux[i]['valor'] > valorMayor) {
        valorMayor = valoresAux[i]['valor'];
        conductor = valoresAux[i]['Conductor'];
      }
    }
  }
  return conductor;
}

//Funcion Principal que ejecuta todo el calculo para asignar los envios a los conductores
void asignarEnvios(envios, conductores) {
  var arregloConductores = conductores;
  for (int i = 0; i < envios.length; i++) {
    var valoresAux = [];
    var calle = obtenerNombreCalle(envios[i]['Street']);
    for (int j = 0; j < arregloConductores.length; j++) {
      var conductor = obtenerNombreConductorMayusSinSpaces(conductores[j]);
      var ssTotal = obtenerSsTotal(calle, conductor);
      var valorSs = {'Conductor': conductores[j], 'valor': ssTotal};
      valoresAux.add(valorSs);
    }
    var conductorEnvio = obtenerMejorConductor(valoresAux);
    arreglosGemeloCunductor.add(conductorEnvio);
    arregloConductores.remove(conductorEnvio);
    arreglosGemeloCalle.add(envios[i]['Street']);
  }
  for (int i = 0; i < 10; i++) {
    print('${arreglosGemeloCunductor[i]} : ${arreglosGemeloCalle[i]} ');
  }
}

//Funcion que obtiene informacion para la tarjeta de informacion de envios
List<dynamic> obtenerInformacionDeTarjeta(enviosInfo, conductores, calles) {
  var arreglo = [];
  for (int i = 0; i < enviosInfo.length; i++) {
    var calleEnvio = enviosInfo[i]['Street'];
    for (int j = 0; j < 10; j++) {
      var calleAsignada = calles[j];
      if (calleEnvio == calleAsignada) {
        var data = {
          "Conductor": conductores[j],
          "Calle": enviosInfo[i]['Street'],
          "Ciudad": enviosInfo[i]['City'],
          "Area": enviosInfo[i]['Area'],
          "Telefono": enviosInfo[i]['Phone'],
          "CodigoZip": enviosInfo[i]['Zip']
        };
        arreglo.add(data);
      }
    }
  }
  return arreglo;
}
