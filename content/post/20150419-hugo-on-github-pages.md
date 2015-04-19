+++
date = "2015-04-19T01:00:00-03:00"
draft = true
title = "Hugo en Github Pages"
tags = ["git", "github", "hugo"]
categories = ["software", "web"]
+++

Hugo y Github Pages pueden ser una excelente combinación, aunque para mantener el contenido separado del sitio generado haya que hacer algunos pocos malabares.

<!--more-->

#### Instalar git subtree (OS X 10.8)

``` bash
$ git clone https://github.com/git/git.git

$ cd git/contrib/subtree

$ make

$ make prefix=/usr install
```

El prefijo es importante para que subtree sea instalado en el directorio correcto.
Nota: debe usarse sudo por estar trabajando en /usr

Eliminar los fuentes de git, salvo que pretenda dársele otra utilidad.

``` bash
cd ../../..

rm -rf git/
```

``` bash
git subtree add --prefix=public https://github.com/martjanz/hugo-blog.git gh-pages --squash

git subtree pull -prefix=public https://github.com/martjanz/hugo_gh_blog.git gh-pages 
``