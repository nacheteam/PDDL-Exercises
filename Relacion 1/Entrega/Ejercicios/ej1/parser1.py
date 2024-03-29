import sys

# Nombres de los ficheros de entrada y salida
ENTRADA = sys.argv[1]
SALIDA = sys.argv[2]

# Abrimos los ficheros
problema = open("problema.pddl", "w")
entrada = open("entrada.txt", "r")


#Nombre Dominio
nombre_dominio = ""
#Nombre Problema
nombre_problema = ""
# Número de zonas
num_zonas = 0
# Posiciones de personajes y objetos
posiciones_personajes = []
# Nombre de personajes y objetos
personajes = []
# Nombres de zonas
zonas = []
# Relaciones de conexión entre zonas
relaciones = []
# Nombre de agentes
agentes = []

for line in entrada:
    # Cogemos el número de zonas
    if "numero de zonas" in line:
        num_zonas = int(line.split(":")[1])
    if "Dominio" in line:
        nombre_dominio = line.split(":")[1].strip()
    if "Problema" in line:
        nombre_problema = line.split(":")[1].strip()

    # Separamos la línea
    if "->" in line:
        zonas_linea = []
        info = line.split("->")[1].strip()
        # Separamos para coger las zonas y los personajes
        for z in info.split(" "):
            zonas.append(z.split("[")[0])
            zonas_linea.append(z.split("[")[0])
            # Si hay algún personaje u objeto
            if not "[]" in z:
                # Añadimos su posicion
                pers = z.split("[")[1].split("]")[0]
                for per in pers.split(","):
                    posiciones_personajes.append(zonas_linea[-1])
                    # Añadimos si es un agente
                    if "agente" in per:
                        agentes.append(per.split("-")[0])
                    # Lo añadimos a personajes
                    personajes.append(per)

        # Añadimos las relaciones de conexión
        for i in range(len(zonas_linea)-1):
            if "H" in line.split("->")[0]:
                relaciones.append("(conectado " + zonas_linea[i] + " " + zonas_linea[i+1] + " " + "este" +  ")")
                relaciones.append("(conectado " + zonas_linea[i+1] + " " + zonas_linea[i] + " " + "oeste" +  ")")
            if "V" in line.split("->")[0]:
                relaciones.append("(conectado " + zonas_linea[i] + " " + zonas_linea[i+1] + " " + "sur" +  ")")
                relaciones.append("(conectado " + zonas_linea[i+1] + " " + zonas_linea[i] + " " + "norte" +  ")")

# Escribimos el fichero
problema.write("(define (problem " + nombre_problema + ")\n")
problema.write("    (:domain " + nombre_dominio + ")\n")

problema.write("    (:objects\n")
for personaje in personajes:
    problema.write("        " + personaje.split("-")[0] + " - " + personaje.split("-")[1] + "\n")
problema.write("        ")
for zona in list(set(zonas)):
    problema.write(zona + " ")
problema.write("- zona\n    )\n")

problema.write("    (:init\n")
for relacion in relaciones:
    problema.write("        " + relacion + "\n")

for agente in agentes:
    problema.write("        (orientado " + agente + " norte)\n")
    problema.write("        (manovacia " + agente + ")\n")

for pers, zona in zip(personajes, posiciones_personajes):
    problema.write("        (en" + " " + pers.split("-")[0] + " " + zona + ")\n")

problema.write("    )\n")
problema.write("    (:goal (AND\n")
for pers in personajes:
    if not pers.split("-")[1] in ["agente", "oscar", "manzana", "rosa", "algoritmo", "oro"]:
        problema.write("          (tieneobjeto " + " " + pers.split("-")[0] + ")\n")

problema.write("        )\n")
problema.write("    )\n")
problema.write(")\n")
