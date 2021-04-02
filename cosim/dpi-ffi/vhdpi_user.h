/* vhdpi_user.h for use with the VHDL Direct Programming Interface*/
/* Peter Flake 2021 03 18 */

/* Conditional compilation symbols as defined in LRM 24.2.2 */
#define VHDL_VERSION
#define TOOL_TYPE
#define TOOL_VENDOR
#define TOOL_NAME
#define TOOL_EDITION
#define TOOL_VERSION

/* array parameter access – “fat pointer” contains bounds info */
/* One dimensional arrays */
int vhGetVecSize (void* array);
int vhGetVecLeft (void* array);
int vhGetVecRight (void* array);
int vhGetVecLow (void* array);
int vhGetVecHigh (void* array);
int vhGetVecIncrement (void* array); /*+1 to, -1 downto*/
/* One dimensional array access */
int vhGetBitVecElement (void* vec, int index); /* single bit */
int vhGetBitVecSlice (void* vec, int left, int right); /* up to 32 bits */
void vhPutBitVecElement (int value, void* vec, int index); /* single bit */
void vhPutBitVecSlice (int value, void* vec, int left, int right); /* up to 32 bits */
int vhGetStdLogicVecElement (void* vec, int index);
void vhPutStdLogicVecElement (int value, void* vec, int index);
int vhGetIntegerVecElement (void* vec, int index);
void vhPutIntegerVecElement (int value, void* vec, int index);
int vhGetRealVecElement (void* vec, int index);
void vhPutRealVecElement (int value, void* vec, int index);
void* vhGetVecElementPtr (void* vec, int index); /* other data types */
/* Multi-dimensional arrays */
int vhGetNumDimensions (void* array);
int vhGetArraySize (void* array, int dimension);
int vhGetArrayLeft (void* array, int dimension);
int vhGetArrayRight (void* array, int dimension);
int vhGetArrayLow (void* array, int dimension);
int vhGetArrayHigh (void* array, int dimension);
int vhGetArrayIncrement (void* array, int dimension); /*+1 to, -1 downto*/
/* Multi-dimensional array access */
void vhGetBitArrayElement (int value, void* array, int dimensions, int index1, int index2, …);
void vhPutBitArrayElement (int value, void* array, int dimensions, int index1, int index2, …);
int vhGetStdLogicArrayElement (int value, void* array, int dimensions, int index1, int index2, …);
void vhPutStdLogicArrayElement (int value, void* array, int dimensions, int index1, int index2, …);
int vhGetIntegerArrayElement (int value, void* array, int dimensions, int index1, int index2, …);
void vhPutIntegerArrayElement (int value, void* array, int dimensions, int index1, int index2, …);
int vhGetRealArrayElement (int value, void* array, int dimensions, int index1, int index2, …);
void vhPutRealVecElement (int value, void* array, int dimensions, int index1, int index2, …);
void* vhGetArrayElementPtr(void* array, int dimensions, int index1, int index2, … ); /* other data types */

/* DPI instantiated scope (region) */
typedef void* vhInstantiatedScope;
/* Get current scope */
vhInstantiatedScope vhGetInstantiatedScope (void);
/* Change scope, returns old scope */
vhInstantiatedScope vhSetInstantiatedScope (vhInstantiatedScope newScope);
/* returns path name of scope */
vhGetNameFromScope (vhInstantiatedScope);
/* returns scope from path name */
vhGetScopeFromName (char* scopeName);
/* Sets file name and line number of import call, else returns 0 */
int vhGetCallerInfo (char** fileName, int* lineNumber);
