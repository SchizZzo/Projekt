# Analiza użycia plików cookie

## Jak aplikacja przechowuje dane logowania
- Frontend korzysta z tokenów JWT zapisywanych w `localStorage` (klucze `accessToken` i `refreshToken`). Tokeny są następnie przesyłane w nagłówku `Authorization` przy każdej autoryzowanej prośbie i odświeżane przez wywołanie `/joker-login-api/refresh/`.
- Brak mechanizmu zapisywania tokenów w plikach cookie po stronie przeglądarki.

## Cookies po stronie backendu
- Backend Django ma włączone `SessionMiddleware` i `CsrfViewMiddleware`. Oznacza to, że serwer **może** ustawić techniczne pliki cookie `csrftoken` (ochrona CSRF) oraz `sessionid` (sesje Django) w sytuacjach, gdy korzysta się z panelu administracyjnego lub przeglądarki API DRF.
- Główne API używane przez frontend opiera się wyłącznie na nagłówku `Authorization` z JWT, więc podczas standardowego korzystania ze strony nie są ustawiane żadne marketingowe ani analityczne cookies.

## Czy potrzebny jest baner cookie?
- Obecnie aplikacja korzysta wyłącznie z ewentualnych plików cookie niezbędnych do bezpieczeństwa (CSRF, sesja administracyjna). Brak śledzących/analitycznych plików cookie oraz brak zapisywania tokenów w cookies po stronie użytkownika.
- W związku z tym nie ma obowiązku wyświetlania baneru zgody na cookies marketingowe/analityczne. Jeśli chcemy poinformować użytkownika o technicznych cookies (`csrftoken`/`sessionid`), wystarczy krótka notyfikacja lub wzmianka w polityce prywatności zamiast rozbudowanego baneru.

## Rekomendacje
- Jeśli w przyszłości zostaną dodane narzędzia analityczne (np. Google Analytics) lub reklamy, konieczne będzie wdrożenie pełnego baneru zgody i zarządzania preferencjami.
- Warto uzupełnić treść polityki prywatności o informacje o ewentualnym pliku `csrftoken` i `sessionid` używanym wyłącznie w celach bezpieczeństwa/administracyjnych.
