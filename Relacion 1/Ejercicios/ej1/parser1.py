SALIDA = "problema.pddl"
ENTRADA = "entrada.txt"

problema = open("problema.pddl", "w")
entrada = open("entrada.txt", "r")

num_zonas = 0
posiciones_personajes = []
personajes = []
zonas = []
relaciones = []
agentes = []
for line in entrada:
    if "numero de zonas" in line:
        num_zonas = int(line.split(":")[1])
    if "->" in line:
        zonas_linea = []
        info = line.split("->")[1].strip()
        for z in info.split(" "):
            zonas.append(z.split("[")[0])
            zonas_linea.append(z.split("[")[0])
            if not "[]" in z:
                posiciones_personajes.append(zonas_linea[-1])
                pers = z.split("[")[1].split("]")[0]
                if "Agente" in pers:
                    agentes.append(pers.split("-")[0])
                personajes.append(pers)
        for i in range(len(zonas_linea)-1):
            if "H" in line.split("->")[0]:
                relaciones.append("(conectado " + zonas_linea[i] + " " + zonas_linea[i+1] + " " + "este" +  ")")
                relaciones.append("(conectado " + zonas_linea[i+1] + " " + zonas_linea[i] + " " + "oeste" +  ")")
            if "V" in line.split("->")[0]:
                relaciones.append("(conectado " + zonas_linea[i] + " " + zonas_linea[i+1] + " " + "sur" +  ")")
                relaciones.append("(conectado " + zonas_linea[i+1] + " " + zonas_linea[i] + " " + "norte" +  ")")

problema.write("(define (problem problema-ej1)\n")
problema.write("    (:domain dominio-ej1)\n")

problema.write("    (:objects\n")
for personaje in personajes:
    problema.write("        " + personaje.split("-")[0] + " - " + personaje.split("-")[1] + "\n")
problema.write("        ")
for zona in zonas:
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
        problema.write("        (tieneobjeto " + " " + pers.split("-")[0] + ")\n")

problema.write("    )\n")
problema.write(")\n")
