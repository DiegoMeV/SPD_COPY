SELECT * FROM sectores_dnp;

SELECT sector, nombre
FROM   sectores_dnp;

SELECT * FROM programas_dnp;

CREATE TABLE tmp_product_catalog (
    id   number,
    code  varchar2(20),
    name varchar2(200),
    description varchar2(1000));
    
    ALTER TABLE tmp_product_catalog ADD parent_id number;
    ALTER TABLE tmp_product_catalog MODIFY name VARCHAR2(400);
    
INSERT INTO tmp_product_catalog (id, code, name)
SELECT rownum, sector, nombre
FROM   sectores_dnp;

INSERT INTO tmp_product_catalog (id, code, name, parent_id)
SELECT rownum + 31, p.programa, p.nombre, tp.id
FROM   sectores_dnp s
JOIN   programas_dnp p ON p.sector = s.sector
JOIN   tmp_product_catalog tp ON tp.code = s.sector;

SELECT * FROM productos_pry;

SELECT COUNT(1) FROM tmp_product_catalog;

SELECT * FROM tmp_product_catalog WHERE id = 121;
SELECT * FROM tmp_product_catalog WHERE parent_id = 121;

SELECT * FROM productos_pry
WHERE codigo = '3299057';

INSERT INTO tmp_product_catalog (id, code, name, description, parent_id)
SELECT rownum + 202, pp.codigo, pp.nombre, pp.descripcion, tp.id
FROM   programas_dnp p
JOIN   productos_pry pp ON pp.programa = p.programa
JOIN   tmp_product_catalog tp ON tp.code = p.programa;

SELECT * FROM tmp_product_catalog;


DELETE FROM tmp_product_catalog;

