To zadanie jest zmodyfikowaną wersją zadania rekrutacyjnego przedstawionego poniżej i opisanego w języku angielskim. Warto zapoznać się z opisami zarówno wersji polskiej, jak i angielskiej.


# Opis zadania:

Zarządzanie stanem w aplikacji wykonaj korzystając z **BLoC**, wykonaj także testy wykorzystywanych przez Ciebie metod.

Aplikacja korzysta z json_serializable oraz freezed (warto zapoznać się z dokumentacją), dlatego też wygenerowanie odpowiednich klas dla modeli wymaga wpisania polecenia "flutter pub run build_runner build --delete-conflicting-outputs" w terminalu na poziomie projektu.

### Część 1:

Pobierz dane korzystając z MoviesRepository i wyświetl je jako listę na stronie MoviesListScreen. W części pierwszej do wyświetlania listy wykorzystaj widget MovieItemRow, który przyjmuje obiekt MovieItem.

### Część 2:

Stwórz drugi ekran, który będzie wyświetlał tą samą listę, ale wykorzystując inny widget (zaproponuj inny widok karty filmu, inne odstępy, etc., możesz dodać także własne elementy, widok może być pokazany jako lista albo grid - Ty decydujesz).

### Część 3:

Przygotuj przycisk na poziomie menu oraz przycisk na dole strony (jak na przykładzie poniżej), przyciski mają wykonywać tą samą akcję - podmieniać ekran pierwszy na drugi widok (user nie może wykonać akcji cofnięcia strony - strony mają się podmieniać). Ikona jest przykładowa, użyj takiej jaką uznasz za odpowiednią.

![przykład](https://i.ibb.co/r2BdTg6/Zrzut-ekranu-2021-12-16-o-13-41-30.png)


### Część 4:

Przygotuj możliwość kliknięcia w obiekt na każdej liście i po kliknięciu przenieś usera na ekran szczegółów wybranego filmu (zaproponuj widget, który będzie wykorzystany na tym ekranie), tutaj user może wykonać akcję "nie lubię" (wybierz czy będzie to ikonka, czy przycisk) i po kliknięciu akcji, z listy ma zniknąć ten konkretny film (w tym zadaniu na ten moment chodzi tylko o odświeżenie listy, nie wysyłasz żadnych zapytań, po ponownym odpaleniu aplikacji user ponownie będzie widział całą listę).




# Flutter recruitment task

This task is aimed to check your knowledge about Flutter app development and testing.

### Task description
Your goal is to get data from the `MoviesRepository` and display a list of movies in the `MoviesListScreen`. 
For widget list item you can use the `MovieItemRow` which accepts an instance of fetched list item model `MovieItem`.

### Json serialization and Freezed
Application uses [json serializable plugin](https://pub.dev/packages/json_serializable) and [freezed](https://pub.dev/packages/freezed), so in order to generate models and its serializers run `flutter pub run build_runner build --delete-conflicting-outputs` command in terminal.

### Strings localization
Application uses [Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl) to generate localized strings resources.

### Finished app screenshot

![Screenshot1](https://raw.githubusercontent.com/netguru/flutter-recruitment-task/master/previews/Screenshot_1.png)

