// Implementation of vhdpi_user.h for GHDL, to be used with the VHDL Direct Programming Interface

/*
* Authors:
*   Peter Flake
*   Unai Martinez-Corral
*
* Copyright 2021 IEEE P1076 WG Authors
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*
* SPDX-License-Identifier: Apache-2.0
*/

/*
* Conditional compilation symbols as defined in LRM 24.2.2
*/

#define VHDL_VERSION
#define TOOL_TYPE
#define TOOL_VENDOR
#define TOOL_NAME
#define TOOL_EDITION
#define TOOL_VERSION

/* array parameter access – “fat pointer” contains bounds info */

/*
* Unconstrained one dimensional arrays
*/

int vhGetVecSize (void* array) {
    return 0;
};

int vhGetVecLeft (void* array) {
    return 0;
};

int vhGetVecRight (void* array) {
    return 0;
};

int vhGetVecLow (void* array) {
    return 0;
};

int vhGetVecHigh (void* array) {
    return 0;
};

int vhGetVecIncrement (void* array) {
    return 0;
}; // +1 to, -1 downto

/*
* Unconstrained one dimensional array access
*/

int vhGetBitVecElement (void* vec, int index) {
    return 0;
}; // single bit

int vhGetBitVecSlice (void* vec, int left, int right) {
    return 0;
}; // up to 32 bits

void vhPutBitVecElement (int value, void* vec, int index) {
    return;
}; // single bit

void vhPutBitVecSlice (int value, void* vec, int left, int right) {
    return;
}; // up to 32 bits

int vhGetStdLogicVecElement (void* vec, int index) {
    return 0;
};

void vhPutStdLogicVecElement (int value, void* vec, int index) {
    return;
};

int vhGetIntegerVecElement (void* vec, int index) {
    return 0;
};

void vhPutIntegerVecElement (int value, void* vec, int index) {
    return;
};

int vhGetRealVecElement (void* vec, int index) {
    return 0;
};

void vhPutRealVecElement (int value, void* vec, int index) {
    return;
};

void* vhGetVecElementPtr (void* vec, int index) {
    return NULL;
}; // other data types

/*
* Unconstrained multi-dimensional arrays
*/

int vhGetNumDimensions (void* array) {
    return 0;
};

int vhGetArraySize (void* array, int dimension) {
    return 0;
};

int vhGetArrayLeft (void* array, int dimension) {
    return 0;
};

int vhGetArrayRight (void* array, int dimension) {
    return 0;
};

int vhGetArrayLow (void* array, int dimension) {
    return 0;
};

int vhGetArrayHigh (void* array, int dimension) {
    return 0;
};

int vhGetArrayIncrement (void* array, int dimension) {
    return 0;
}; // +1 to, -1 downto

/*
* Unconstrained multi-dimensional array access
*/

void vhGetBitArrayElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return;
};

void vhPutBitArrayElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return;
};

int vhGetStdLogicArrayElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return 0;
};

void vhPutStdLogicArrayElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return;
};

int vhGetIntegerArrayElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return 0;
};

void vhPutIntegerArrayElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return;
};

int vhGetRealArrayElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return 0;
};

void vhPutRealVecElement (int value, void* array, int dimensions, int index1, int index2, …) {
    return;
};

void* vhGetArrayElementPtr(void* array, int dimensions, int index1, int index2, … ) {
    return NULL;
}; // other data types

/*
* DPI instantiated scope (region)
*/

typedef void* vhInstantiatedScope;

// Get current scope
vhInstantiatedScope vhGetInstantiatedScope (void) {
    return NULL;
};

// Change scope, returns old scope
vhInstantiatedScope vhSetInstantiatedScope (vhInstantiatedScope newScope) {
    return NULL;
};

// returns path name of scope
char* vhGetNameFromScope (vhInstantiatedScope) {
    return NULL;
};

// returns scope from path name
vhInstantiatedScope vhGetScopeFromName (char* scopeName) {
    return NULL;
};

// Sets file name and line number of import call, else returns 0
int vhGetCallerInfo (char** fileName, int* lineNumber) {
    return 0;
};
