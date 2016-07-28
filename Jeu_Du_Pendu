#!/bin/bash

if [ $# -eq 0 ]
then
#nombre de mot existants dans le dico
len=`wc -w 'minidico.txt'  | cut -f 1 -d ' ' `
#download via : 
# https://drive.google.com/file/d/0B592PEOgNPxWQndQdXgySjNWRmc/view

#générer un nombre aléatoire sans dépasser le nombre total du mot
RA=$RANDOM

R=`expr $RA % $len `


#extraire le mot selon le nombre aléatoire généré
word=`tr '\n' ' ' < 'minidico.txt'  | cut -f  $R -d ' ' `

#echo $word >> .temp

#calculer sa longueur

#1ere méthode
#long=`wc -m .temp | cut -f 1 -d ' '`
#long=`expr $long - 1`


#2éme methode
long=${#word}


echo -e "La longueur du mot cherché est $long"
#inititialisation de l'affichage des '_' selon le nombre de caractères
i=0
touch .progress
	while [ $i -lt $long ] 
		do
		i=`expr $i + 1 `
		echo '_' >> .progress              	
	done

Vprog=` cat .progress `
Vprog=` echo $Vprog | tr -d ' ' `
chars_found=$long

echo $Vprog
#début des tentatives 
max=0
win=0
B=1
left=11
	rm .progress
	until [ $max -eq 12 ] || [ $win -eq 1 ]
	do
		
		
		echo  -e "\n Saisissez votre tentative : "
		read T
		cpt=${#T}

			#la longueur saisie doit être de même longueur
			until [ $cpt -eq 1 ]
			do
			echo  -e "Saisissez un seul caractère  !!  "
			read T
			cpt=${#T}
			done

	
		
	
		j=1
	#vérification de chaque tentative
	
		#vérification de chaque caractère
			test_char=$T
		#nombre d'occurence
		#occ=`tr -d -c $test_char < .temp | wc -c`
			touch .progress
	
					x=1				
					while [ $x -le $long ]
					do
                      	           y=`expr $x - 1`				
					   true_char=${word:$y:1}


					   prog_char=${Vprog:$y:1}


					    if [ $prog_char = "_" ]
						then
						  if [ $true_char == $test_char ]
						  then
						echo $test_char >> .progress
						  chars_found=`expr $chars_found - 1 `
						B=0
						else
						echo '_' >> .progress
					          fi
					else 
					echo $prog_char >> .progress
					    fi
						x=`expr $x + 1 `
					done
				
	if [ $B -eq 1 ]
	then
		left=$((11-$max))
	max=`expr $max + 1`	
	fi	
	echo -e "(Vous avez encore $left tentatives) \n "
Vprog=` cat .progress `
Vprog=` echo $Vprog | tr -d ' ' `
		rm .progress

		
		
B=1

if [ $chars_found -eq 0 ] 
then
	win=1
else
echo $Vprog
fi
done

if [ $win -eq 1 ]
 then
echo -e "Congrats Mystery solved ! Genius !! :D "
else 
echo -e "Too bad :/ Not that easy hein ! Here it is ! "
fi
echo -e " The word is $word"
#rm .temp
else
echo ' No Arguments Needed'
fi



