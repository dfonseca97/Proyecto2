# Documento 1

## 1. Definición del equipo, proyecto y aplicación

### a. Miembros del equipo y asignación de QA a miembros del equipo

* **QA1:** Disponibilidad ~> **Estudiante:** Luis Miguel Marín Loaiza
* **QA2:** Rendimiento ~> **Estudiante:** Diego Antonio Fonseca Guzmán
* **QA3:** Seguridad  ~> **Estudiante:**  Sebastian Patiño Barrientos 

### b. Selección de la aplicación basada en Proyecto1

Dirección del repositorio: [https://github.com/dfonseca97/Proyecto2.git](https://github.com/dfonseca97/Proyecto2.git) 

### c. Descripción de la aplicación

La aplicación consiste en un sistema que permita la creación de usuarios y que la aplicación pueda almacenar la ubicación geográfica de cada uno de éstos en una base de datos. Estas ubicaciones luego deben poder ser visualizadas por los usuarios en un mapa. La función de generar y almacenar la ubicación geográfica debe ser expuesta como API para poder ser usada de manera más versátil.

### d. Requisitos funcionales:

* El sistema debe poder crear usuarios nuevos.
* El sistema debe permitir a cada usuario ingresar a una sesión propia.
* El sistema debe poder almacenar la ubicación geográfica de un usuario en una sesión.
* El sistema debe poder mostrar las ubicaciones almacenadas por usuario en un mapa.

## 2. Detalles técnicos del diseño e implementación funcional para el proyecto2

Se utilizará Ruby on Rails como framework principal para el proyecto. Esta aplicación será encapsulada en un contenedor de docker, el cual se encontrará al lado de otros dos contenedores, los cuales contendrán la base de datos y nginx que funcionará como proxy inverso. Estos contenedores serán orquestados por Kubernetes para permitir la fácil escalabilidad de la aplicación.

## 3. Aplicación completa desplegada en el Data Center Académico

dfonseca.dis.eafit.edu.co

## 4. Definición de Tecnología v1

La aplicación fue desplegada en el data center académico y en una instancia de AWS. Para desplegarla se configuraron las máquinas virtuales con Centos 7 como sistema operativo y fue desplegada utilizando Docker y Docker-compose. Se desplegó con 3 contenedores conectados entre sí, uno para la aplicación, otro para la base de datos y el último para un servidor web Nginx. La aplicación está construida en Ruby on Rails y utiliza una base de datos Postgresql. Las vistas están construidas con HTML, CSS y JavaScript, utilizando Bootstrap.
 
## 5. Marco-referencia-v1


### Disponibilidad (Confiabilidad y Recuperación)
En general, el principal objetivo del QA de disponibilidad se resume a Permitir soportar las fallas del sistema de tal manera que el servicio entregado por dicho sistema siga siendo compatible con su especificación.
Esto implica entender que una falla solo representa una amenaza cuando este fenómeno  afecta tanto a los servicios del sistema, que las especificaciones del sistema ya no se cumplen.
La literatura propone estrategias y tácticas que garantizan la disponibilidad desde los siguientes tres frentes:

 * **Detección de fallas**
Para la detección de fallas existen varias tácticas, entre ellas se encuentran las estrategias de _Ping_ o _Echo_ (para verificar que un sistema responda), monitores tipo _heatbeat_ o _watchdog_ (para verificar que un sistema sigue ”con vida” de no ser así, lo reinicia), _Sistemas de excepciones_, y sistemas de _Redundancia Modular Triple_.

* **Recuperación de fallas**
En relación a la recuepración de fallas existen 2 grandes procesos:
  * **Reparation and repair**: En esta fase la idea es que el sistema reconozca la falla y la repare, pero que mientras eso ocurre desde la perspectiva del usuario el sistema debe seguir funcionando de manera correcta, para esto tecnologías como _redundancia pasiva_ y _redundancia activa_, _sparing_, _gestión de excepciones_ e incluso _actualizaciones de software_; permiten administrar este proceso.
  
  * **Reintroduction**: En esta frase el objetivo es dejar las funcionalidades del sistema corriendo en estado normal, cumpliendo con las especificaciones iniciales, esta reintroducción se habilita despues de la fase de reparación y las tecnologías que se usan para esto son _Sombra_, _resincronización de estado_, _Rollback_, _Reinicio escalado_, entre otras.

* **Prevención de fallas**
Una de las mejores prácticas a la hora de garantizar disponibilidad y enfrentarse a las fallas, es preveer su aparición y/o realizar actividades preventivas que minimicen el impacto de las fallas, a este nivel las tecnologías que podemos usar son _Retiro del servicio_, _Gestión de Transacciones atómicas_, tener _Monitores de Procesos_ o _Prevención de Excepciones_.

 >[Ver más](https://www.semanticscholar.org/paper/Realizing-and-Refining-Architectural-Tactics-%3A-Scott/5840ae598740c6dbfb69dc3ce30f43efa23ef9b9)
 >[_Tácticas de arquitetura: Disponibilidad_](https://profesores.virtual.uniandes.edu.co/~isis2503/dokuwiki/lib/exe/fetch.php?media=principal:modulo10-disponibilidad.pdf)


### Rendimiento
El rendimiento puede ser definido como la efectividad total de un sistema. Puede ser medido de diferentes maneras pero las más comunes incluyen el throughput, definido como cuántas unidades de información puede procesar el sistema en un determinado tiempo, y el tiempo de respuesta. El rendimiento depende de muchas variables desde cómo está codificado el sistema hasta la infraestructura que lo soporta. 
Por lo general es un atributo muy importante y debe ser considerado desde las fases iniciales de diseño de una solución. 
Existen varias maneras de lograr un buen rendimiento:

* Entrega y carga optimizada de los assets estáticos
* Seleccionar un framework adecuado.
* Monitoreo del sistema
* Considerar el rendimiento desde tempranas etapas del diseño de la solución.
* Peticiones on-demand y asíncronas
* Desarrollo y pruebas iterativas

Implementar pruebas de rendimiento también es un aspecto muy importante en un sistema, se deben considerar pruebas de la carga del sistema y de la infraestructura. 

### Seguridad

La seguridad es responsable de la capacidad que tiene un sistema para reducir la posibilidad de acciones maliciosas o accidentales al igual que la posibilidad de pérdida o robo de información, a la ves que se provee un servicio fiable a los usuarios legítimos. Hay varias medidas que pueden ser usadas para proteger un sistema, como: autenticación, cifrado, auditoría, entre otros.

Una buena estrategia de seguridad involucra los siguientes escenarios:
* Análisis de seguridad
* Identificación de amenazas
* Diseño de seguridad
* Implementación de seguridad
* Pruebas de seguridad
* Monitoreo de seguridad

Tomando en cuenta estos escenarios, se deben de tener encuenta los siguientes principios de seguridad al momento de pasar por cada una de esas fases:

* Defensa en profundidad
* Asegurar el eslabón más débil
* El principio de mínimo privilegio
* Compartimentación
* Un solo punto de acceso
* Administración de seguridad
* Soporte para extensibilidad
* Validación de la información de usuario
* Minimización de la superficie vulnerable
* Plan para fallos
