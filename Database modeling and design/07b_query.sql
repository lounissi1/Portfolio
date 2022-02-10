-- 07b_query.sql

create or replace
procedure reset_seq( p_seq_name in varchar2 )
is
    l_val number;
begin
    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by -' || l_val || 
                                                          ' minvalue 0';

    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by 2 minvalue 0';
end;
/



EXECUTE reset_seq('SEQ_ROUTE');
EXECUTE reset_seq('SEQ_CAMION');
EXECUTE reset_seq('SEQ_CARBURANT');
EXECUTE reset_seq('SEQ_CHARGEMENT');
EXECUTE reset_seq('SEQ_CLIENT');
EXECUTE reset_seq('SEQ_COMMANDED');
EXECUTE reset_seq('SEQ_COMMANDEE');
EXECUTE reset_seq('SEQ_COMPAGNIE');
EXECUTE reset_seq('SEQ_EQUIPEMENT');
EXECUTE reset_seq('SEQ_POSITION');
EXECUTE reset_seq('SEQ_SOUMISSIOND');
EXECUTE reset_seq('SEQ_SOUMISSIONE');
EXECUTE reset_seq('SEQ_TRACTEUR');
EXECUTE reset_seq('SEQ_TYPEEQUIPEMENT');


-- select SEQUENCE_NAME,MIN_VALUE,MAX_VALUE,INCREMENT_BY,CACHE_SIZE,CYCLE_FLAG from user_sequences;
