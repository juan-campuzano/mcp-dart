---
applyTo: "**"
---

# Reglas generales de código

## ISG001: Comentarios innecesarios
- El código debe estar sin comentarios a menos que sea documentación.
- Ejemplo:
  ```dart
  List<Contact> toList(Map<String, dynamic>? json) {
    if (json != null && json.isNotEmpty) {
      List<Contact> contacts = json["data"]
          .map<Contact>((e) => FormMap(e["info"]));
      return contacts;
    } else {
      return <Contact>[];
    }
  }
  ```

## ISG002: Optimización de código
- Hacer que el código sea simplificado, facilite el reuso de modelos y estructuras.
- Ejemplo:
  ```dart
  bool isChecked() {
    if (value) {
      return true;
    }
    return false;
  }
  ```

## ISG003: Correcto uso de work items en un PR
- Todo PR debe estar asociado a una HU, Halo Issue; no debe estar vinculado únicamente a tareas.
- El work item debe corresponder a los cambios realizados.

## ISG004: Duplicidad de código
- Evitar duplicidad de código, facilitar el reuso de componentes, funciones, etc.

## ISG005: Variables y funciones innecesarias
- Evitar definir variables y funciones innecesarias o que no van a ser utilizadas.

## ISG006: No quemar datos en el código
- Eliminar cualquier dato quemado y consumirlo a través del JSON, los modelos y mappers correspondientes.
- Ejemplo:
  ```dart
  // MAL
  const car = {
    carMake: "BMW",
    carModel: 5,
    carColor: "Black"
  };

  function paintCar(car) {
    car.carColor = "Red";
  }
  ```

## ISG007: No añadir contexto innecesario
- Si el nombre de tu clase/objeto te dice algo, no lo repitas en el nombre de tu variable.

## ISG008: Adjuntar test plan para cambios visuales o funcionales
- Los cambios en componentes o flujos deben ser certificados por el equipo que realiza el desarrollo (también la parte de accesibilidad).
- Se debe adjuntar el test plan (entre los work items del PR) donde se evidencie que se realizó la certificación.

## ISG009: Correcto nombramiento de ramas
- Las ramas deben ser nombradas de acuerdo con el estándar.
- Ejemplo: `bc_input_refactor`.

## ISG010: Mensaje de commit estandarizado
- Los mensajes de commit deben cumplir el estándar, descrito en la guía de contribución de Galatea.

## ISG011: Testing de código
- Se debe garantizar que el código desarrollado se encuentre testeado.
- Ejemplo: pruebas unitarias, widget tests, integration tests.

## ISG012: Cobertura de tests
- Se debe garantizar que los test tengan una cobertura de mínimo 70%.

## ISG013: Datos sensibles en código fuente
- El uso de datos sensibles en código no está permitido y lo que genera vulnerabilidades en el código.

## ISG014: Clases máximo de 250 líneas de código
- Todas las clases pueden tener como máximo 250 líneas de código.

## ISG015: Componentes y flujos con accesibilidad
- El componente o flujo debe tener implementada la accesibilidad especificada por diseño.

## ISG016: Evitar magic number/string
- Evitar definir constantes en el código, identificarlas en un lugar común como constantes.
