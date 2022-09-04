#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Salon ~~~~~\n"

MAIN_MENU() {

  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "How may I help you?"
  echo -e "\n1) Cut \n2) Color\n3) Nails\n4) Exit"
  read SERVICE_ID_SELECTED

  if [[ "$SERVICE_ID_SELECTED" =~ [1-3] ]]
    then
    MAKE_APPOINTMENT
  elif [[ $SERVICE_ID_SELECTED = 4 ]]
    then
    EXIT
  else
    MAIN_MENU "Please enter a valid option."
  fi
}

MAKE_APPOINTMENT()
{
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_ID ]]
    then
    echo -e "\nWhat's your name?"
    read CUSTOMER_NAME
    INS_CUSTOMERS=$($PSQL "INSERT INTO customers(phone,name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME')")
  fi

  echo -e "\nWhen are you available?"
  read SERVICE_TIME

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  INS_APPOINTMENTS=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

  SERVICE_B=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  echo -e "\nI have put you down for a $(echo $SERVICE_B | sed -r 's/^ *| *$//g') at $(echo $SERVICE_TIME | sed -r 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."

}

EXIT()
{
  echo -e "\nThank you for stopping in.\n"
}

MAIN_MENU
