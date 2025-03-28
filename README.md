# 🚁 Przygotuj się do egzaminu na drona z naszym super skryptem! 🚀

Hej piloty przyszłości! 👋 Ten skrypt to Twój osobisty instruktor, który pomoże Ci zdać egzamin na drona bez stresu i z uśmiechem na twarzy! 😄 Sprawdź swoją wiedzę lotniczą i poczuj się pewnie przed prawdziwym testem! 💯

## Jak to działa? 🤔

Skrypt w magiczny sposób zadaje Ci pytania z wiedzy lotniczej, jedno po drugim! 🧙‍♂️

1.  **Rozpoczyna quiz:** Uruchamiasz skrypt i od razu wchodzisz w tryb egzaminu! 🚦
2.  **Pytania:** Na ekranie pojawia się pytanie, a pod nim lista możliwych odpowiedzi oznaczonych literami (a, b, c, d). 🧐
3.  **Twoja odpowiedź:** Wpisujesz literę odpowiadającą Twojemu wyborowi i naciskasz Enter. ⌨️
4.  **Wynik:** Skrypt natychmiast informuje Cię, czy Twoja odpowiedź była prawidłowa! 🎉 Jeśli trafiłeś, gratulacje! 🛬 Jeśli nie, nie martw się, dowiesz się jaka była poprawna odpowiedź. 😟
5.  **Wyjaśnienia:** Czasem podpowiedź jest lepsza niż sama odpowiedź! Skrypt wyświetli Ci wyjaśnienie, dlaczego dana odpowiedź jest prawidłowa. 💡
6.  **Podsumowanie:** Na koniec quizu zobaczysz swój wynik i listę pytań, na które odpowiedziałeś błędnie, wraz z Twoją odpowiedzią i tą prawidłową. Będziesz wiedział, nad czym jeszcze popracować! 💪

## Co jest potrzebne? ⚙️

Zanim zaczniesz latać (znaczy się uczyć! 😉), upewnij się, że masz zainstalowane:

* **Zsh:** To powłoka systemowa, w której działa skrypt. Jeśli używasz macOS lub nowszych wersji Linuxa, prawdopodobnie już ją masz! 🍎🐧
* **jq:** To lekkie i elastyczne narzędzie do przetwarzania JSON w wierszu poleceń. Bez niego skrypt nie będzie mógł odczytać pytań! 🛠️ Możesz je zainstalować np. za pomocą menedżera pakietów Twojego systemu (np. `sudo apt-get install jq` na Debianie/Ubuntu, `brew install jq` na macOS).

## Jak zacząć naukę? 🚀

1.  **Pobierz skrypt:** Ściągnij plik `Start-mac.sh` na swój komputer. Możesz go sklonować z tego repozytorium albo po prostu pobrać. 💾
2.  **Pobierz bazę pytań:** Upewnij się, że masz plik z pytaniami w formacie JSON (`test.json`). Ten plik powinien znajdować się w tym samym folderze co skrypt. 📂
3.  **Uruchom skrypt:** Otwórz swój terminal (konsolę) i przejdź do folderu, w którym zapisałeś pliki. Następnie uruchom skrypt poleceniem:

    ```bash
    sh Start-mac.sh
    ```

    lub jeśli masz uprawnienia do wykonywania pliku:

    ```bash
    ./Start-mac.sh
    ```

4.  **Do dzieła!** Skrypt poprowadzi Cię przez quiz. Odpowiadaj na pytania, wpisując odpowiednią literę i naciskając Enter. Powodzenia! 🍀

## Chcesz więcej pytań? 🤔

Jasne! Możesz łatwo dodać więcej pytań do pliku `json.txt`. Pamiętaj tylko o zachowaniu poprawnej struktury JSON. Każde pytanie powinno być obiektem z polami: `"pytanie"`, `"odpowiedzi"` (kolejny obiekt z odpowiedziami a, b, c, d), `"poprawna_odpowiedz"` (litera poprawnej odpowiedzi) oraz opcjonalnie `"wyjasnienie"`. Im więcej pytań, tym lepsze przygotowanie! 🧠

## Masz pomysły? Chcesz pomóc? 💡

Super! Jeśli masz jakieś sugestie, pomysły na ulepszenia, albo znalazłeś błąd, śmiało otwieraj issue lub wysyłaj pull requesty! Każda pomoc jest mile widziana! 👍

## Ważna uwaga! ⚠️

Pamiętaj, że ten test ma charakter edukacyjny i pomaga w przygotowaniu do egzaminu na drona organizowanego przez Urząd Lotnictwa Cywilnego (ULC). **Pytania zawarte w tym skrypcie nie są identyczne z pytaniami, które pojawią się na oficjalnym egzaminie ULC.**

Jednakże, treść pytań w naszym skrypcie opiera się na wiedzy wymaganej do zdania egzaminu ULC. Zatem, jeśli dobrze poradzisz sobie z tym testem, istnieje duże prawdopodobieństwo, że z powodzeniem zdasz również egzamin ULC.

Miej na uwadze, że ULC może zmieniać pytania egzaminacyjne, a ich sformułowania mogą się różnić. Nasz skrypt ma na celu sprawdzenie Twojej wiedzy z zakresu niezbędnego do uzyskania uprawnień.

## Licencja 📜

Ten skrypt jest udostępniany na licencji [GNU GPL v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html). Możesz zapoznać się z pełną treścią licencji pod podanym linkiem. W skrócie, licencja ta pozwala na swobodne używanie, rozpowszechnianie i modyfikowanie oprogramowania, pod warunkiem zachowania pewnych warunków, w tym udostępniania kodu źródłowego i informowania o zmianach. 😉

## Kontakt 📧

Masz pytania? Chcesz się podzielić wrażeniami? Śmiało pisz! dev@lmk.one.

**Życzymy powodzenia na oficjalnym egzaminie! 🍀 Trzymam kciuki! 🤞✈️**