#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ ! $1 ]]
  then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
    then
    E=$($PSQL "SELECT symbol,name,type,atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius
               FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id)
               WHERE elements.atomic_number = $1;")
  else
    E=$($PSQL "SELECT symbol,name,type,atomic_number,atomic_mass,melting_point_celsius,boiling_point_celsius
               FROM properties JOIN elements USING(atomic_number) JOIN types USING(type_id)
               WHERE (elements.name LIKE '$1' OR elements.symbol LIKE '$1');")
  fi
  if [[ -z $E ]]
  then
    echo "I could not find that element in the database."
  else
    echo "$E" | while IFS='|' read S N T A_N A_M M_P B_P
    do
      echo "The element with atomic number $A_N is $N ($S). It's a $T, with a mass of $A_M amu. $N has a melting point of $M_P celsius and a boiling point of $B_P celsius."
    done
  fi
fi
