#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

# perform tests on input to determine what was input
TEST_INPUT(){
  # if input is a number
  if [[ $USER_INPUT =~ ^[0-9]+$ ]] 
  then
    # set atomic number - will be tested again to be valid
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM properties WHERE atomic_number=$USER_INPUT")
  else
    # check if input was a symbol
    SYMBOL_RESULT=$($PSQL "SELECT symbol FROM elements WHERE symbol='$USER_INPUT'")

    # if input was not a symbol
    if [[ -z $SYMBOL_RESULT ]]
    then 
      # if user input was the name of an element - will be tested again to be valid
      ELEMENT_RESULT=$($PSQL "SELECT name FROM elements WHERE name='$USER_INPUT'")
      ELEMENT_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$USER_INPUT'")
      ATOMIC_NUMBER=$ELEMENT_ATOMIC_NUMBER
    else
      # get atomic number based on symbol - will be tested again to be valid
      SYMBOL_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$USER_INPUT'")
      ATOMIC_NUMBER=$SYMBOL_ATOMIC_NUMBER           
    fi
  fi  

  #run the method that prints info about input
  GET_INFO
   
}

# print info about element
GET_INFO(){

  # if user input not equal to  atomic_number, symbol, or name
  if [[ $USER_INPUT != $ATOMIC_NUMBER ]] && [[ $USER_INPUT != $SYMBOL_RESULT ]] && [[ $USER_INPUT != $ELEMENT_RESULT ]]
  then
    echo "I could not find that element in the database."
  else
    # get symbol based on atomic number
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")

    # get name of element based on atomic number
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")

    # get type id based on atomic_number
    TYPE_ID=$($PSQL "SELECT type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

    # get type name based on type id gathered because of atomic number
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

    # get mass based on atomic number
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

    # get melting point in celcius based on atomic number
    MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")

    # get boiling point in celcius based on atomic number
    BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    
    # print the info for the element based on user input and exit
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius." 
  fi
  
}

# if there is no input when script is ran
if [[ -z $1 ]]
then
  # exit because no input
  echo "Please provide an element as an argument."
else
  USER_INPUT=$1
  # run the method that tests the input
  TEST_INPUT  
fi