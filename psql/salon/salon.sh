#!/bin/bash

PSQL="psql -X -q --username=freecodecamp --dbname=salon -t -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "Welcome to My Salon, how can I help you?\n"
  fi
  SERVICES=$($PSQL "SELECT * FROM services;")
  echo "$SERVICES" | while IFS=" " read ID BAR SERVICE_NAME
  do
    echo $ID\) $SERVICE_NAME
  done
  read SERVICE_ID_SELECTED
  SERVICE_ID_RESPONSE=$($PSQL "SELECT * FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
  if [[ -z $SERVICE_ID_RESPONSE ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
    return
  fi
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    $PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME');"
  fi
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")
  echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed -r 's/^ *(.+) *$/\1/'), $(echo $CUSTOMER_NAME | sed -r 's/^ *(.+) *$/\1/')?"
  read SERVICE_TIME
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
  $PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED,'$SERVICE_TIME');"
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -r 's/^ *(.+) *$/\1/') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *(.+) *$/\1/')."
}

MAIN_MENU
