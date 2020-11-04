# importamos os para usar la consola desde el programa
import os


# Convierte el cvs a un arreglo que luego usará la función para generar diplomas
def LeerDatos(archivo):
	arreglo = []
	f = open(archivo, 'r+', encoding = 'utf-8')
	for line in f:
		arr = line.rstrip('\n').split(",")
		arr = [x.replace('"','').rstrip(' ') for x in arr]
		arreglo.append(arr)
	arreglo.pop(0)
	return arreglo

'''Esta función recibe un arreglo de la forma
[Correo, Primer Nombre, Otros Nombres, Primer Apellido, Otros Apellidos] y genera una carpeta
con el nombre del correo y adentro el pdf del diploma y un mensaje de agradecimiento.'''
def GenerarDiplomas(arreglo):
	correo = arreglo[0]
	nom = arreglo[1].replace(' ','') + arreglo[3].replace(' ','')
	# Función de espacios para concatenar correctamente en caso de haber segundo nombre vacío
	espacios = [" " if x != "" else "" for x in arreglo]
	nombre = arreglo[1]
	''' El condicional para detenerse en caso que "otros apellidos"esté vacía '''
	for x in range(1,len(arreglo) - 1 if arreglo[-1] != "" else len(arreglo) - 2):
		nombre += espacios[x] + arreglo[x + 1]
	# Toma la primera letra del correo para la carpeta
	letra = correo[0].upper()
	if letra.isnumeric():
		letra = "#"
	with open('dip-participacion.tex', 'r+', encoding = 'utf-8') as f:
		f.truncate(0)
		string = '\\participacion{' + nombre + '}'
		f.write(string)
	#Compila el diploma
	os.system('pdflatex main.tex')
	#Define el path al que se moverá
	path = '..\\Diplomas2\\' + letra +'\\' + correo
	#crea la carpeta
	comando = cmd('mkdir ' + path)
	os.system(comando)
	#cambia nombre al pdf
	diploma = 'Diploma' + nom + '.pdf'
	comando = cmd('rename main.pdf ' + diploma)
	os.system(comando)
	#genera el mensaje de felicitación
	f_in = open('felicitacion.txt', 'r', encoding = 'utf-8') #mensaje genérico
	mensaje = 'Mensaje' + nom +'.txt'
	f_out = open(mensaje, 'w+', encoding = 'utf-8') #genera archivo personalizado
	for line in f_in:
		f_out.write(line.replace('[PRIMER]', arreglo[1]).replace('[CORREO]', correo)) #reemplaza placeholders
	f_in.close()
	f_out.close()
	#mueve los archivos al directorio correcto
	comando = cmd('move ' + diploma + ' ' + path)
	os.system(comando)
	comando = comando = cmd('move ' + mensaje + ' ' + path)
	os.system(comando)


#Comando para facilitar las instrucciones a consola
def cmd(string):
	return 'cmd /c \"' + string + '\"'

	

	


# Método main para generar los diplomas
def main():
	#Genera las carpetas para cada letra
	#archivo = "..\\..\\Estadística\\Asistencia\\Diplomas2.csv"
	#arreglo = LeerDatos(archivo)
	arreglo = [["elayonestuardo168@gmail.com","Robin" ,"Estuardo", "de León", "Pérez"],["doryohana@gmail.com","Dory", "Yohana", "Morales", "García"], ["andreags0309@gmail.com","Andrea","", "García",""]]
	for arr in arreglo:
		GenerarDiplomas(arr)
	

	

if __name__ == '__main__':
	main()
