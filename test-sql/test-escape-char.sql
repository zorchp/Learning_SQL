use t1;

CREATE TABLE test_escape_char
(
    name      varchar(10) NOT NULL
);

INSERT INTO test_escape_char (name) VALUES('/a\b/c');

select *
from test_escape_char;
# /a/c