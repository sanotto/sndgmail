# SNDGMAIL

## Un comando para enviar correos electróicos desde el IBMi, usando python.

### Entorno necesario.

Para realizar este proyecto es necesario tener instaladas las herramientas open source
provistas para el IBMi, en particular este tutorila utilizarán las siguientes herramientas:

* Python 
* git
* vim
* bash
* Free RPG

Como se instalan estas extensiones, está fuera del alcance de esta serie, sin embargo,
para los interesados, la punta del ovillo se encuentra en:

[How to obtain the new Open Source for IBM i Product - 5733OPS](https://www.ibm.com/developerworks/community/wikis/home?lang=en#!/wiki/IBM%20i%20Technology%20Updates/page/How%20to%20obtain%20the%20new%20Open%20Source%20for%20IBM%20i%20Product%20-%205733OPS)

### Agradecimientos

Quiero agradecer a Diego Kesselman de [Esselware](http://esselware.com.mx/) por poner a disposición un equipo para
el desarrollo de este proyecto.

### Parte 1-Personalizando el editor vim.

El editor vim es un editor muy potente, pero requiere de un aprendizaje.
Esta serie no cubrirá un tutorial acerca de como utilizarlo, para ello existen muchos y muy buenos
tutoriales en la red.
Si bien vim pose una curva de aprendizaje un poco dura, es muy recomendable aprenderlo, vim estÃ¡presente 
en infinidad de equipos desde un router, cisco un teléfono android, y ahora tambíen en nuestro equipo
favorito, el IBMi.
Para aprender a utilizar vim, vim mismo incluye un tutorial al cual se accede con el comando bash:

```bash
$ vimtutor
```

Les recomiendo realizarlo, toda el código de esta serie se escribirá en vim corriendo en IBMi, 
incluyendo el presente texto.

Vim es un editor muy configurable y muy extensible por medios de plugins, nuestro interes es instalar
el plugin [Syntax files for Free-Form ILE RPG ](https://github.com/andlrc/rpgle.vim)
el cual añade soporte a vim para **Free RPG**.

Para instalar los plugins en vim, hay que instalar código vim en el directorio donde vim almacena
sus configuraciones (sí, vim incluye su propio interprete y es posible proogramarlo para hacer 
muchas cosas).
Para simplificar la tarea de instalar un plugin, hay un plugin llamado **vundle** que es un administrador
de plugines.
Vamos a instalar vundle en nuestro vim, para ello hay que ejecutar los siguiente comandos en bash:

```bash
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Una vez echo lo anterior, deberemos editar el archivo de configuraion de vim (usando vim, por
supuesto :-) ) para agregar el siguiente código:
:
```vim
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'
Plugin 'andlrc/rpgle.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
```

Luego arrancamos vim y corremos: **:PluginsInstall**.

Con estos pasos tendremos resaltado de sintaxis cuando escribamos
el cóigo **Free RPG** de nuestro proyecto.
 
### Parte 2-El cóigo Python

El códio Python que utilizaremos para enviar los correos es el siguiente:

```python

import sys
import os
import os.path
import datetime
import tempfile
import re
import shutil
import smtplib

from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.MIMEBase import MIMEBase
from email import encoders

#--------------------------------------------------------------------------
# send_mail: Enva un email usando SMTP, usando los siguientes paetros:
#
#            -toaddr   Direccin a la que debe enviarse el correo
#            -fromaddr Desde que direccin debe enviarse
#            -password Contrasa de la diren desde
#            -subject  Tema del correo
#            -body     Cuerpo del correo
#            -attachfp Path del archivo attachado
#--------------------------------------------------------------------------
def send_email(toaddr,
               fromaddr,
               password,
               subject,
               body='',
               attachfp='',
               ):
  try:
     msg = MIMEMultipart()
     msg['From'] = fromaddr
     msg['To'] = toaddr
     msg['Subject'] = subject
     msg.attach(MIMEText(body, 'plain'))
     if attachfp <> '':
       part = MIMEBase('application', "octet-stream")
       part.set_payload( open(file,"rb").read() )
       Encoders.encode_base64(part)
       part.add_header('Content-Disposition', 'attachment; filename="%s"'
                       % os.path.basename(attachfp))
       msg.attach(part)

     server = smtplib.SMTP('smtp.gmail.com', 587)
     server.starttls()
     server.login(fromaddr, password)
     text = msg.as_string()
     server.sendmail(fromaddr, toaddr, text)
     server.quit()
  except:   
     pass 
#--------------------------------------------------------------------------
# Punto de Entrada del Programa
#--------------------------------------------------------------------------
if __name__ == "__main__":
 toaddr = sys.argv[1]
 fromaddr = sys.argv[2]
 password = sys.argv[3]
 subject = sys.argv[4]
 body=''
 if len(sys.argv) >= 5:
  body = sys.argv[4]
 attach_full_path=''
 if len(sys.argv) >= 6:
  attach_full_path = sys.argv[5]

 send_email(toaddr,         \
            fromaddr,       \
            password,       \
            subject,        \
            body,           \
            attach_full_path)

El código aterior puede ejecutarse desde bash mediant:e

```bash
python2 sndgmail.py "correodestino@destino.com" "correoorigen@gmail.com" "contrase�a" "subject" "body" "attach"
```
En los próximos capítulos veremos como llamar a este programa desdel entorno habitual de IBMi mediante 
un comando creado al efecto.


