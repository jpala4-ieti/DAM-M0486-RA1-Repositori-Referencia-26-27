# Treballar amb el .jar

Requisits: **JDK 21** i **Maven**. Executa totes les ordres des de l'arrel del projecte (on hi ha el `pom.xml`): els programes llegeixen i escriuen a la carpeta `data/` de la carpeta des d'on els llances.

## 1. Generar el .jar

```bash
mvn clean package
```

Genera `target/ams2-m0486-pr11-repo-ref-1.0.1.jar`, amb `com.project.Main` com a classe principal. Abans d'empaquetar executa els tests; per saltar-los:

```bash
mvn clean package -DskipTests
```

Aquest `.jar` només conté les classes del projecte, **no les dependències**. En aquest projecte no cal: l'única dependència és JUnit, que només s'usa per als tests.

## 2. Executar un programa

Per obrir el menú amb tots els exemples (`com.project.Main`):

```bash
java -jar target/ams2-m0486-pr11-repo-ref-1.0.1.jar
```

Per executar una classe concreta, indica-la amb `-cp`:

```bash
java -cp target/ams2-m0486-pr11-repo-ref-1.0.1.jar com.project.GestioCSV
```

Substitueix `com.project.GestioCSV` per la classe que vulguis. Executa cada programa de **lectura** després del d'**escriptura** corresponent.

| Classe | Què fa |
|---|---|
| `com.project.Main` | Menú amb tots els exemples |
| `com.project.GestioArxius` | Operacions amb fitxers i carpetes |
| `com.project.ExempleNIO` | API `java.nio.file` |
| `com.project.EscripturaArxiuWriter` / `LecturaArxiuScanner` | Text amb `Writer` / `Scanner` |
| `com.project.EscripturaArxiuList` / `LecturaArxiuList` | Text com a `List<String>` |
| `com.project.EscripturaDadesPrimitives` / `LecturaDadesPrimitives` | `DataOutputStream` / `DataInputStream` |
| `com.project.EscripturaObjectes` / `LecturaObjectes` | Serialització d'objectes |
| `com.project.EscripturaLlistes` / `LecturaLlistes` | Serialització de llistes |
| `com.project.EscripturaRandomAccessFile` / `LecturaRandomAccessFile` | `RandomAccessFile` |
| `com.project.EscripturaFileChannel` / `LecturaFileChannel` | `FileChannel` |
| `com.project.GestioCSV` | Fitxers CSV |
| `com.project.GestioXML` | Fitxers XML |
| `com.eina.EinaConcatenarFitxers` | Eina gràfica per concatenar fitxers |

Si els accents surten malament a Windows: `chcp 65001` i afegeix `-Dfile.encoding=UTF-8` després de `java`.

## 3. Generar el .jar amb totes les dependències

El `pom.xml` ja inclou aquest plugin dins de `<build><plugins>`:

```xml
<plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-assembly-plugin</artifactId>
    <version>3.7.1</version>
    <configuration>
        <descriptorRefs>
            <descriptorRef>jar-with-dependencies</descriptorRef>
        </descriptorRefs>
        <archive>
            <manifest>
                <mainClass>${main.class}</mainClass>
            </manifest>
        </archive>
    </configuration>
    <executions>
        <execution>
            <phase>package</phase>
            <goals>
                <goal>single</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

`mvn clean package` genera, doncs, dos fitxers:

```
target/ams2-m0486-pr11-repo-ref-1.0.1.jar                        (només el projecte)
target/ams2-m0486-pr11-repo-ref-1.0.1-jar-with-dependencies.jar  (projecte + dependències)
```

Tots dos tenen `com.project.Main` com a classe principal (propietat `main.class` del `pom.xml`) i s'executen igual:

```bash
java -jar target/ams2-m0486-pr11-repo-ref-1.0.1-jar-with-dependencies.jar
```

o triant la classe:

```bash
java -cp target/ams2-m0486-pr11-repo-ref-1.0.1-jar-with-dependencies.jar com.project.GestioCSV
```

## 4. Amb dependències o sense?

| | Sense dependències | Amb dependències |
|---|---|---|
| Mida | Petit | Més gran (inclou totes les llibreries) |
| Per executar-lo | Cal posar les llibreries al `-cp` | N'hi ha prou amb el `.jar` |
| Distribució | Cal enviar el `.jar` i les llibreries | Un sol fitxer |
| Actualitzar una llibreria | Canviar només aquell `.jar` | Tornar a generar-ho tot |
| Conflictes | Cap | Si dues llibreries tenen fitxers amb el mateix nom, un sobreescriu l'altre |

En aquest projecte els dos `.jar` són pràcticament iguals, perquè no hi ha dependències d'execució. La diferència es nota quan el projecte fa servir llibreries externes (per exemple, SQLite o JSON).

## 5. Tests

Els tests **no** són dins el `.jar`. `mvn clean package` els executa abans de generar-lo: si algun falla, no es crea el `.jar`. Els resultats queden a `target/surefire-reports/`.