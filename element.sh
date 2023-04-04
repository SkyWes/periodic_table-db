#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"


# I could not find that element in the database.

if [[ -z $1 ]]
then
echo Please provide an element as an argument.
elif [[ $1 =~ [0-9]+ ]]
then
ATOMIC_NUMBER=$1
# search database for atomic_number, name, type, mass, melting_point, boiling_point.
RES_SET=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e LEFT JOIN properties p LEFT JOIN types t ON t.type_id = p.type_id ON e.atomic_number = p.atomic_number WHERE e.atomic_number = '$ATOMIC_NUMBER'")
elif [[ $1 =~ [A-Z][a-z]{3,} ]]
then
NAME=$1
# search database for atomic_number, name, type, mass, melting_point, boiling_point.
RES_SET=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e LEFT JOIN properties p LEFT JOIN types t ON t.type_id = p.type_id ON e.atomic_number = p.atomic_number WHERE e.name = '$NAME'")
elif [[ $1 =~ [A-Za-z] ]]
then
SYMBOL=$1
# search database for atomic_number, name, type, mass, melting_point, boiling_point.
RES_SET=$($PSQL "SELECT e.atomic_number, e.symbol, e.name, p.atomic_mass, p.melting_point_celsius, p.boiling_point_celsius, t.type FROM elements e LEFT JOIN properties p LEFT JOIN types t ON t.type_id = p.type_id ON e.atomic_number = p.atomic_number WHERE e.symbol = '$SYMBOL'")
fi

if [[ -n $1  ]]
then
if [[ -z $RES_SET ]]
then
echo I could not find that element in the database.
else
# else print info
echo "$RES_SET" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELT_POINT BAR BOIL_POINT BAR TYPE
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELT_POINT celsius and a boiling point of $BOIL_POINT celsius."
done
fi
fi
