{
  "database": {
    "create": "CREATE DATABASE database_name;",
    "drop": "DROP DATABASE database_name;",
    "rename": "ALTER DATABASE database_name RENAME TO new_name;"
  },
  "table": {
    "create": "CREATE TABLE table_name();",
    "drop": "DROP TABLE table_name;",
    "rename": "ALTER TABLE table_name RENAME TO new_name;"
  },
  "row": {
    "insert": "INSERT INTO table_name(columns) VALUES(values);",
    "update": "UPDATE table_name SET column_name = new_value WHERE condition;",
    "delete": "DELETE FROM table_name WHERE condition;"
  },
  "column": {
    "add": "ALTER TABLE table_name ADD COLUMN column_name;",
    "drop": "ALTER TABLE table_name DROP COLUMN column_name;",
    "rename": "ALTER TABLE table_name RENAME COLUMN column_name TO new_name;",
    "primary_key": "ALTER TABLE table_name ADD PRIMARY KEY(column_name);",
    "foreign_key": "ALTER TABLE table_name ADD FOREIGN KEY(column_name) REFERENCES table_name(column_name);",
    "unique": "ALTER TABLE table_name ADD CONSTRAINT constraint_name UNIQUE(column_name);",
    "not null": "ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL",
    "initcap": "UPDATE table_name SET column_name=initcap(lower(column_name));"
    "change data type": "ALTER TABLE table_name ALTER COLUMN column_name TYPE new_data_type;",
    "numeric to decimal example": "ALTER TABLE table_name ALTER COLUMN column_name TYPE decimal(5,3);"
    "(5,3) explained": "5 is the full length of number, 3 is the number of digits following the decimal;"
  }
}

--how to properly trim based on research:
--https://stackoverflow.com/questions/72033248/removing-all-the-trailing-zeroes-of-a-numeric-column-in-postgresql
--https://i.stack.imgur.com/ER5V6.png
--periodic_table=> ALTER TABLE properties ALTER COLUMN atomic_mass TYPE decimal;
--ALTER TABLE
--periodic_table=> update properties set atomic_mass=TRIM(TRAILING '0' FROM CAST(atomic_mass as TEXT))::DECIMAL;
--UPDATE 9

-- needed insert statements
-- insert into elements (atomic_number, symbol, name) values(9, 'F', 'Fluorine'), (10, 'Ne', 'Neon');

-- insert into properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) values (9, 'nonmetal', 18.998, -220, -188.1, 3), (10, 'nonmetal', 20.18, -248.6, -246.1, 3);

-- note: don't use echo -e "\n...", this causes tests to fail