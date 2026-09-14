package com.project;

import com.project.utilitats.UtilitatsFitxers;

import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

// Aquesta classe llegeix un fitxer de text línia a línia utilitzant Scanner.
public class LecturaArxiuScanner {

    // Mètode principal
    public static void main(String[] args) {
        String camiBase = System.getProperty("user.dir") + "/data/";
        String nomFitxer = "ArxiuWriter.txt";
        String camiFitxer = camiBase + nomFitxer;

        // Crear la carpeta 'data' si no existeix
        try {
            UtilitatsFitxers.crearCarpetaSiNoExisteix(camiBase);
        } catch (Exception e) {
            System.out.println("Error en la creació de la carpeta: " + camiBase);
            e.printStackTrace();
            return;
        }

        // Llegir el fitxer i mostrar el contingut
        llegirIMostrarFitxer(camiFitxer);
    }

    // Mètode per llegir i mostrar el contingut d'un fitxer línia a línia
    public static void llegirIMostrarFitxer(String camiFitxer) {
        File fitxer = new File(camiFitxer);
        try (Scanner scanner = new Scanner(fitxer, StandardCharsets.UTF_8)) {
            while (scanner.hasNextLine()) {
                String linia = scanner.nextLine();
                System.out.println(linia);
            }
        } catch (IOException e) {
            // Scanner(File, Charset) pot llençar IOException (fitxer no trobat, permisos, etc.)
            System.out.println("No s'ha pogut llegir el fitxer: " + camiFitxer + " (" + e.getMessage() + ")");
        }
    }
}
