+++
categories = []
date = "2015-04-19T17:55:31-03:00"
description = ""
tags = ["git", "os x"]
title = "git subtree: instalación en OS X"
+++

`git subtree` no está disponible en las instalaciones por defecto de git y puede llegar a necesitarse, por ejemplo, para mantener directorios espejados dentro de un mismo repositorio git.

<!--more-->
#### Instalación de git subtree (probado en OS X 10.7.5)

Según se lee en algunos foros la instalación más fácil es usando homebrew pero en mi caso después de varios errores, problemas de dependencias y otros inconvenientes opté por lo siguiente: 

``` bash
$ git clone https://github.com/git/git.git

$ cd git/contrib/subtree

$ make

$ sudo make prefix=/usr install
```

> `sudo` es requerido por estar trabajando en `/usr`.

> `prefix` es necesario para que subtree se instale en el directorio correcto.

Eliminar el código fuente, salvo que pretenda dársele otra utilidad.

``` bash
cd ../../..

rm -rf git/
```

Listo.

``` bash
git subtree
```