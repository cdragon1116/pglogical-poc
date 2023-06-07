-- create database
CREATE DATABASE master_db;
\c master_db;

-- create data
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL
);

CREATE UNIQUE INDEX idx_users_on_email ON users(email);

INSERT INTO users (email, name) VALUES('test1@gmail.com','Jenny');
INSERT INTO users (email, name) VALUES('test2@gmail.com','Andy');
INSERT INTO users (email, name) VALUES('test3@gmail.com','John');

-- create extension
CREATE EXTENSION pglogical;

-- create node
SELECT pglogical.create_node(
  node_name := 'provider',
  dsn := 'host=master_db port=5432 dbname=master_db'
);
