#!/bin/bash
# If you run ./element.sh 1, ./element.sh H, or ./element.sh Hydrogen, 

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

MAIN_PROMPT_ELEMENT(){
  if [[ -z $1 ]] 
  then
    echo "Please provide an element as an argument."
    exit
  fi

  if [[ $1 == 'Error: Invalid prompt value' ]] 
  then 
    echo "Invalid please input atomic numbers etc(1), element symbols etc(H) or element names etc(Hydrogen)." 
    exit
  fi 

  if [[ $1 == "Can't find" ]] 
  then 
    echo "I could not find that element in the database."
    exit
  fi

  if [[ $1 =~ ^[0-9]+$ ]]
    then 
      ATOMIC_VALUE_ID=$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number = $1")
      if [[ -z $ATOMIC_VALUE_ID ]]
      then 
          MAIN_PROMPT_ELEMENT "Can't find"
      fi
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$ELEMENT_TYPE_ID")
      ELEMENT_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
    
      echo "The element with atomic number $ATOMIC_VALUE_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
    then
      ATOMIC_VALUE_ID=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
      if [[ -z $ATOMIC_VALUE_ID ]]
      then 
          MAIN_PROMPT_ELEMENT "Can't find"
      fi
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$ELEMENT_TYPE_ID")
      ELEMENT_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
    
      echo "The element with atomic number $ATOMIC_VALUE_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
   elif [[ $1 =~ ^[A-Za-z]+$ ]]
    then
      ATOMIC_VALUE_ID=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
      if [[ -z $ATOMIC_VALUE_ID ]]
      then 
          MAIN_PROMPT_ELEMENT "Can't find"
      fi
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$ELEMENT_TYPE_ID")
      ELEMENT_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
      ELEMENT_BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_VALUE_ID")
    
      echo "The element with atomic number $ATOMIC_VALUE_ID is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
   else
      MAIN_PROMPT_ELEMENT "Error: Invalid prompt value"
   fi
}

MAIN_PROMPT_ELEMENT $1