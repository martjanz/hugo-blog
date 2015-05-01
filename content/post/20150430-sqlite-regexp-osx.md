+++
categories = []
date = "2015-04-30T20:57:41-03:00"
description = ""
tags = ["sqlite", "regexp", "os x"]
title = "RegExp en SQLite (OS X)"
+++

SQLite, el motor base de datos portable por excelencia, no tiene soporte nativo para expresiones regulares.

– ¡Pero en la documentación dice que existe REGEXP! 

Sí, REGEXP es un comando especial para la función `regexp()` definida por el usuario, y como por defecto no hay función `regexp()` definida el uso de REGEXP suele resultar en un mensaje de error.

Para habilitar el uso de las expresiones regulares desde la línea de comandos hay que seguir algunos pasos, y eso es lo que se detalla a continuación.

<!--more-->
**Nota:** estas instrucciones son para OS X pero pueden ser muy similares para otros sistemas operativos (Linux y Windows). El concepto es el mismo.

Entonces:

#### Habilitar soporte para expresiones regulares en SQLite OS X

##### Primero, cosas a descargar

* [SQLite Amalgamation](https://sqlite.org/amalgamation.html) (todo el código fuente en un solo archivo .c)
* [Extensión PCRE](https://github.com/ralight/sqlite3-pcre) (Perl Compatible Regular Expressions) para SQLite3 

##### Segundo, compilar SQLite con soporte para extensiones
1. Extraer archivos SQLite Amalgamation en un directorio (supongamos _/sqlite3_).
2. Compilar SQLite (`-ldl`: `load_extension()` habilitado):

	```bash
	cd sqlite3

	gcc shell.c sqlite3.c -lpthread -ldl -o sqlite3
	```

##### Tercero, compilar PCRE

```bash
git clone https://github.com/ralight/sqlite3-pcre

cd sqlite3-pcre

cc -shared -o pcre.so -I/opt/local/include -fPIC -W -Werror pcre.c -L/opt/local/lib -lpcre

cd ..
```

##### Y por último, probar que todo funcione
1. Ejecutar SQLite

	```bash
	# ejecutar SQLite
	./sqlite3
	```

2. Cargar extensión y probar:
	
	```sql
	-- cargar extensión PCRE
	sqlite> .load ./sqlite3-pcre/pcre.so

	-- probar REGEXP
	sqlite> SELECT "asdf" REGEXP "(?i)^A";
	1
	```

Listo. Expresiones regulares disponibles desde la línea de comandos SQLite.