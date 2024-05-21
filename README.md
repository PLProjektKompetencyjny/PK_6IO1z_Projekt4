# TravelNest

Kompletny system do rezerwacji pokoi hotelowych. Składa się z 3 komponentów:

- Frontend - Angular
- Backend - Python (Flask)
- Database - PostgreSQL

# Spis treści

1. [Wymagania](#1-wymagania)
2. [Uruchomienie z użyciem skryptu](#2-uruchomienie-z-użyciem-skryptu)
3. [Uruchomienie z wykorzystaniem komend](#3-uruchomienie-z-wykorzystaniem-komend)

## 1. Wymagania

- Docker Compose

## 2. Uruchomienie z użyciem skryptu

1.  Dodać uprawnienia do wykonywania do pliku `start.sh`

        sudo chmod +x ./start.sh

2.  Uruchomić skrypt

        ./start.sh

3.  `Remove persistent data? [y/n]` <- odpowiada za usuwanie danych bazy SQL.
    Pytanie pojawi się tylko w przypadku gdy katalog danych aplikacji już istnieje

    - `y` <- usuwa całą zawartość bazy danych.
    - `n` <- dane nie zostaną usunięte, a baza danych zostanie uruchomiona bez pełnej inicjalizacji, z zachowaniem starej zawarości.

## 3. Uruchomienie z wykorzystaniem komend

1.  Zatrzymanie obecnie działającego projektu

        docker compose down

2.  Zbudowanie obrazów kontenerów z repozytoriów GitHub

        docker compose build

3.  Uruchomienie projektu

        docker compose up -d --force-recreate

4.  (opcjonalnie) Przed uruchomieniem projektu można usunąć katalog z danymi bazy SQL.

        sudo rm -fr ./APP_DATA
