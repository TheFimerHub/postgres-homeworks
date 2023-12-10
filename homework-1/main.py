import csv
import psycopg2  # type: ignore


def connect():
    try:
        connection = psycopg2.connect(
            host="localhost",
            database="north",
            user="postgres",
            password="minilam123"
        )
        return connection
    except psycopg2.Error as e:
        print("Невозможно подключиться к базе данных")
        print(e)
        return None

def fill_tables(connection):
    try:
        cursor = connection.cursor()

        # Заполнение employees из CSV
        with open('north_data/employees_data.csv', 'r') as file:
            reader = csv.reader(file)
            next(reader)  # Пропустить заголовок
            for row in reader:
                print(row)
                cursor.execute(
                    "INSERT INTO employees (first_name, last_name, title, birth_date, notes) VALUES (%s, %s, %s, %s, %s)",
                    (row[1], row[2], row[3], row[4], row[5]))

        # Заполнение customers из CSV
        with open('north_data/customers_data.csv', 'r') as file:
            reader = csv.reader(file)
            next(reader)  # Пропустить заголовок
            for row in reader:
                print(row)
                cursor.execute("INSERT INTO customers (customer_id, company_name, contact_name) VALUES (%s, %s, %s)",
                               (row[0], row[1], row[2]))

        # Заполнение orders из CSV
        with open('north_data/orders_data.csv', 'r') as file:
            reader = csv.reader(file)
            next(reader)  # Пропустить заголовок
            for row in reader:
                print(row)
                cursor.execute(
                    "INSERT INTO orders (order_id, customer_id, employee_id, order_date, ship_city) VALUES (%s, %s, %s, %s, %s)",
                    (row[0], row[1], row[2], row[3], row[4]))

        connection.commit()
        cursor.close()

    except psycopg2.Error as e:
        print("Error filling tables")
        print(e)


# def create_tables(connection):
#     try:
#         cursor = connection.cursor()
#         create_tables_sql = ...
#         cursor.execute(create_tables_sql)
#         connection.commit()
#         cursor.close()
#     except psycopg2.Error as e:
#         print("Ошибка создании таблицы")
#         print(e)


def main():
    connection = connect()

    if connection:
        fill_tables(connection)

        connection.close()


if __name__ == "__main__":
    main()
