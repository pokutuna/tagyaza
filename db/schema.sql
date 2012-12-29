DROP TABLE IF EXISTS cards;
CREATE TABLE cards (
  id integer PRIMARY KEY AUTOINCREMENT,
  set_code text,
  set_no integer,
  name_eng text,
  name_jpn text,
  rarelity text,
  UNIQUE( set_code, set_no )
);

DROP INDEX IF EXISTS set_id_rarelity;
CREATE INDEX set_id_rarelity on cards(set_code, rarelity);
