CREATE TABLE employees
(
    employee_id SERIAL PRIMARY KEY,
    first_name  VARCHAR(64)  NOT NULL,
    last_name   VARCHAR(64)  NOT NULL,
    title       VARCHAR(255) NOT NULL,
    birth_date  DATE,
    notes       TEXT
);

CREATE TABLE customers
(
    customer_id  VARCHAR(5) PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    contact_name VARCHAR(255) NOT NULL
);

CREATE TABLE orders
(
    order_id    SERIAL PRIMARY KEY,
    customer_id VARCHAR(5) NOT NULL,
    employee_id INT        NOT NULL,
    order_date  DATE       NOT NULL,
    ship_city   VARCHAR(255),
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id)
);
