
#ifndef DASHARD_H
#define DASHARD_H

#define DHC_SIUDI0				0		// COMMAND
#define DHC_SIUDI1				100		// COMMAND
#define DHC_SIUDI2				200		// COMMAND
#define DHC_SIUDI3				300		// COMMAND
#define DHC_SIUDI4				400		// COMMAND
#define DHC_SIUDI5				500		// COMMAND
#define DHC_SIUDI6				600		// COMMAND
#define DHC_SIUDI7				700		// COMMAND
#define DHC_SIUDI8				800		// COMMAND
#define DHC_SIUDI9				900		// COMMAND

#define DHC_OPEN				1		// COMMAND
#define DHC_CLOSE				2		// COMMAND
#define DHC_DMXOUTOFF			3		// COMMAND
#define DHC_DMXOUT				4		// COMMAND
#define DHC_PORTREAD			5		// COMMAND
#define DHC_PORTCONFIG			6		// COMMAND
#define DHC_VERSION				7		// COMMAND
#define DHC_DMXIN				8		// COMMAND
#define DHC_INIT				9		// COMMAND
#define DHC_EXIT				10		// COMMAND
#define DHC_DMXSCODE			11		// COMMAND
#define DHC_DMX2ENABLE			12		// COMMAND
#define DHC_DMX2OUT				13		// COMMAND
#define DHC_SERIAL				14		// COMMAND
#define DHC_TRANSPORT			15		// COMMAND
#define DHC_DMXENABLE			16		// COMMAND
#define DHC_DMX3ENABLE			17		// COMMAND
#define DHC_DMX3OUT				18		// COMMAND
#define DHC_DMX2IN				19		// COMMAND
#define DHC_DMX3IN				20		// COMMAND

#define DHC_WRITEMEMORY			21		// COMMAND
#define DHC_READMEMORY			22		// COMMAND
#define DHC_SIZEMEMORY			23		// COMMAND



#define DHE_OK					1		// RETURN NO ERROR
#define DHE_NOTHINGTODO			2		// RETURN NO ERROR

#define DHE_ERROR_COMMAND		-1		// RETURN ERROR
#define DHE_ERROR_NOTOPEN		-2		// RETURN ERROR
#define DHE_ERROR_ALREADYOPEN	-12		// RETURN ERROR



typedef struct{
	WORD year;  
	WORD month;  
	WORD dayOfWeek;  
	WORD date;  
	WORD hour;  
	WORD min;  
	WORD sec;  
	WORD milliseconds;
}STIME;


#endif