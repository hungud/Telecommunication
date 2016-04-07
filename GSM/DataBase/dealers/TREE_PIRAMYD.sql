DROP TABLE TREE_PIRAMYD CASCADE CONSTRAINTS;

CREATE TABLE TREE_PIRAMYD
(
  MANAGER_GUID  VARCHAR2(50 char),
  MANAG_NAME    VARCHAR2(50 CHAR),
  RELATION_KEY  INTEGER,
  N_ROW         INTEGER,
  TAX           NUMBER,
  BONUS         NUMBER,
  DATE_BONUS    DATE,
  DATE_LOAD     DATE,
  LEVEL_TREE    INTEGER
);


COMMENT ON COLUMN TREE_PIRAMYD.MANAGER_GUID IS 'GUID менеджера';

COMMENT ON COLUMN TREE_PIRAMYD.N_ROW IS 'НОМЕР СТРОКИ, ИСПОЛЬЗУЕТСЯ В КАЧЕСТВЕ КЛЮЧА';

COMMENT ON COLUMN TREE_PIRAMYD.MANAG_NAME IS 'Имя Менеджера';

COMMENT ON COLUMN TREE_PIRAMYD.RELATION_KEY IS 'КЛЮЧ СВЯЗИ С ПРЕДКОМ, УКАЗЫВАЕТ НА НОМЕР СТРОКИ';

COMMENT ON COLUMN TREE_PIRAMYD.TAX IS 'Сумма, заработанная всеми дилерами этого менеджера';
    
COMMENT ON COLUMN TREE_PIRAMYD.BONUS IS 'Бонус, который начислен менеджеру, т.е. текущей записи'; 

COMMENT ON COLUMN TREE_PIRAMYD.LEVEL_TREE IS 'Уровень пирамиды, вычисляется после загрузки для ее отрисовки';

COMMENT ON COLUMN TREE_PIRAMYD.DATE_BONUS IS 'Дата начисления бонуса';

COMMENT ON COLUMN TREE_PIRAMYD.DATE_LOAD IS 'Дата загрузки файла (определяет актуальность)';


