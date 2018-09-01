#!/bin/bash

system "CPYFRMSTMF FROMSTMF\(\'/home/sndgmail/bin/sndgmai.cmd\'\) TOMBR\(\'/QSYS.LIB/QGPL.LIB/QCMDSRC.FILE/SNDGMAIL.MBR\'\) MBROPT\(*REPLACE\)"                         
system "CRTCMD CMD(QGPL/SNDGMAIL) PGM(QGPL/SNDGMAIL)  SRCFILE(QGPL/QCMDSRC) "  

