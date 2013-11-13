; generated by lcc-xr18ng $Version: 2.3 - XR18NG - The Birthday Compiler $ on Wed Feb 27 14:03:11 2013

SP:	equ	2 ;stack pointer
memAddr: equ	14
retAddr: equ	6
retVal:	equ	15
regArg1: equ	12
regArg2: equ	13
	listing off
	include lcc1802ProloNG.inc
	listing on
_main:
	reserve 4
;{
;	printstr("hello World!\n");
	ldaD R12,L2
	Ccall _printstr
;}
L1:
	release 4
	Cretn

_strcpy:
	reserve 2
;{
;	char *save = to;
	st2 R12,'O',sp,(-4+4); ASGNP2
;	for (; (*to = *from) != 0; ++from, ++to);
	lbr L7
L4:
L5:
	ldaD R11,1
	alu2 R13,R13,R11,add,adc
	alu2 R12,R12,R11,add,adc
L7:
	ld1 R11,'O',R13,0
	st1 R11,'O',R12,0; ASGNU1
	cpy1 R11,R11
	zExt 11 ;CVUI2: widen unsigned char to signed int (zero extend)
	jneU2I r11,0,L4; NE
;	return(save);
	ld2 R15,'O',sp,(-4+4)
L3:
	release 2
	Cretn

_printstr:
	reserve 6
	alu2I memaddr,sp,(5),adi,adci
	sex	memaddr
	savmi r7
	sex sp
	cpy2 r7,r12; function(2055) 1
;void printstr(char *ptr){
	lbr L10
L9:
;    while(*ptr) out(5,*ptr++);
	ldaD R12,5
	cpy2 R11,R7
	ldA2 R7,'O',R11,(1); reg:addr
	ld1 R13,'O',R11,0
	zExt R13 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _out
L10:
	ld1 R11,'O',R7,0
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	jneU2I r11,0,L9; NE
;}
L8:
	alu2I memaddr,sp,(4),adi,adci
	rldmi r7,memaddr
	release 6
	Cretn

_itoa:
	reserve 14
	alu2I memaddr,sp,(9),adi,adci
	sex	memaddr
	savmi r0
	savmi r1
	savmi r7
	sex sp
	st2 r12,'O',sp,(16); flag1 
	st2 r13,'O',sp,(18); flag1 
;char * itoa(int s, char *buffer){ //convert an integer to printable ascii in a buffer supplied by the caller
;	unsigned int flag=0;
	ld2z R11
	st2 R11,'O',sp,(-4+16); ASGNU2(addr,reg)
;	char * bptr; bptr=buffer;
	ld2 R11,'O',sp,(2+16)
	st2 R11,'O',sp,(-6+16); ASGNP2
;	if (s<0){
	ld2 R11,'O',sp,(0+16)
	jcI2I r11,0,lbdf,L13; GE is flipped test from LT
;		*bptr='-';bptr++;
	ld2 R11,'O',sp,(-6+16)
	ldaD R10,45
	st1 R10,'O',R11,0; ASGNU1
	ld2 R11,'O',sp,(-6+16)
	ldA2 R11,'O',R11,(1); reg:addr
	st2 R11,'O',sp,(-6+16); ASGNP2
;		n=-s;
	ld2 R11,'O',sp,(0+16)
	negI2 R11,R11 ;was alu2I R11,R11,0,sdi,sdbi
	cpy2 R1,R11
;	} else{
	lbr L14
L13:
;		n=s;
	ld2 R11,'O',sp,(0+16)
	cpy2 R1,R11
;	}
L14:
;	k=10000;
	ldaD R7,10000
	lbr L16
L15:
;	while(k>0){
;		for(r=0;k<=n;r++,n-=k); // was r=n/k
	ld2z R0
	lbr L21
L18:
L19:
	inc R0
	alu2 R1,R1,R7,sm,smb
L21:
	jcU2 r1,r7,lbdf,L18 ;LE is flipped test & operands
;		if (flag || r>0||k==1){
	ld2z R11
	ld2 R10,'O',sp,(-4+16); INDIRU2(addr)
	jneU2 r10,r11,L25; NE
	jneU2 r0,r11,L25; NE
	jneU2I r7,1,L22; NE
L25:
;			*bptr=('0'+r);bptr++;
	ld2 R11,'O',sp,(-6+16)
	ldA2 R10,'O',R0,(48); reg:addr
	st1 R10,'O',R11,0; ASGNU1
	ld2 R11,'O',sp,(-6+16)
	ldA2 R11,'O',R11,(1); reg:addr
	st2 R11,'O',sp,(-6+16); ASGNP2
;			flag='y';
	ldaD R11,121
	st2 R11,'O',sp,(-4+16); ASGNU2(addr,reg)
;		}
L22:
;		k=k/10;
	cpy2 R12,R7
	ldaD R13,10
	Ccall _divu2
	cpy2 R7,R15
;	}
L16:
;	while(k>0){
	jnzU2 r7,L15; NE 0
;	*bptr='\0';
	ld2 R11,'O',sp,(-6+16)
	ldaD R10,0
	st1 R10,'O',R11,0; ASGNU1
;	return buffer;
	ld2 R15,'O',sp,(2+16)
L12:
	alu2I memaddr,sp,(4),adi,adci
	rldmi r7,memaddr
	rldmi r1,memaddr
	rldmi r0,memaddr
	release 14
	Cretn

_ltoa:
	reserve 12
	alu2I memaddr,sp,(11),adi,adci
	sex	memaddr
	savmi r0
	savmi r1
	savmi r7
	sex sp
	cpy4 RL0,RL12; halfbaked
;char * ltoa(long s, char *buffer){ //convert a long integer to printable ascii in a buffer supplied by the caller
;	char* bptr=buffer;
	ld2 R7,'O',sp,(4+14)
;	if (s<0){
	ldI4 RL10,0 ;loading a long integer constant
	jcI4 RL0,RL10,lbdf,L27; GE is flipped test from LT
;		*bptr++='-';
	cpy2 R11,R7
	ldA2 R7,'O',R11,(1); reg:addr
	ldaD R10,45
	st1 R10,'O',R11,0; ASGNU1
;		s=-s;
	negI4 RL0,RL0 ;was alu4I RL0,RL0,0,sdi,sdbi
;	}
L27:
;	strcpy(bptr,dubdabx(s,bptr)); //uses assembler double-dabble routine
	cpy4 Rp1p2,RL0; LOADI4*
	st2 r7,'O',sp,(4); arg+f**
	Ccall _dubdabx
	cpy2 R11,R15
	cpy2 R12,R7
	cpy2 R13,R11
	Ccall _strcpy
;	return buffer;
	ld2 R15,'O',sp,(4+14)
L26:
	alu2I memaddr,sp,(6),adi,adci
	rldmi r7,memaddr
	rldmi r1,memaddr
	rldmi r0,memaddr
	release 12
	Cretn

_printint:
	reserve 12
	st2 r12,'O',sp,(14); flag1 
;void printint(int s){ //print an integer
;	itoa(s,buffer);
	ld2 R12,'O',sp,(0+14)
	ldA2 R13,'O',sp,(-10+14); reg:addr
	Ccall _itoa
;	printstr(buffer);
	ldA2 R12,'O',sp,(-10+14); reg:addr
	Ccall _printstr
;}
L29:
	release 12
	Cretn

_printlint:
	reserve 18
	st2 r12,'O',sp,(20); flag1 
	st2 r13,'O',sp,(22); flag1 
;void printlint(long s){ //print a long integer
;	printstr(ltoa(s,buffer));
	ld4 Rp1p2,'O',sp,(0+20)
	ldA2 R11,'O',sp,(-14+20); reg:addr
	st2 r11,'O',sp,(4); arg+f**
	Ccall _ltoa
	cpy2 R11,R15
	cpy2 R12,R11
	Ccall _printstr
;}
L30:
	release 18
	Cretn

_putxn:
	reserve 4
	st2 r12,'O',sp,(6); flag1 
	ld2 R11,'O',sp,(0+6)
	st1 R11,'O',sp,(0+6); ASGNU1
;void putxn(unsigned char x){ //print a nibble as ascii hex
;	if (x<10){
	ld1 R11,'O',sp,(0+6)
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	jcI2I r11,10,lbdf,L32; GE is flipped test from LT
;		putc(x+'0');
	ld1 R11,'O',sp,(0+6)
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	ldA2 R11,'O',R11,(48); reg:addr
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putc
;	} else {
	lbr L33
L32:
;		putc(x+'A'-10);
	ld1 R11,'O',sp,(0+6)
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	ldA2 R11,'O',R11,(65); reg:addr
	alu2I R11,R11,10,smi,smbi
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putc
;	}
L33:
;}
L31:
	release 4
	Cretn

_putx:
	reserve 4
	st2 r12,'O',sp,(6); flag1 
	ld2 R11,'O',sp,(0+6)
	st1 R11,'O',sp,(0+6); ASGNU1
;void putx(unsigned char x){ //print a unsigned char as ascii hex
;	putxn(x>>4);
	ld1 R11,'O',sp,(0+6)
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	shrI2I R11,4
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putxn
;	putxn(x & 0x0F);
	ld1 R11,'O',sp,(0+6)
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	alu2I R11,R11,15,ani,ani
	;removed ?	cpy2 R11,R11
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putxn
;}
L34:
	release 4
	Cretn

_printf:
	reserve 14
	alu2I memaddr,sp,(9),adi,adci
	sex	memaddr
	savmi r0
	savmi r1
	savmi r7
	sex sp
	st2 r12,'O',sp,(16); flag1 
	st2 r13,'O',sp,(18); flag2
;void printf(char *ptr,...){ //limited implementation of printf
;	int argslot=0;	//used to align longs
	ldaD R0,0
;	int * this=(int *)&ptr;
	ldA2 R1,'O',sp,(0+16); reg:addr
;	this++; argslot++; //advance argument pointer and slot #
	ldA2 R1,'O',R1,(2); reg:addr
	ldA2 R0,'O',R0,(1); reg:addr
	lbr L37
L36:
;    while(*ptr) {
;		c=*ptr++;
	ld2 R11,'O',sp,(0+16)
	ldA2 R10,'O',R11,(1); reg:addr
	st2 R10,'O',sp,(0+16); ASGNP2
	ld1 R7,'O',R11,0
;		if (c!='%'){
	cpy1 R11,R7
	zExt 11 ;CVUI2: widen unsigned char to signed int (zero extend)
	jeqU2I r11,37,L39
;			putc(c);
	cpy1 R12,R7
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putc
;		} else{
	lbr L40
L39:
;			c=*ptr++;
	ld2 R11,'O',sp,(0+16)
	ldA2 R10,'O',R11,(1); reg:addr
	st2 R10,'O',sp,(0+16); ASGNP2
	ld1 R7,'O',R11,0
;			switch (c){
	cpy1 R11,R7
	zExt 11 ;CVUI2: widen unsigned char to signed int (zero extend)
	st2 R11,'O',sp,(-5+16)
	ld2 R11,'O',sp,(-5+16)
	jeqU2I r11,105,L44
	ldaD R10,108
	jeqI2 r11,r10,L48
	jcI2 r10,r11,lbnf,L56 ;GT is reversed operands from LT
L55:
	ld2 R11,'O',sp,(-5+16)
	ldaD R10,88
	jeqI2 r11,r10,L47
	jcI2 r11,r10,lbnf,L41; LT=lbnf i.e. subtract B from A and jump if borrow 
L57:
	ld2 R11,'O',sp,(-5+16)
	jeqU2I r11,99,L46
	jeqU2I r11,100,L44
	lbr L41
L56:
	ld2 R11,'O',sp,(-5+16)
	ldaD R10,115
	jeqI2 r11,r10,L45
	jcI2 r11,r10,lbnf,L41; LT=lbnf i.e. subtract B from A and jump if borrow 
L58:
	ld2 R11,'O',sp,(-5+16)
	jeqU2I r11,120,L47
	lbr L41
L44:
;					printint(*this++);
	cpy2 R11,R1
	ldA2 R1,'O',R11,(2); reg:addr
	ld2 R12,'O',R11,0
	Ccall _printint
;					argslot+=1; //next argument slot
	ldA2 R0,'O',R0,(1); reg:addr
;					break;
	lbr L42
L45:
;					printstr((char*) *this++);
	cpy2 R11,R1
	ldA2 R1,'O',R11,(2); reg:addr
	ld2 R11,'O',R11,0
	cpy2 R12,R11
	Ccall _printstr
;					argslot+=1; //next argument slot
	ldA2 R0,'O',R0,(1); reg:addr
;					break;
	lbr L42
L46:
;					putc((unsigned int) *this++);
	cpy2 R11,R1
	ldA2 R1,'O',R11,(2); reg:addr
	ld2 R11,'O',R11,0
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putc
;					argslot+=1; //next argument slot
	ldA2 R0,'O',R0,(1); reg:addr
;					break;
	lbr L42
L47:
;					putx(((unsigned int) *this)>>8);
	ld2 R11,'O',R1,0
	shrU2I R11,8
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putx
;					putx(((unsigned int) *this++)&255);
	cpy2 R11,R1
	ldA2 R1,'O',R11,(2); reg:addr
	ld2 R11,'O',R11,0
	alu2I R11,R11,255,ani,ani ;removed copy;BANDU2(reg,con)  
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putx
;					argslot+=1; //next argument slot
	ldA2 R0,'O',R0,(1); reg:addr
;					break;
	lbr L42
L48:
;					if (*ptr){ //as long as there's something there
	ld2 R11,'O',sp,(0+16)
	ld1 R11,'O',R11,0
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	jeqU2I r11,0,L49
;						xord=*ptr++;
	ld2 R11,'O',sp,(0+16)
	ldA2 R10,'O',R11,(1); reg:addr
	st2 R10,'O',sp,(0+16); ASGNP2
	ld1 R11,'O',R11,0
	st1 R11,'O',sp,(-3+16); ASGNU1
;						if (argslot&1) {
	alu2I R11,R0,1,ani,ani
	;removed ?	cpy2 R11,R0
	jeqU2I r11,0,L51
;							this++;
	ldA2 R1,'O',R1,(2); reg:addr
;							argslot++;
	ldA2 R0,'O',R0,(1); reg:addr
;						}
L51:
;						if(xord=='d'){
	ld1 R11,'O',sp,(-3+16)
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	jneU2I r11,100,L53; NE
;							printlint(*(long *)this);//treats "this" as a pointer to long
	ld4 Rp1p2,'O',R1,0
	Ccall _printlint
;							this+=2;				// and advances it 4 bytes
	ldA2 R1,'O',R1,(4); reg:addr
;						} else{
	lbr L54
L53:
;							putx(((unsigned int) *this)>>8);
	ld2 R11,'O',R1,0
	shrU2I R11,8
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putx
;							putx(((unsigned int) *this++)&255);
	cpy2 R11,R1
	ldA2 R1,'O',R11,(2); reg:addr
	ld2 R11,'O',R11,0
	alu2I R11,R11,255,ani,ani ;removed copy;BANDU2(reg,con)  
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putx
;							putx(((unsigned int) *this)>>8);
	ld2 R11,'O',R1,0
	shrU2I R11,8
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putx
;							putx(((unsigned int) *this++)&255);
	cpy2 R11,R1
	ldA2 R1,'O',R11,(2); reg:addr
	ld2 R11,'O',R11,0
	alu2I R11,R11,255,ani,ani ;removed copy;BANDU2(reg,con)  
	cpy1 R12,R11
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putx
;						}
L54:
;						argslot+=2;
	ldA2 R0,'O',R0,(2); reg:addr
;						break;
	lbr L42
L49:
L41:
;					putc('%');putc(c);
	ldaD R12,37
	Ccall _putc
	cpy1 R12,R7
	zExt 12 ;CVUI2: widen unsigned char to signed int (zero extend)
	Ccall _putc
;			} //switch
L42:
;		} //%
L40:
;	} //while
L37:
;    while(*ptr) {
	ld2 R11,'O',sp,(0+16)
	ld1 R11,'O',R11,0
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	jneU2I r11,0,L36; NE
;} //prtf
L35:
	alu2I memaddr,sp,(4),adi,adci
	rldmi r7,memaddr
	rldmi r1,memaddr
	rldmi r0,memaddr
	release 14
	Cretn

_exit:
	reserve 4
	st2 r12,'O',sp,(6); flag1 
;void exit(int code){
;	printf("exit %d\n",code);
	ldaD R12,L60
	ld2 R13,'O',sp,(0+6)
	Ccall _printf
L61:
;	while(1);
L62:
	lbr L61
;}
L59:
	release 4
	Cretn

_memcmp:
	reserve 8
	alu2I memaddr,sp,(5),adi,adci
	sex	memaddr
	savmi r0
	savmi r1
	savmi r7
	sex sp
	ld2 R7,'O',sp,(4+10); INDIRU2(addr)
;int memcmp(const void *Ptr1, const void *Ptr2, unsigned int Count){
;    int v = 0;
	ldaD R1,0
;    p1 = (unsigned char *)Ptr1;
	cpy2 R0,R12
;    p2 = (unsigned char *)Ptr2;
	st2 R13,'O',sp,(-4+10); ASGNP2
	lbr L66
L65:
;    while(Count-- > 0 && v == 0) {
;        v = *(p1++) - *(p2++);
	cpy2 R11,R0
	ldaD R10,1
	alu2 R0,R11,R10,add,adc
	ld2 R9,'O',sp,(-4+10)
	alu2 R10,R9,R10,add,adc
	st2 R10,'O',sp,(-4+10); ASGNP2
	ld1 R11,'O',R11,0
	zExt R11 ;CVUI2: widen unsigned char to signed int (zero extend)
	ld1 R10,'O',R9,0
	zExt R10 ;CVUI2: widen unsigned char to signed int (zero extend)
	alu2 R1,R11,R10,sm,smb
;    }
L66:
;    while(Count-- > 0 && v == 0) {
	cpy2 R11,R7
	alu2I R7,R11,1,smi,smbi
	jeqU2I r11,0,L68
	jeqU2I r1,0,L65
L68:
;    return v;
	cpy2 R15,R1 ;LOADI2
L64:
	alu2I memaddr,sp,(0),adi,adci
	rldmi r7,memaddr
	rldmi r1,memaddr
	rldmi r0,memaddr
	release 8
	Cretn

_memcpy:
	reserve 6
	alu2I memaddr,sp,(5),adi,adci
	sex	memaddr
	savmi r0
	savmi r1
	savmi r7
	sex sp
	ld2 R7,'O',sp,(4+8); INDIRU2(addr)
;void* memcpy(void* dest, const void* src, unsigned int count) {
;        char* dst8 = (char*)dest;
	cpy2 R1,R12
;        char* src8 = (char*)src;
	cpy2 R0,R13
	lbr L71
L70:
;        while (count--) {
;            *dst8++ = *src8++;
	cpy2 R11,R1
	ldaD R10,1
	alu2 R1,R11,R10,add,adc
	cpy2 R9,R0
	alu2 R0,R9,R10,add,adc
	ld1 R10,'O',R9,0
	st1 R10,'O',R11,0; ASGNU1
;        }
L71:
;        while (count--) {
	cpy2 R11,R7
	alu2I R7,R11,1,smi,smbi
	jnzU2 r11,L70; NE 0
;        return dest;
	cpy2 R15,R12
L69:
	alu2I memaddr,sp,(0),adi,adci
	rldmi r7,memaddr
	rldmi r1,memaddr
	rldmi r0,memaddr
	release 6
	Cretn

_memset:
	reserve 4
	alu2I memaddr,sp,(3),adi,adci
	sex	memaddr
	savmi r1
	savmi r7
	sex sp
	ld2 R7,'O',sp,(4+6); INDIRU2(addr)
;{
;    unsigned char* p=s;
	cpy2 R1,R12
	lbr L75
L74:
;        *p++ = (unsigned char)c;
	cpy2 R11,R1
	ldA2 R1,'O',R11,(1); reg:addr
	cpy2 R10,R13
	st1 R10,'O',R11,0; ASGNU1
L75:
;    while(n--)
	cpy2 R11,R7
	alu2I R7,R11,1,smi,smbi
	jnzU2 r11,L74; NE 0
;    return s;
	cpy2 R15,R12
L73:
	alu2I memaddr,sp,(0),adi,adci
	rldmi r7,memaddr
	rldmi r1,memaddr
	release 4
	Cretn

L60:
	db 101
	db 120
	db 105
	db 116
	db 32
	db 37
	db 100
	db 10
	db 0
L2:
	db 104
	db 101
	db 108
	db 108
	db 111
	db 32
	db 87
	db 111
	db 114
	db 108
	db 100
	db 33
	db 10
	db 0
	include lcc1802EpiloNG.inc
	include IO1802.inc
