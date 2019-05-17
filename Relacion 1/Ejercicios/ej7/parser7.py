import re

# Nombres de los ficheros de entrada y salida
SALIDA = "problema.pddl"
ENTRADA = "entrada.txt"

# Abrimos los ficheros
problema = open("problema.pddl", "w")
entrada = open("entrada.txt", "r")

# Minimo de puntos
minimo_puntos = ""
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
# Tipo de cada zona
tipo_zonas = []
# Nombre de agentes
agentes = []
# Costes de zonas
costes_zonas = []
# Capacidad de los personajes
capacidades_personajes = []
# Coste total
coste_total = ""
# Puntos por jugador
puntos_jugadores = []
inicializacion_puntos = []

for line in entrada:
    # Obtenemos la cota del coste
    if "coste_total_menor" in line:
        coste_total = line.split(":")[1].strip()
    # Cogemos el número de zonas
    if "numero de zonas" in line:
        num_zonas = int(line.split(":")[1])
    if "bolsillo" in line:
        bolsillo = line[line.find(":")+1:].strip().split("[")[1].split("]")[0]
        for bol in bolsillo.split(" "):
            capacidades_personajes.append("(= (numeroObjetos " + bol.split(":")[0] + ") " + bol.split(":")[1] + ")")
    if "Dominio" in line:
        nombre_dominio = line.split(":")[1].strip()
    if "Problema" in line:
        nombre_problema = line.split(":")[1].strip()
    if "puntos_totales" in line:
        minimo_puntos = line.split(":")[1].strip()
    if "puntos_jugador" in line:
        puntos = line[line.find(":")+1:].strip().split("[")[1].split("]")[0]
        for punto in puntos.split(" "):
            puntos_jugadores.append("(>= (puntosObtenidos " + punto.split(":")[0] + ") " + punto.split(":")[1] + ")")
            inicializacion_puntos.append("(= (puntosObtenidos " + punto.split(":")[0] + ") 0)")
    # Separamos la línea
    if "->" in line:
        zonas_linea = []
        tipos = []
        info = line.split("->")[1].strip()
        # Cogemos los pesos de los arcos de cada conexión
        costes=[]
        for parte in info.split(")=")[1:]:
            costes.append(parte.split("=")[0])
        # Separamos por la expresión regular =[0-9]*=
        regex = re.compile('=[0-9]*=')
        # Separamos para coger las zonas y los personajes
        for z in regex.split(info):
            #Añadimos el tipo de la zona
            tipos.append(z.split("(")[1].split(")")[0])

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

        # Añadimos el tipo de cada zona
        for tipo, zona in zip(tipos, zonas_linea):
            tipo_zonas.append("(es " + tipo + " " + zona + ")")

        # Añadimos las relaciones de conexión
        for i in range(len(zonas_linea)-1):
            costes_zonas.append("(= (coste " + zonas_linea[i+1] + " " + zonas_linea[i] + ") " + costes[i] + ")")
            costes_zonas.append("(= (coste " + zonas_linea[i] + " " + zonas_linea[i+1] + ") " + costes[i] + ")")
            if "H" in line.split("->")[0]:
                relaciones.append("(conectado " + zonas_linea[i] + " " + zonas_linea[i+1] + " " + "este" +  ")")
                relaciones.append("(conectado " + zonas_linea[i+1] + " " + zonas_linea[i] + " " + "oeste" +  ")")
            if "V" in line.split("->")[0]:
                relaciones.append("(conectado " + zonas_linea[i] + " " + zonas_linea[i+1] + " " + "sur" +  ")")
                relaciones.append("(conectado " + zonas_linea[i+1] + " " + zonas_linea[i] + " " + "norte" +  ")")

# Escribimos el fichero
problema.write("(define (problem " + nombre_problema + ")\n")
problema.write("    (:domain " + nombre_dominio + ")\n")

pickers = []
dealers = []

problema.write("    (:objects\n")
for personaje in personajes:
    if "picker" in personaje:
        pickers.append(personaje.split("-")[0])
        problema.write("        " + personaje.split("-")[0] + " - agente\n")
    elif "dealer" in personaje:
        dealers.append(personaje.split("-")[0])
        problema.write("        " + personaje.split("-")[0] + " - agente\n")
    else:
        problema.write("        " + personaje.split("-")[0] + " - " + personaje.split("-")[1] + "\n")
problema.write("        ")
for zona in list(set(zonas)):
    problema.write(zona + " ")
problema.write("- zona\n    )\n")

problema.write("    (:init\n")
for relacion in relaciones:
    problema.write("        " + relacion + "\n")

for tipo_zona in list(set(tipo_zonas)):
    problema.write("        " + tipo_zona + "\n")

for p in pickers:
    agentes.append(p)
for d in dealers:
    agentes.append(d)

for agente in agentes:
    problema.write("        (orientado " + agente + " norte)\n")
    problema.write("        (manovacia " + agente + ")\n")
    problema.write("        (mochilavacia " + agente + ")\n")

for pers, zona in zip(personajes, posiciones_personajes):
    problema.write("        (en" + " " + pers.split("-")[0] + " " + zona + ")\n")

for pers in personajes:
    if "bikini" in pers.split("-")[1]:
        problema.write("        (esbikini " + pers.split("-")[0] + ")\n")
    if "zapatilla" in pers.split("-")[1]:
        problema.write("        (eszapatilla " + pers.split("-")[0] + ")\n")

for picker in pickers:
    problema.write("        (espicker " + picker + ")\n")

for dealer in dealers:
    problema.write("        (esdealer " + dealer + ")\n")

for coste in costes_zonas:
    problema.write("        " + coste + "\n")

problema.write("        (= (costeTotal) 0)\n")
problema.write("        (= (puntosTotales) 0)\n")

for inicializacion in inicializacion_puntos:
    problema.write("        " + inicializacion + "\n")

lista_personajes = []
lista_objetos = []

for per in personajes:
    if per.split("-")[1].strip() in ["bruja", "princesa", "principe", "profesor", "leonardo"]:
        lista_personajes.append(per)
    if per.split("-")[1].strip() in ["oscar", "manzana", "rosa", "algoritmo", "oro"]:
        lista_objetos.append(per)

puntos_leonardo = {"oscar": "10", "rosa": "1", "manzana": "3", "algoritmo": "4", "oro": "5"}
puntos_princesa = {"oscar": "5", "rosa": "10", "manzana": "1", "algoritmo": "3", "oro": "4"}
puntos_bruja = {"oscar": "4", "rosa": "5", "manzana": "10", "algoritmo": "1", "oro": "3"}
puntos_principe = {"oscar": "1", "rosa": "3", "manzana": "4", "algoritmo": "5", "oro": "10"}
puntos_profesor = {"oscar": "3", "rosa": "4", "manzana": "5", "algoritmo": "10", "oro": "1"}
puntos = {"leonardo": puntos_leonardo, "princesa": puntos_princesa, "bruja": puntos_bruja, "principe": puntos_principe, "profesor": puntos_profesor}

for per in lista_personajes:
    for obj in lista_objetos:
        problema.write("        (= (puntos " + obj.split("-")[0].strip() + " " + per.split("-")[0].strip() + ") " + puntos[per.split("-")[1].strip()][obj.split("-")[1].strip()] + ")\n")

for capacidad in capacidades_personajes:
    problema.write("        " + capacidad + "\n")

problema.write("    )\n")
problema.write("    (:goal (AND\n")
for pers in personajes:
    if not pers.split("-")[1] in ["agente", "oscar", "manzana", "rosa", "algoritmo", "oro", "bikini", "zapatilla", "picker", "dealer"]:
        problema.write("          (tieneobjeto" + " " + pers.split("-")[0] + ")\n")

problema.write("          (< (costeTotal) " + coste_total + ")\n")
problema.write("          (>= (puntosTotales) " + minimo_puntos + ")\n")
for puntuacion in puntos_jugadores:
    problema.write("          " + puntuacion + "\n")
problema.write("          )\n")
problema.write("    )\n")
problema.write(")\n")
