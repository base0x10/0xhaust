;redcode-94nop 
;name The Enemy Within
;author John Metcalf 
;strategy qscan -> paper/stone 
;assert CORESIZE==8000 

        org    qscan 

        spos   equ 3100 
        ppos   equ spos+4222 

warr    spl    2,        <2000     ; 6 parallel processes 
        spl    1,        <2100 
        spl    1,        <2200 

        mov    <sfrom,   {sboot 
sboot   spl    spos,     <2300 
        mov    {papera,  {pboot 
pboot   djn.f  ppos,     <4000 

        step1  equ 4832 
        step2  equ 3416 
        step3  equ 3600 

papera  spl    @papera+6,  {step1 
        mov    }papera,  >papera 
paperb  spl    @paperb,  >step2 
        mov    }paperb,  >paperb 
        mov    {paperb,  <paperc 
paperc  djn.f  @paperc,  >step3 

        gap    equ -12 
        sstep equ 1752 

sfrom   spl    #0,           stone+5 
stone   mov    dbmb,         <hit-sstep 
hit     mov    dbmb,         @stone 
        sub    #sstep,       @hit 
        djn.f  stone,        <3000 
dbmb    dat    <1,           <gap+1+sstep 

        for    51 
        dat    0,0 
        rof 

        qfac   equ 4467 
        qdec   equ -196 

        qa     equ (qfac*(qtab0-1-qptr)+1) 
        qb     equ (qfac*(qtab0-qptr)+1) 
        qc     equ (qfac*(qtab1-1-qptr)+1) 
        qd     equ (qfac*(qtab1-qptr)+1) 
        qe     equ (qfac*(qtab1+1-qptr)+1) 
        qf     equ (qfac*(qtab2-qptr)+1) 

        qtime  equ 18 
        qstep  equ -7 
        qgap   equ 87 

qdecode mul.b  *q1,          qptr 
q0      sne    <qtab0,       @qptr 
q1      add.b  qtab1,        qptr 
q2      mov    qtab2,        @qptr 
qptr    mov    qtab2,        *qdec 
        add    #qstep,       qptr 
        djn    q2,           #qtime 
        jmp    warr,         qc 
qtab1   dat    4000,         qd 
        dat    4000,         qe 

qscan   sne    qptr+qdec*qe, qptr+qdec*qe+qe 
        seq    <qtab1+1,     qptr+qdec*(qe-1)+qe-1 
        jmp    qdecode,      }q1 
        sne    qptr+qdec*qb, qptr+qdec*qb+qd 
        seq    <qtab0,       qptr+qdec*(qb-1)+qd 
        jmp    qdecode,      {qdecode 
        sne    qptr+qdec*qa, qptr+qdec*qa+qd 
        seq    <qtab0-1,     qptr+qdec*(qa-1)+qd 
        djn.a  qdecode,      {qdecode 
        sne    qptr+qdec*qf, qptr+qdec*qf+qd 
        seq    <qtab2,       qptr+qdec*(qf-1)+qd 
        jmp    qdecode,      }qdecode 
        sne    qptr+qdec*qc, qptr+qdec*qc+qc 
        seq    <qtab1-1,     qptr+qdec*(qc-1)+qc-1 
        jmp    qdecode,      {q1 
        sne    qptr+qdec*qd, qptr+qdec*qd+qd 
        seq    <qtab1,       qptr+qdec*(qd-1)+qd-1 
        jmp    qdecode,      qa 
qtab0   jmp    warr,         qb 
qtab2   dat    qgap,         qf 

        end 

