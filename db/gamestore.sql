DROP TABLE publishers;
DROP TABLE developers;

CREATE TABLE publishers
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  location VARCHAR(255)
);

CREATE TABLE developers
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  location VARCHAR(255)
);
