slider 'sld1' "Slider" try(DestroyDialog GUI)catch()
Rollout GUI "Practica animacion"

(
--Para usar este programa primero tendrás que elegir la velocidad, después por capas o por piezas y por último empezar o parar. Puedes reiniciar la escena .max en caso de error o de uso indebido"
Label lbl_name "Montaje"
button btn_on "Empezar" across:2
button btn_off "Parar"
button pieza "Por Piezas"
button capas "Por capas"
button btn_borrar2 "Reiniciar"
Label lbl_speed "velocidad"
slider sld_speed type:#integer range:[1,5,timeConfiguration.playbackSpeed]

   

on btn_on pressed do
(
	PlayAnimation() /*empieza la animacion*/

) 
on btn_off pressed do
(
   StopAnimation()/*para la animacion*/
)
on pieza pressed do /*monta la escena por capas de altura*/
(
	
	for i=1 to 10 do(
		tiempo=40
		aux=i*10 /* recorre los objetos que esten entre 10 espacios de altura y los selecciona*/
	   for obj in objects where obj.pos.z > aux-10 and obj.pos.z<aux do (
		   posinicial=obj.pos.z/*guarda la posicion inicial de cada objeto*/
		   animate off
			obj.pos.z = posinicial + 1000 /*Eleva los bloques en el eje z por 1000*/
			with animate on(

				at time tiempo obj.pos.z=posinicial/*los devuelve a su posicion inicial*/
					tiempo = tiempo+10 /*por cada bloque que coloca el siguiente lo pone 10 frames mas tarde*/
			)
		)
	)
)

on capas pressed do 
(
	animales = $animales
	casa = $casa
	extras = $extras
	personajes = $personajes
	suelo = $suelo				/*crea variables que se conectan a las capas*/
	a= #(suelo,personajes,animales,extras,casa) /*crea u array ordenado*/
	elevacion=1000

	tinicial=0
	tfinal=25

	for i=1 to a.count do(
		posinicial=a[i].pos.z /*guarda la posicion inicial de cada capa*/
		animate off
			a[i].pos.z=posinicial+elevacion/*define la posicion inicial más alta para que bajen las piezas*/

		with animate on(

			  at time tfinal a[i].pos.z=posinicial /*define la posicion al final de la animacion*/
			tinicial= tinicial+tfinal
			tfinal= tfinal+25 /*cada capa que coloca hace que la siguiente baje 25 frames mas tarde*/

		)
	)
)  

on btn_borrar2 pressed do 
(
  loadMaxFile(maxFileName)/*Devuelve el archivo .max a su estado original*/
)
   on sld_speed changed val do timeConfiguration.playbackSpeed = val /*cambia la velocidad de avance de las imagenes por segundo*/
 
)
CreateDialog GUI