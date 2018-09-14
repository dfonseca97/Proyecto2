# README


## Tracker M 
##### Tópicos Especiales de Telemática  - Proyecto 2
* Sebastián Patiño Barrientos
* Diego Antonio Fonseca 
* Luis Miguel Marín Loaiza
###### EAFIT  -  2018-2

Este repositorio fue creado para gestionar y controlar las versiones del proyecto número 2 de la materia Tópicos Especiales de Telemática.

## Despliegue On-premise

### Prerequisitos 
* 3 Servidores con CentOS7  instalado
> Como Ejemplo usaremos las siguientes IP's Privadas
> 10.131.137.153 para el nodo Manager
> 10.131.137.203 para el nodo Worker1
> 10.131.137.154 para el nodo Worker2
* Acceso vía **ssh** (Secure Shell - Puerto 22)
*  **Git** instalado
```
    # yum install git -y 
```
* Algún editor de texto (ej: emacs, nano, ..)
```
	# yum install emacs -y
```

### Creación del cluster con Docker SWARM
El tutorial para la creación del cluster en [Docker Swarm](https://docs.docker.com/engine/swarm/) en 3 Nodos que tienen CentOS 7, fué de aquí: [Tutorial](https://hostadvice.com/how-to/how-to-setup-docker-swarm-cluster-on-centos-7/).

#### Antes de Empezar 
Actualizar el sistema con los ultimos paquetes disponibles.
```
# yum update -y
```
En cada máquina, asegurarse de configurar el fichero ``/etc/hosts``, este fichero puede ser modificado con permisos de super usuario:
```
10.131.137.153   dkmanager.example.com dkmanager
10.131.137.154   workernode1.example.com  workernode1
10.131.137.203   workernode2.example.com  workernode2
```
Guarda la configuración, una vez se haya hecho las anteriores modificaciones.

Ejecutar el los siguientes comandos en cada uno de los nodos.
* Manager Node
```
 # hostnamectl set-hostname managernode
```
* Worker Node 1
```
 # hostnamectl set-hostname workernode1
```
* Worker Node 2
```
 # hostnamectl set-hostname workernode2
```


#### Paso 1: Instalar el Motor de Docker y docker-compose
Este paso se ejecutara en el nodo manager.
```
[root@dkmanager ~]# yum install yum-utils -y
[root@dkmanager ~]# yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
[root@dkmanager ~]# yum install docker-ce
[root@dkmanager ~]# systemctl start docker
[root@dkmanager ~]# systemctl enable docker
```
instalar [docker-compose](https://docs.docker.com/compose/install/):
```
[root@dkmanager ~]$ sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
[root@dkmanager ~]$ chmod +x /usr/local/bin/docker-compose
```
Hacer lo mismo con los dos nodos restantes

#### Paso 2:  Configurar el Firewall en cada Nodo
Los siguientes comandos abriran los puertos necesarios para que docker Swarm pueda formar su cluster correctamente:
```
[root@dkmanager ~]# firewall-cmd --permanent --add-port=2376/tcp
success

[root@dkmanager ~]# firewall-cmd --permanent --add-port=2377/tcp
success

[root@dkmanager ~]# firewall-cmd --permanent --add-port=7946/tcp
success

[root@dkmanager ~]# firewall-cmd --permanent --add-port=7946/udp
success

[root@dkmanager ~]# firewall-cmd --permanent --add-port=4789/udp
success

[root@dkmanager ~]# firewall-cmd --permanent --add-port=80/tcp
success	    

[root@dkmanager ~]# firewall-cmd --reload
success
```
Reiniciar el servicio de docker
```
[root@dkmanager ~]# systemctl restart docker
```
**Nota:** Realizar esta apertura de de puertos en todos los nodos. 

#### Paso 3:  Iniciar el cluster de Swarm
Desde el nodo manager ejecutar el siguiente comando, tener en cuenta que la IP privada que aparece en el comado correspode a la direccion del nodo Manager (puede verse ejecutando el comando ``$ ifconfig`` o ``$ id addr show``):
```
[root@dkmanager ~]# docker swarm init --advertise-addr 10.131.137.153
```
Automáticamente responderá con un mensaje muy similar al siguiente:
```
Swarm initialized: current node (viwovkb0kb0kxlkk98r78apopo) is now a manager.

To add a worker to this swarm, run the following command:

	docker swarm join --token SWMTKN-1-3793hvb71g0a6ubkgq8zgk9w99hlusajtmj5aqr3n2wrhzzf8z-
1s381ymnir13hhso1qxt5pqru 10.131.137.153:2377

To add a manager to this swarm, run 'docker swarm join-token
manager' and follow the instructions.
```
Dicho output es un token que si se ejecuta sobre los nodos worker permiten la coneccion ...

Continuara....
