# Proyecto 1

## Uso

Dentro de la carpeta `Proyectos/Proyecto_1` primero se ejecuta

```
mvn compile
```

La clase **AnalizadorLexico** es la que obtiene los tokens de los archivos y los
coloca en la carpeta `Proyectos/Proyecto_1/out`. Para usar la clase se usa:

```
AnalizadorLexico al;
al = new AnalizadorLexico("resources/some_python_file.py");
al.analiza();
```

Para ejecutar las pruebas unitarias:

```
mvn install
```

En caso de querer obtener los tokens de un archivo en especifico:

```
mvn exec:java -Dexec.mainClass="lexico.Test" -Dexec.args="resources/fz_error_inicio.py"
```

y cambiar `resources/fz_error_inicio.py` por cualqueir otro archivo.

Para mas detalles ver los archivos de `.tavis.yml` y `.circleci/config.yml` sobre
como se ejecutan automaticamente las pruebas.
