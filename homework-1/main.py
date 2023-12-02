"""Скрипт для заполнения данными таблиц в БД Postgres."""
import csv
import os

import psycopg2


def read_csv(file_path: str) -> list:
    """
    Получение данных из файла .csv.
    Создание на основе полученных данных экземпляров класса.
    Добавление экземпляров класса в список объектов класса.
    :param file_path: Полное имя файла, str.
    :return: Список кортежей данных, хранящихся в файле, list.
    """
    try:
        read_list = []
        with open(file_path, mode='r', encoding='utf-8', newline='') as csvfile:
            reader = csv.reader(csvfile)
            for row in reader:
                read_list.append(tuple(row))
            return read_list
    except FileNotFoundError:
        raise FileNotFoundError(f'Отсутствует файл {file_path}.')


if __name__ == '__main__':
    # Список таблиц
    table_list = ['customers', 'employees', 'orders']

    # Подключаемся к базе данных
    conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='000000')
    try:
        with conn:
            with conn.cursor() as cur:
                # Заполняем таблицы БД данными из .csv файлов
                for name_table in table_list:
                    # Получаем список кортежей данных из файла (заголовки не берём)
                    tab_csv = read_csv(os.path.join('north_data', name_table + '_data.csv'))[1:]
                    # Формируем SQL-команду для заполнения таблицы
                    database_request = f"INSERT INTO {name_table} VALUES ({', '.join(['%s']*len(tab_csv[0]))})"
                    # Заполняем текущую таблицу
                    cur.executemany(database_request, tab_csv)
    finally:
        conn.close()
