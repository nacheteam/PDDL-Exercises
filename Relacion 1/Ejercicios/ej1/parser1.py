SALIDA = "problema.pddl"
ENTRADA = "entrada.txt"

problema = open("problema.pddl", "w")
entrada = open("entrada.txt", "r")

num_zonas = 0
personajes = []
zonas = []
relaciones = []
for line in entrada:
    if "numero de zonas" in line:
        num_zonas = int(line.split(":")[1])
    if "->" in line:
        info = line.split("->")[1].strip()
        for z in info.split(" "):
            zonas.append(z.split("[")[0])
            if not "[]" in z:
                personajes.append(z.split("[")[1])
