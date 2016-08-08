Imagen de base para correr vServer de 32bits en ubuntu 14.0.4

## Descripción

Esta imagen contiene el setup básico para que puedas correr un vserver
para linux dentro de un container atacando los problemas de compatibilidad de un
programa de 32bits en un entorno de 64bits y el hecho de que el script que
arranca el vserver hace un detach por lo que no puede ser usado
directamente como comando de inicio de un container.

## Uso

En primera instancia debes tener docker corriendo en tu maquina para
ello solo revisa las instrucciones de instalación en:

- [Mac](https://docs.docker.com/docker-for-mac/)
- [Linux](https://docs.docker.com/engine/installation/linux/ubuntulinux/)
- [Windows](https://docs.docker.com/engine/installation/windows/)

### Crea tu Imagen:

Dado que los vServers tienen licenciamiento el ejecutable del vServer no puede estar
incluido en esta imagen, para ejecutar un vserver en un container primero debes crear
tu propia imagen, para ello crea un archivo llamado "Dockerfile" con el contenido:

```bash
FROM heavyblade/vserver

# Copia el vServer de la carpeta actual dentro de container
COPY vserver.719.tar.gz vserver.tar.gz
RUN tar -zxf vserver.tar.gz
EXPOSE 690

CMD monit -d 10 -Ic /etc/monitrc
```
**Nota**: Debes Cambiar "vserver.719.tar.gz" por el nombre del archivo ".tar" que
obtienes al descargar tu velneo vserver para linux.

Ahora pasas a crear tu propia imagen, para ello dentro del mismo directorio donde tienes el Dockerfile ejecuta:

`docker build -t vserver_719 .`

#### Crea containers:

Ahora que ya tienes la imagen con el vServer dentro y puedes crear containers que serán el vserver corriendo,
ejecutando el comando:

`docker run --name vserver -p 690:690 -p 2812:2812 -v ~/data:/home/data -d vserver_719`

**Notas**:

- Reemplace "~/data" por el directorio en tu maquina en donde quieres albergar los datos de las soluciones que correran en el container

- "--name" será el nombre para el container.

- "-p 690:690"  indica que mape el puerto 690 del container al nuestro.

- "-p 2812:2812" Mapea el puerto donde el interface web de monit esta
  disponible, desde allí puedes ver el estado del vserver y además
puedes iniciarlo, pararlo o reiniciarlo

- "v ~/data:/home/data", la carpeta "/home/data" es la carpeta compartida por defecto, este parametro indica que mape la carpeta "/home/data" dentro del container a "~/data" en nuestro disco, esto con el fin de que no se pierda información cuando se pare el container.

- "-d" indica que se arranque el servicio en background como un demonio.

- "vserver_719" es el nombre de la imagen que se usará para correr el container.


## FAQ'S

- **¿Esta imagen solo funciona para Mac?**

No, puedes usar esta imagen en todo el ecosistema que soporte docker,
aunque su razón de ser es dar la posibilidad de ejecutar un vserver
dentro de un mac, pues ya existen ejecutables para linux y windows.

- **¿y la activación de licencias?**

Para ello debes de logearte dentro de tu container parar el vserver y
realizar la activación como es recomendado:

`./VelneoV7-vServer//vActivator.sh -l xxxx-xxxx-xxxx-xxxx -u 1`

- **¿Puede correrse más de un vserver a la vez?**

Si, en esencia ese es el poder de los containers, perfectamente puedes
tener corriendo en simultáneo 2 vserver cada uno en su container
mapeado el puerto 690 dentro del container a puertos diferentes en tu
maquina, así no necesitas licencias especiales para puertos diferentes
al 690.

