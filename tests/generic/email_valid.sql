{%test is_email_valid(model,column_name)%}

    SELECT {{column_name}} 
    FROM {{model}}
    WHERE {{column_name}} NOT LIKE '%_@__%.__%' AND {{column_name}} IS NOT NULL


{%endtest%}