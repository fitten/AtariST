GEMDOS_1			EQU	$01	

GEMDOS_1_Pterm0		EQU	$00		; Terminate Process
GEMDOS_1_Cconin		EQU	$01		; Read character from Standard Input
GEMDOS_1_Cconout	EQU	$02		; Write Character to Standard Output
GEMDOS_1_Cauxin		EQU	$03		; Read Character from Standard AUX:
GEMDOS_1_Cauxout	EQU	$04		; Write Character to Standard AUX:
GEMDOS_1_Cprnout	EQU	$05		; Write Character to Standard PRN:
GEMDOS_1_Crawio		EQU	$06		; Raw I/O to Standard Input/Output
GEMDOS_1_Crawcin	EQU	$07		; Raw Input from Standard Input
GEMDOS_1_Cnecin		EQU	$08		; Read Character from Standard Input, No Echo
GEMDOS_1_Cconws		EQU	$09		; Write String to Standard Output
GEMDOS_1_Cconrs		EQU	$0A		; Read Edited String from Standard Input
GEMDOS_1_Cconis		EQU	$0B		; Check status of Standard Input
GEMDOS_1_Dsetdrv	EQU	$0E		; Set Default Drive
GEMDOS_1_Cconos		EQU	$10		; Check Status of Standard Output
GEMDOS_1_Cprnos		EQU	$11		; Check Status of Standard PRN:
GEMDOS_1_Cauxis		EQU	$12		; Check Status of Standard AUX: Input
GEMDOS_1_Cauxos		EQU	$13		; Check Status of Standard AUX: Output
GEMDOS_1_Dgetdrv	EQU	$19		; Get Default Drive
GEMDOS_1_Fsetdta	EQU	$1A		; Set DTA (Disk Transfer Address)
GEMDOS_1_Super		EQU	$20		; Get/Set/Inquire Supervisor Mode
GEMDOS_1_Tgetdate	EQU	$2A		; Get Date
GEMDOS_1_Tsetdate	EQU	$2B		; Set Date
GEMDOS_1_Tgettime	EQU	$2C		; Get Time
GEMDOS_1_Tsettime	EQU	$2D		; Set Time
GEMDOS_1_Fgetdta	EQU	$2F		; Get DTA (Disk Transfer Address)
GEMDOS_1_Sversion	EQU	$30		; Get Version Number
GEMDOS_1_Ptermres	EQU	$31		; Terminate and Stay Resident
GEMDOS_1_Dfree		EQU	$36		; Get Drive Free Space
GEMDOS_1_Dcreate	EQU	$39		; Create Directory
GEMDOS_1_Ddelete	EQU	$3A		; Delete Directory
GEMDOS_1_Dsetpath	EQU	$3B		; Set Current Directory
GEMDOS_1_Fcreate	EQU	$3C		; Create File
GEMDOS_1_Fopen		EQU	$3D		; Open File
GEMDOS_1_Fclose		EQU	$3E		; Close File
GEMDOS_1_Fread		EQU	$3F		; Read From File
GEMDOS_1_Fwrite		EQU	$40		; Write To File
GEMDOS_1_Fdelete	EQU	$41		; Delete File
GEMDOS_1_Fseek		EQU	$42		; Seek File Pointer
GEMDOS_1_Fattrib	EQU	$43		; Get/Set File Attributes
GEMDOS_1_Fdup		EQU	$45		; Duplicate File Handle
GEMDOS_1_Fforce		EQU	$46		; Force File Handle
GEMDOS_1_Dgetpath	EQU	$47		; Get Current Directory
GEMDOS_1_Malloc		EQU	$48		; Allocate Memory
GEMDOS_1_Mfree		EQU	$49		; Release Memory
GEMDOS_1_Mshrink	EQU	$4A		; Shrink Size of Allocated Block
GEMDOS_1_Pexec		EQU	$4B		; Load/Execute Process
GEMDOS_1_Pterm		EQU	$4C		; Terminate Process
GEMDOS_1_Fsfirst	EQU	$4E		; Search First
GEMDOS_1_Fsnext		EQU	$4F		; Search Next
GEMDOS_1_Frename	EQU	$56		; Rename File
GEMDOS_1_Fdatime	EQU	$57		; Get/Set File Timestamp 