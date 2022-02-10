
-- 07c_query.sql
-- source : http://www.dba-oracle.com/t_count_rows_all_tables_in_schema.htm

CREATE or REPLACE VIEW v_tables AS
    SELECT
       table_name,
       to_number(
       extractvalue(
          xmltype(
             dbms_xmlgen.getxml('select count(*) c from '||table_name))
        ,'/ROWSET/ROW/C')) nb_lignes
    FROM
       user_tables
    ORDER BY
       table_name;
      
SELECT * FROM v_tables;