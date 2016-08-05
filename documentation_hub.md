Imagen de base para correr vServer de 32bits en ubuntu 14.0.4

### Uso

Para correr un Velneo vserver dentro de un container debes usar esta imagen como base para crear tu propia imagen pues por el licenciamiento el vServer no puede estar incluido directamente en la presente imagen.

### Crea tu Imagen:

para crear tu propia imagen, crea un archivo Dockerfile con el contenido:

```bash
FROM heavyblade/vserver

# Copia el vServer de la carpeta actual dentro de container
COPY vserver.719.tar.gz vserver.tar.gz
RUN tar -zxf vserver.tar.gz
EXPOSE 690

CMD monit -d 10 -Ic /etc/monitrc
```
**Nota**: Cambiar "vserver.719.tar.gz" por el nombre del archivo .tar que obtienes al descargar tu velneo vserver para linux.

Ahora pasas a crear tu propia imagen, para ello dentro del mismo directorio donde tienes el Dockerfile ejecuta:

`docker build -t vserver_719 .`

#### Crea containers:

Ahora que ya tienes la imagen con el vServer dentro puedes crear containers a partir de ellos.

`docker run --name vserver -p 690:690 -v ~/data:/home/data -d vserver_719`
**Notas**:
- Reemplace "~/data" por el directorio en tu maquina en donde quieres albergar los datos de las soluciones que correran en el container
- "--name" será el nombre para el container.
- "-p 690:690"  indica que mape el puerto 690 del container al nuestro.
- "v ~/data:/home/data" indica que mapee la carpeta "/home/data" dentro del container a "~/data" en nuestro disco, esto con el fin de que no se pierda información cuando se pare el container.
- "-d" indica que se arranque el servicio en background como un demonio.
- "vserver_719" es el nombre de la imagen que se usará para correr el container.
