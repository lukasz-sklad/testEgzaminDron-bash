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
user_answers=() # Inicjalizacja tablicy na odpowiedzi użytkownika

printf "Rozpoczynamy quiz! Przygotuj się na dawkę wiedzy lotniczej! 🚀🚀🚀\n"

for ((i=0; i<$length; i++)); do
    pytanie=$(jq -r .[$i].pytanie <<< "$quiz")
    odpowiedzi=$(jq -r .[$i].odpowiedzi <<< "$quiz")
    poprawna=$(jq -r .[$i].poprawna_odpowiedz <<< "$quiz")
    wyjasnienie=$(jq -r .[$i].wyjasnienie <<< "$quiz")
    wyjasnienie_tabela=$(jq -r .[$i].wyjasnienie_tabela <<< "$quiz") # Pobranie wyjaśnienia tabeli

    printf "\nPytanie $((i + 1)): $pytanie\n"
    for key in a b c d
    do
        printf "    $key) %s\n" "$(jq -r .[\"$key\"] <<< "$odpowiedzi")"
    done

    read -p "Twoja odpowiedź (wpisz literę): " odpowiedz
    user_answers+=("$odpowiedz")

    if [ "$odpowiedz" == "$poprawna" ]; then
        printf "\033[32mBrawo! Trafiłeś/aś! Ta odpowiedź jest jak idealne lądowanie! 🛬\033[0m\n"
        ((correct++))
        if [ -n "$wyjasnienie_tabela" ]; then
            printf "\033[34mWyjaśnienie:\n\033[0m"
            # Formatowanie tabeli przy użyciu jq i column
            (
                echo "NSTS\tLimit Wagi\tTypy Statków Powietrznych\tDodatkowe Info"
                echo "-------------------------------------------------------------------------"
                jq -c '.explanations | to_entries[] | .value.scenarios[] | {kategoria: .key, NSTS, weight_limit, aircraft_types: (.aircraft_types | join(", ")), additional_info: .additional_info}' <<< "$wyjasnienie_tabela" |
                jq -r '.NSTS + "\t" + .weight_limit + "\t" + .aircraft_types + "\t" + (.additional_info // "")' |
                column -s $'\t' -t
            )
        elif [ -n "$wyjasnienie" ]; then
            printf "\033[34mWyjaśnienie: $wyjasnienie\033[0m\n"
        fi
    else
        printf "\033[31mOj, nie tym razem! Źle trafiłeś/aś. 😟 Prawidłowa odpowiedź to: \033[33m$poprawna\033[0m\n"
        incorrect_answers+=("$i")
        if [ -n "$wyjasnienie_tabela" ] && [ "$wyjasnienie_tabela" != "null" ]; then
            printf "\033[34mWyjaśnienie:\n\033[0m"
            # Formatowanie tabeli przy użyciu jq i column
            (
                echo "NSTS\tLimit Wagi\tTypy Statków Powietrznych\tDodatkowe Info"
                echo "-------------------------------------------------------------------------"
                jq -c '.explanations | to_entries[] | .value.scenarios[] | {kategoria: .key, NSTS, weight_limit, aircraft_types: (.aircraft_types | join(", ")), additional_info: .additional_info}' <<< "$wyjasnienie_tabela" |
                jq -r '.NSTS + "\t" + .weight_limit + "\t" + .aircraft_types + "\t" + (.additional_info // "")' |
                column -s $'\t' -t
            )
        elif [ -n "$wyjasnienie" ]; then
            printf "\033[34mWyjaśnienie: $wyjasnienie\033[0m\n"
        fi
    fi
done

printf "\nPodsumowanie quizu:\n"
percentage=$(( (correct * 100) / length ))

if [ "$percentage" -gt 75 ]; then
    printf "Twój wynik: $correct z $length pytań. Gratulacje! 🎉\n"
else
    printf "Twój wynik: $correct z $length pytań. Spróbuj jeszcze raz! 💪 Nie poddawaj się! 🚁\n"
fi

if [ ${#incorrect_answers[@]} -gt 0 ]; then
    printf "\nPytania, na które udzielono błędnych odpowiedzi:\n"
    for index in "${incorrect_answers[@]}"
    do
        pytanie=$(jq -r .["$index"].pytanie <<< "$quiz")
        poprawna_litera=$(jq -r .["$index"].poprawna_odpowiedz <<< "$quiz")
        twoja_litera="${user_answers[$index]}"
        wyjasnienie=$(jq -r .["$index"].wyjasnienie <<< "$quiz")

        twoja_odpowiedz=$(jq -r .["$index"].odpowiedzi."$twoja_litera" <<< "$quiz")
        prawidlowa_odpowiedz=$(jq -r .["$index"].odpowiedzi."$poprawna_litera" <<< "$quiz")

        printf "\nPytanie $((index + 1)): $pytanie\n"
        printf "\033[31mTwoja odpowiedź: $twoja_litera) $twoja_odpowiedz 😟\033[0m\n"
        printf "\033[32mPrawidłowa odpowiedź: $poprawna_litera) $prawidlowa_odpowiedz 🎉\033[0m\n"
        if [ -n "$wyjasnienie" ]; then
            printf "\033[34mWyjaśnienie: $wyjasnienie 💡\033[0m\n"
        fi
        printf "\n"
    done
fi