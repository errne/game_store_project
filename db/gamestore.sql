DROP TABLE games;
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

CREATE TABLE games (
  id SERIAL8 primary key,
  name VARCHAR(255) not null,
  developer_id INT4 not null references developers(id),
  publisher_id INT4 references publishers(id),
  description TEXT,
  stock_quantity INT4,
  buying_cost INT4 not null,
  selling_price INT4 not null
)
