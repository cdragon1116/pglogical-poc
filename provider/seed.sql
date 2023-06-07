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
INSERT INTO users (email, name) VALUES('test4@gmail.com','John');
