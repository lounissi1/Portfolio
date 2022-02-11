select table_name, column_name, data_Type
from user_tab_columns t
where table_name in ('TRACTEUR','EQUIP','CAMION');