Imagen de base para correr vServer de 32bits en ubuntu 14.0.4

### Uso

Para correr el vserver dentro de un container debes usar esta imagen como base para crear tu propia imagen pues por conflictos con el licenciamiento el vServer no puede estar incluido directamente en la imagen.

crea un archivo Dockerfile con el contenido:

```bash
FROM heavyblade/vserver

COPY vserver.719.tar.gz vserver.tar.gz
RUN tar -zxf vserver.tar.gz
EXPOSE 690

CMD monit -d 10 -Ic /etc/monitrc

```
**Nota**: Cambiar "vserver.719.tar.gz" por el nombre del archivo tar en que tienes tu vServer.

Despúes crea tu propia docker image con el Dockerfile que acabas de crear, dentro del mismo directorio donde tienes el Dockerfile:

`docker build -t vserver_719 .`

### Crea containers basados en la imagen 'vserver_719' que acabas de crear:

`docker run --name vserver -p 690:690 -v ~/data:/home/data vserver_719`
