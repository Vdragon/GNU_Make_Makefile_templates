# The format of this file is based on GNU_Make_Makefile_templates
# https://github.com/Vdragon/GNU_Make_Makefile_templates
# 變數
# Variables
NAME_PROJECT = 
NAME_TARGET = 
NAME_MODULE = 
POSTFIX_TYPE_SOURCE_CODE_C = c
POSTFIX_TYPE_SOURCE_CODE_CPP = cpp
POSTFIX_TYPE_HEADER_C = h
POSTFIX_TYPE_HEADER_CPP = hpp
POSTFIX_TYPE_OBJECT_CODE = object_code
POSTFIX_TYPE_EXECUTABLE = exe
COMPILER_C = gcc
COMPILER_CPP = g++
DIR_SOURCE_CODE = Source_code
DIR_OBJECT_CODE = Object_code
DIR_BUILD = Build
OPTION_GCC_WITH_DEBUGGING_SYMBOLS = -g
OPTION_GPP_WITH_DEBUGGING_SYMBOLS = ${OPTION_GCC_WITH_DEBUGGING_SYMBOLS}
OPTION_GCC_ONLY_COMPILE = -c
OPTION_GPP_ONLY_COMPILE = ${OPTION_GCC_ONLY_COMPILE}
OPTION_GCC_OUTPUT = -o
OPTION_GPP_OUTPUT = ${OPTION_GCC_OUTPUT}
OPTION_MKDIR_CREATE_PARENT_AUTOMATICALLY = --parent
OPTION_REMOVE_FORCE = --force

# 主要內容
# Main content
## Generic build rules
### C/CPP source code
%.o : %.c
	${COMPILER_C} ${OPTION_GCC_ONLY_COMPILE} ${OPTION_GCC_OUTPUT} ${DIR_OBJECT_CODE}/${NAME_TARGET}/%.o %.c
%.o : %.cpp
	${COMPILER_CPP} ${OPTION_GPP_ONLY_COMPILE} ${OPTION_GPP_OUTPUT} ${DIR_OBJECT_CODE}/${NAME_TARGET}/%.o %.cpp

## Specific build rules
.PHONY : build
build : compile link

.PHONY : compile
compile : 

.PHONY : link
link : compile

.PHONY : clean
clean :
	rm ${OPTION_REMOVE_FORCE} 