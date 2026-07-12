//Z76689F  JOB (ACCT),'CBL0033',CLASS=A,MSGCLASS=H,
//         NOTIFY=&SYSUID
//*--------------------------------------------------
//* STEP 1: Compile HELLO only (no link yet)
//*--------------------------------------------------
//STEP1    EXEC IGYWC
//COBOL.SYSIN DD DSN=Z76689.CBL(HELLO),DISP=SHR
//COBOL.SYSLIN DD DSN=&&HELLOOBJ,DISP=(,PASS),
//             UNIT=SYSDA,SPACE=(TRK,(1,1)),
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=3200)
//*--------------------------------------------------
//* STEP 2: Compile CBL0033, link with HELLO object, then run
//*--------------------------------------------------
//COBRUN   EXEC IGYWCLG
//COBOL.SYSIN DD DSN=Z76689.CBL(CBL0033),DISP=SHR
//LKED.SYSLIN DD DSN=&&HELLOOBJ,DISP=(OLD,DELETE)
//         DD DDNAME=SYSLIN
//GO.ACCTREC DD DSN=Z76689.DATA,DISP=SHR
//GO.PRTLINE DD SYSOUT=*
//GO.SYSOUT DD SYSOUT=*
