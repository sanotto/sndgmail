# SNDGMAIL

## Un comando para enviar correos electrÃnicos desde el IBMi, usando python.

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

### Como está estructurado este proyecto/tutorial.
La idea es escibir una serie de entregas donde se describe paso a paso la realización del proyecto.
El proyecto será alojado en gitlab y se creará una rama para cada entrega/capítulo de la serie.

### Agradecimientos

Quiero agradecer a Diego Kesselman de [Esselware](http://esselware.com.mx/) por poner a disposición un equipo para
el desarrollo de esta Serie.

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
 
