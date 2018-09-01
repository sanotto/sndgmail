CMD        PROMPT('Envíar Correo Vía GMAIL')                   
PARM       KWD(TOUSR) TYPE(*CHAR) LEN(50) +                    
             PROMPT('Destinatario')                            
PARM       KWD(SUBJECT) TYPE(*CHAR) LEN(50) PROMPT('Tema')     
PARM       KWD(BODY) TYPE(*CHAR) LEN(255) +                    
             PROMPT('Mensaje')                                 
PARM       KWD(ATTACH) TYPE(*CHAR) LEN(255) +                  
             PROMPT('Path archivo a adjuntar')                 

