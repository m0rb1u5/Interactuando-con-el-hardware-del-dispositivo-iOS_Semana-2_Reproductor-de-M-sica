# Reproductor de Música
Tarea "Reproductor de Música" del curso "Interactuando con el hardware del dispositivo iOS" que se lleva en el portal Coursera.
## Instrucciones
### Proyecto
Hacer una aplicación que permita seleccionar entre cinco diferentes canciones para reproducir. El reproductor debe tener controles de reproducción y de volumen, así como permitir la selección aleatoria de una canción.

### Descripción
Hacer una aplicación en Swift que se pueda correr en el simulador de iOS usando Xcode y que permita:
- Seleccionar entre varias canciones diferentes
  - La selección se puede hacer con un botón o cualquier otro mecanismo que usted desee (tabla, picker, etc.)
  - Las canciones deben estar “en duro”.
  - Sólo deberá tener entre 7 y 10 segundos de cada canción (por cuestiones de espacio).
  - Al seleccionar una canción deberá aparecer su título y la portada de su CD.
- En cuanto la canción sea seleccionada deberán aparecer sus datos (título y foto) e iniciará la reproducción de inmediato sin que el usuario tenga que hacer nada más.
  - Se podrá controlar la reproducción con 3 botones: Tocar, Pausar o Detener.
  - Se podrá controlar el volumen (aumentarlo o disminuirlo).
  - Este control puede hacerse con 2 botones (+ y -) o con cualquier otro mecanismo que usted desee (slider, etc.)
  - Debe contener un botón de selección aleatoria (shuffle)
  
### Entrega
- El proyecto se debe hacer en forma individual.
- El proyecto se deberá colocar GitHub.
- Se debe escribir la liga para bajarlo.


## Criterios de revisión
Para cada uno de los siguientes criterios selecciona la opción que más describa al trabajo que estás revisando.

**NOTA:** Los programas deben estar hechos en Swift para que se puedan calificar. De no ser así se debe asignar una calificación de cero puntos en todo.

## Resultado
Se muestra la pantalla del iPhone 6 al ejecutar el programa (hacer click en la imagen para ver la ejecución):

[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/p0C43EkTomE/0.jpg)](https://www.youtube.com/watch?v=p0C43EkTomE "Reproductor de Música")

La aplicación utiliza un modelo Maestro-Detalle. Así se listan las canciones con sus respectivas portadas, intérpretes y nombres de las canciones en una vista de tabla.

En la vista detalle, se muestran los datos de la canción seleccionada. Se cuenta con un slider y botón para controlar el volumen. Además, se utiliza otro slider para controlar el tiempo de reproducción de tal forma que se pueda avanzar o retroceder.
Se añade el botón "shuffle" para que se reproduzcan canciones aleatorias y el botón "repeat" para repetir las canciones cuando se termine la lista de reproducción.

Todas las funcionalidades fueron realizadas de tal modo que la aplicación funcione como un reproductor de música común.

## Créditos
- Los íconos utilizados en la aplicación fueron hechos por [Daniele De Santis](http://www.flaticon.com/authors/daniele-de-santis) del portal [FlatIcon](http://www.flaticon.com) con licencia [CC 3.0 BY](https://creativecommons.org/licenses/by/3.0/).
- Los extractos de las canciones fueron utilizados como ejemplos y usados académicamente.

***
Juan Carlos Carbajal Ipenza
