DROP TABLE publishers;

CREATE TABLE publishers
(
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  location VARCHAR(255)
);
