# Documento 3

## 1. Miembros del equipo

* Diego Antonio Fonseca
* Luis Miguel Mar�n
* Sebasti�n Pati�o

## 2. Dise�o de arquitectura de la Aplicaci�n y Sistema

### a. Vista de desarrollo

![Diagrama de componentes](Componentes.png)

#### i. Definici�n de Tecnolog�a de Desarrollo

La tecnolog�a utilizada para desarrollar la aplicaci�n es Ruby on Rails, un framework que permite crear aplicaciones web con modelo vista controlador. Para la vista de la aplicaci�n se utiliz� HTML 5, JavaScript y Bootstrap.

#### ii. URLs de repositorio (github)

https://github.com/dfonseca97/Proyecto2

### b. Vista de despliegue

![Diagrama de despliegue](Despliegue.png)

#### i. Definici�n de Tecnolog�a v3 � Infraestructura TI

La aplicaci�n fue desplegada en AWS y el DCA utilizando una m�quina virtual con un sistema operativo Centos7. Se utilizaron contenedores Docker para subir el servidor web NGINX y la aplicaci�n en rails. Para asegurar disponibilidad y rendimiento se distribuy� la aplicaci�n mediante Docker Swarm en los diferentes nodos que se poseen y adem�s se configur� el servidor web para funcionar como un balanceador de cargas. La base de datos utilizada fue PostgreSQL y se encuentra ubicada en el nodo manager para poder sincronizar los datos de la aplicaci�n. 

#### ii. URL de ejecuci�n privada
http://10.131.137.153

#### iii. URL de ejecuci�n p�blica y segura: telematica2.tk

## 3. Implementaci�n y Pruebas por Atributo de Calidad

### a. Implementaci�n

Para la disponibilidad se decidi� desplegar la aplicaci�n en diferentes nodos con contenedores conectados por Docker Swarm con el objetivo de lograr que la aplicaci�n no falle si el nodo en la que est� se cae. Para el rendimiento se implement� un balanceo de cargas mediante una configuraci�n de NGINX con un m�todo de Round Robin para lograr distribuir las peticiones a los diferentes nodos, utilizando sticky session para mantener las sesiones que ya han sido iniciadas. Para la seguridad se implement� la autentificaci�n con Auth0 lo que permite iniciar sesi�n en un servidor externo a la aplicaci�n y evitar falsificaci�n de peticiones en la aplicaci�n. Tambi�n se cre� un certificado SSL para el dominio de la aplicaci�n. 

#### i. Herramientas utilizadas

Las herramientas utilizadas para la implementaci�n fueron el framework de Ruby on Rails, Auth0 para la autentificaci�n, OpenStreet Maps para la visualizaci�n de las ubicaciones.

#### ii. Cambios en la implementaci�n de la aplicaci�n

Para la realizaci�n de este proyecto se modific� la autentificaci�n, antes se utilizaba devise. La visualizaci�n se cambi� de Google Maps a OpenStreet Maps

### b. Esquemas de pruebas para comprobar el Atributo de Calidad.

* **Disponibilidad:** Las pruebas de disponibilidad ser�n realizadas enfoc�ndose en la independencia de los nodos entre s�. Se planea desconectar un nodo y verificar que los dem�s sigan funcionando. 

* **Rendimiento:** Las pruebas de rendimiento ser�n realizadas con la herramienta JMeter la cual permite hacer gran cantidad de peticiones a la aplicaci�n. Utilizando esta herramienta se puede verificar el tiempo de respuesta de la aplicaci�n. Se espera lograr obtener un tiempo de respuesta promedio de 1 segundo en la generaci�n de las ubicaciones. 

* **Seguridad:** Las pruebas de seguridad ser�n realizadas enfoc�ndose en la fortaleza de las pol�ticas de contrase�a, protecci�n contra inyecci�n de SQL en los campos de la aplicaci�n y ataques de falsificaci�n de peticiones en sitios cruzados. Para comprobar la seguridad de la aplicaci�n se realizar�n una serie de scripts simulando este tipo de ataques y se espera que la aplicaci�n sea resistente contra ellos. 

## 4. Marco-referencia-v3: Versi�n final de las bases conceptuales, patrones, mejores pr�cticas, etc de los atributos de calidad seleccionados.

### Disponibilidad (Confiabilidad y Recuperaci�n)
En general, el principal objetivo del QA de disponibilidad se resume a Permitir soportar las fallas del sistema de tal manera que el servicio entregado por dicho sistema siga siendo compatible con su especificaci�n.
Esto implica entender que una falla solo representa una amenaza cuando este fen�meno  afecta tanto a los servicios del sistema, que las especificaciones del sistema ya no se cumplen.
La literatura propone estrategias y t�cticas que garantizan la disponibilidad desde los siguientes tres frentes:

 * **Detecci�n de fallas**
Para la detecci�n de fallas existen varias t�cticas, entre ellas se encuentran las estrategias de _Ping_ o _Echo_ (para verificar que un sistema responda), monitores tipo _heatbeat_ o _watchdog_ (para verificar que un sistema sigue �con vida� de no ser as�, lo reinicia), _Sistemas de excepciones_, y sistemas de _Redundancia Modular Triple_.

* **Recuperaci�n de fallas**
En relaci�n a la recuepraci�n de fallas existen 2 grandes procesos:
  * **Reparation and repair**: En esta fase la idea es que el sistema reconozca la falla y la repare, pero que mientras eso ocurre desde la perspectiva del usuario el sistema debe seguir funcionando de manera correcta, para esto tecnolog�as como _redundancia pasiva_ y _redundancia activa_, _sparing_, _gesti�n de excepciones_ e incluso _actualizaciones de software_; permiten administrar este proceso.
  
  * **Reintroduction**: En esta frase el objetivo es dejar las funcionalidades del sistema corriendo en estado normal, cumpliendo con las especificaciones iniciales, esta reintroducci�n se habilita despues de la fase de reparaci�n y las tecnolog�as que se usan para esto son _Sombra_, _resincronizaci�n de estado_, _Rollback_, _Reinicio escalado_, entre otras.

* **Prevenci�n de fallas**
Una de las mejores pr�cticas a la hora de garantizar disponibilidad y enfrentarse a las fallas, es preveer su aparici�n y/o realizar actividades preventivas que minimicen el impacto de las fallas, a este nivel las tecnolog�as que podemos usar son _Retiro del servicio_, _Gesti�n de Transacciones at�micas_, tener _Monitores de Procesos_ o _Prevenci�n de Excepciones_.

 >[Ver m�s](https://www.semanticscholar.org/paper/Realizing-and-Refining-Architectural-Tactics-%3A-Scott/5840ae598740c6dbfb69dc3ce30f43efa23ef9b9)
 >[_T�cticas de arquitetura: Disponibilidad_](https://profesores.virtual.uniandes.edu.co/~isis2503/dokuwiki/lib/exe/fetch.php?media=principal:modulo10-disponibilidad.pdf)


### Rendimiento
El rendimiento puede ser definido como la efectividad total de un sistema. Puede ser medido de diferentes maneras pero las m�s comunes incluyen el throughput, definido como cu�ntas unidades de informaci�n puede procesar el sistema en un determinado tiempo, y el tiempo de respuesta. El rendimiento depende de muchas variables desde c�mo est� codificado el sistema hasta la infraestructura que lo soporta. 
Por lo general es un atributo muy importante y debe ser considerado desde las fases iniciales de dise�o de una soluci�n. 
Existen varias maneras de lograr un buen rendimiento:

* Entrega y carga optimizada de los assets est�ticos
* Seleccionar un framework adecuado.
* Monitoreo del sistema
* Considerar el rendimiento desde tempranas etapas del dise�o de la soluci�n.
* Peticiones on-demand y as�ncronas
* Desarrollo y pruebas iterativas

Implementar pruebas de rendimiento tambi�n es un aspecto muy importante en un sistema, se deben considerar pruebas de la carga del sistema y de la infraestructura. 

### Seguridad

La seguridad es responsable de la capacidad que tiene un sistema para reducir la posibilidad de acciones maliciosas o accidentales al igual que la posibilidad de p�rdida o robo de informaci�n, a la ves que se provee un servicio fiable a los usuarios leg�timos. Hay varias medidas que pueden ser usadas para proteger un sistema, como: autenticaci�n, cifrado, auditor�a, entre otros.

Una buena estrategia de seguridad involucra los siguientes escenarios:
* An�lisis de seguridad
* Identificaci�n de amenazas
* Dise�o de seguridad
* Implementaci�n de seguridad
* Pruebas de seguridad
* Monitoreo de seguridad

Tomando en cuenta estos escenarios, se deben de tener encuenta los siguientes principios de seguridad al momento de pasar por cada una de esas fases:

* Defensa en profundidad
* Asegurar el eslab�n m�s d�bil
* El principio de m�nimo privilegio
* Compartimentaci�n
* Un solo punto de acceso
* Administraci�n de seguridad
* Soporte para extensibilidad
* Validaci�n de la informaci�n de usuario
* Minimizaci�n de la superficie vulnerable
* Plan para fallos
