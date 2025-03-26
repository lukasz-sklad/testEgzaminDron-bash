#!/bin/zsh

# Użyj prawidłowej ścieżki do pliku JSON i upewnij się, że zawiera poprawny format jednolinijkowy
# quiz=$(cat /Volumes/testEgzamin/test.json)

# $(pwd) zwraca ścieżkę bieżącego katalogu roboczego
# quiz=$(cat "$(pwd)/test.json")

# ${BASH_SOURCE[0]} zwraca ścieżkę do bieżącego skryptu
quiz=$(cat "$(dirname "${BASH_SOURCE[0]}")/test.json")




length=$(jq length <<< "$quiz")
correct=0
incorrect_answers=()

printf "Rozpoczynamy quiz! Przygotuj się na dawkę wiedzy lotniczej! 🚀\n"

for ((i=0; i<$length; i++)); do
    pytanie=$(jq -r .[$i].pytanie <<< "$quiz")
    odpowiedzi=$(jq -r .[$i].odpowiedzi <<< "$quiz")
    poprawna=$(jq -r .[$i].poprawna_odpowiedz <<< "$quiz")

    printf "\nPytanie $((i + 1)): $pytanie\n"
    for key in a b c d
    do
        printf "    $key) %s\n" "$(jq -r .[\"$key\"] <<< "$odpowiedzi")"
    done

    read -p "Twoja odpowiedź (wpisz literę): " odpowiedz

    if [ "$odpowiedz" == "$poprawna" ]; then
        printf "\033[32mBrawo! Trafiłeś/aś! Ta odpowiedź jest jak idealne lądowanie! 🛬\033[0m\n"
        ((correct++))
    else
        printf "\033[31mOj, nie tym razem! Źle trafiłeś/aś. 😟 Prawidłowa odpowiedź to: \033[33m$poprawna\033[0m\n"
        incorrect_answers+=("$i")
    fi
done

printf "\nPodsumowanie quizu:\n"
printf "Twój wynik: $correct z $length pytań. Gratulacje! 🎉\n"

if [ ${#incorrect_answers[@]} -gt 0 ]; then
    printf "\nPytania, na które udzielono błędnych odpowiedzi:\n"
    for index in "${incorrect_answers[@]}"
    do
        pytanie=$(jq -r .["$index"].pytanie <<< "$quiz")
        poprawna=$(jq -r .["$index"].poprawna_odpowiedz <<< "$quiz")
        user_answer="$(jq -r .["$index"].odpowiedzi[\"${answers[$index]}\"] <<< "$quiz")"

        printf "\nPytanie $((index + 1)): $pytanie\n"
        printf "Twoja odpowiedź: $user_answer\n"
        printf "Prawidłowa odpowiedź: $poprawna\n"
    done
fi