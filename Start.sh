#!/bin/bash

# Użyj prawidłowej ścieżki do pliku JSON i upewnij się, że zawiera poprawny format jednolinijkowy.
quiz=$(cat /Volumes/APFS/__dron/____Program-Egzamin-My/testEgzamin/test.json)

length=$(jq length <<< "$quiz")
correct=0
incorrect_answers=()
answers=()

echo "Rozpoczynamy quiz! Przygotuj się na dawkę wiedzy lotniczej! 🚀"

for ((i=0; i<$length; i++)); do
    pytanie=$(jq -r .[$i].pytanie <<< "$quiz")
    odpowiedzi=$(jq -r .[$i].odpowiedzi <<< "$quiz")
    poprawna=$(jq -r .[$i].poprawna_odpowiedz <<< "$quiz")

    echo -e "\nPytanie $((i + 1)): $pytanie"
    for key in a b c d
    do
        echo "    $key) $(jq -r .\"$key\" <<< "$odpowiedzi")"
    done

    read -p "Twoja odpowiedź (wpisz literę): " odpowiedz
    answers[i]="$odpowiedz"

    if [ "$odpowiedz" == "$poprawna" ]; then
        echo -e "\033[32mBrawo! Trafiłeś/aś! Ta odpowiedź jest jak idealne lądowanie! 🛬\033[0m"
        ((correct++))
    else
        echo -e "\033[31mOj, nie tym razem! Źle trafiłeś/aś. 😟 Prawidłowa odpowiedź to: \033[33m$poprawna\033[0m"
        incorrect_answers+=("$i")
    fi
done

echo -e "\nPodsumowanie quizu:"
echo -e "Twój wynik: $correct z $length pytań. Gratulacje! 🎉"

if [ ${#incorrect_answers[@]} -gt 0 ]; then
    echo -e "\nPytania, na które udzielono błędnych odpowiedzi:"
    for index in "${incorrect_answers[@]}"
    do
        pytanie=$(jq -r .["$index"].pytanie <<< "$quiz")
        odpowiedzi=$(jq -r .["$index"].odpowiedzi <<< "$quiz")
        poprawna=$(jq -r .["$index"].poprawna_odpowiedz <<< "$quiz")
        wyjasnienie=$(jq -r .["$index"].wyjasnienie <<< "$quiz")
        user_answer="${answers[$index]}"

        echo -e "\nPytanie $((index + 1)): $pytanie"
        echo -e "Twoja odpowiedź: $user_answer"
        echo -e "Prawidłowa odpowiedź: $poprawna"
        if [ "$wyjasnienie" ]; then
            echo -e "Wyjaśnienie: $wyjasnienie"
        fi
    done
fi

echo -e "\nTo już koniec quizu. Dziękuję za udział! 🚁"