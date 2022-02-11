select *
from camion
where pcamion in (select pcamion
from POSITION
where position.bdisponible = 0);