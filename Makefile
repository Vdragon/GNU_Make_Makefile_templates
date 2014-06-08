# The format of this file is based on GNU_Make_Makefile_templates
# https://github.com/Vdragon/GNU_Make_Makefile_templates
# 變數
# Variables

## 關於專案本身的變數
## Variables about the project itself
name_project = name_project undefined
name_project_abbrieviation = name_project_abbrieviation undefined
name_target = name_target undefined
name_module = name_module undefined

## 目錄取名？
## Directory names?
dir_source_code = Source_code
dir_object_code = Object_code
dir_build = Build
dir_executables = Executables
dir_libraries = Libaries
dir_library_headers = Library_headers

## 安裝路徑前綴設定
DIR_INSTALL_PREFIX_UNIX = /usr/lib/local
dir_install_prefix = ${DIR_INSTALL_PREFIX_UNIX}

## C/C++ 開發環境相關
## C/C++ development environment related
postfix_type_source_code_c = .c
postfix_type_source_code_cpp = .cpp
postfix_type_header_c = .h
postfix_type_header_cpp = .hpp
POSTFIX_TYPE_OBJECT_CODE_LINUX = .o
POSTFIX_TYPE_OBJECT_CODE_DOS_WINDOWS = .obj

### C 編譯器相關
### C compiler related
COMPILER_GCC = gcc
OPTION_GCC_WITH_DEBUGGING_SYMBOLS = -g
OPTION_GCC_ONLY_COMPILE = -c
OPTION_GCC_OUTPUT_FILENAME = -o
OPTION_GCC_WARNING_COMMON = -Wall
option_gcc_warning = ${OPTION_GCC_WARNING_COMMON}
OPTION_GCC_DEBUG_INFO_MORE = -g3
option_gcc_debug_info = ${OPTION_GCC_DEBUG_INFO_MORE}
OPTION_GCC_OPTIMIZE_NONE = -O0
option_gcc_optimize = ${OPTION_GCC_OPTIMIZE_NONE}
OPTION_GCC_STANDARD_ANSI_C = -ansi
OPTION_GCC_STANDARD_C99 = -std=c99
option_gcc_standard = ${OPTION_GCC_STANDARD_ANSI_C}

COMMAND_GCC_ONLY_COMPILE = ${COMPILER_GCC} ${OPTION_GCC_ONLY_COMPILE} ${option_gcc_warning} ${option_gcc_standard} ${option_gcc_debug_info} ${option_gcc_optimize}

### C++ 編譯器相關
### C++ compiler related
COMPILER_GPP = g++

OPTION_GPP_WITH_DEBUGGING_SYMBOLS = ${OPTION_GCC_WITH_DEBUGGING_SYMBOLS}
OPTION_GPP_WARNING_COMMON = ${OPTION_GCC_WARNING_COMMON}
option_gpp_warning = ${OPTION_GPP_WARNING_COMMON}
OPTION_GPP_ONLY_COMPILE = ${OPTION_GCC_ONLY_COMPILE}
OPTION_GPP_OUTPUT = ${OPTION_GCC_OUTPUT}

COMMAND_GPP_ONLY_COMPILE = ${COMPILER_GPP} ${OPTION_GPP_ONLY_COMPILE} ${option_gpp_warning}


### 連結器相關
### Linker related
POSTFIX_TYPE_DYNAMIC_LIBRARY_LINUX = .so
POSTFIX_TYPE_DYNAMIC_LIBRARY_WINDOWS = .dll

POSTFIX_TYPE_EXECUTABLE_WINDOWS = .exe
POSTFIX_TYPE_EXECUTABLE_LINUX = .executable

LINKER_GNU_LINKER = ld

OPTION_GNU_LINKER_OUTPUT_FILENAME = -o
OPTION_GNU_LINKER_LINK_GLIBC = -lc

### 函式庫封裝器相關
### Library archiver related
POSTFIX_TYPE_STATIC_LIBRARY_LINUX = .a
POSTFIX_TYPE_STATIC_LIBRARY_WINDOWS = .lib

ARCHIVER_LIBRARY_GNU_AR = ar

OPTION_GNU_AR_OPCODE_INSERT_OBJECT = r
OPTION_GNU_AR_MODIFIER_CREATE_FILE = c
OPTION_GNU_AR_MODIFIER_ADD_INDEX_INFO = s

## 刪除檔案相關
## Delete file related
### DOS/Windows
FILE_REMOVER_WINDOWS = del

### Unix
FILE_REMOVER_LINUX = rm
OPTION_FILE_REMOVER_LINUX_FORCE = --force

COMMAND_REMOVE_LINUX = ${FILE_REMOVER_LINUX} ${OPTION_FILE_REMOVER_LINUX_FORCE}

## 創造新目錄相關
## Create directory related
DIR_CREATER_WINDOWS = mkdir
DIR_CREATER_LINUX = mkdir

OPTION_MKDIR_CREATE_PARENT_AUTOMATICALLY = --parent

## System environment details related
### Unix
# -s is used instead of --sysname for portability
COMMAND_UNAME_FETCH_SYSTEM_NAME = uname -s
# -p is used instead of --processer for portability
COMMAND_UNAME_FETCH_PROCESSER_ARCHITECHTURE = uname -p

# 作業系統判斷規則，用來決定最終使用的變數
# Operating system determine rules, used to determine the final used variables
# 參考資料
# Reference data
#   1. http://stackoverflow.com/questions/714100/os-detecting-makefile
ifeq ($(OS), Windows_NT) # Windows 2000 or later
	command_c_compiler_only_compile = Undefined command
	command_cpp_compiler_only_compile = Undefined command
	
	command_link_executable = Undefined command
	
	command_build_dynamic_library = Undefined command
	command_build_static_library = Undefined command
	
	command_remove_built_artifacts = Undefined command
else # Assumed Unix, TODO: We need more
	UNIX_SYSTEM_NAME := $(shell ${COMMAND_UNAME_FETCH_SYSTEM_NAME})
	UNIX_PROCESSER_ARCHITECHTURE := $(shell ${COMMAND_UNAME_FETCH_PROCESSER_ARCHITECHTURE})
	
# Not used as we currently doesn't assemble our commands here...
#	compiler_c = ${COMPILER_GCC}
#	compiler_cpp = ${COMPILER_GPP}
	linker = ${LINKER_GNU_LINKER}
	file_remover = ${REMOVER_LINUX}

	postfix_type_object_code = ${POSTFIX_TYPE_OBJECT_CODE_LINUX}
	postfix_type_dynamic_library = ${POSTFIX_TYPE_DYNAMIC_LIBRARY_LINUX}
	postfix_type_executable = ${POSTFIX_TYPE_EXECUTABLE_LINUX}
	postfix_type_static_library = ${POSTFIX_TYPE_STATIC_LIBRARY_LINUX}
	
	command_c_compiler_only_compile = ${COMMAND_GCC_ONLY_COMPILE}
	command_cpp_compiler_only_compile = ${COMMAND_GPP_ONLY_COMPILE}
	
# 因為 ${POSTFIX_TYPE_EXECUTABLE} 到這裡才定義所以只能在這裡組合
	command_link_executable = ${LINKER_GNU_LINKER} ${OPTION_GNU_LINKER_LINK_GLIBC} ${OPTION_GNU_LINKER_OUTPUT} ${NAME_PROJECT}.${POSTFIX_TYPE_EXECUTABLE}
	
	command_build_static_library = ${ARCHIVER_LIBRARY_GNU_AR} ${OPTION_GNU_AR_OPCODE_INSERT_OBJECT}${OPTION_GNU_AR_MODIFIER_CREATE_FILE}${OPTION_GNU_AR_MODIFIER_ADD_INDEX_INFO} lib${name_project_abbrieviation}_${name_module}${postfix_type_static_library}
	
	command_remove_built_artifacts = ${COMMAND_REMOVE_LINUX}
endif

# 通用 Make 規則
# Generic Make rules
%${postfix_type_object_code} : %${postfix_type_source_code_c}
	${command_c_compiler_only_compile} $^
%${postfix_type_object_code} : %${postfix_type_source_code_cpp}
	${command_cpp_compiler_only_compile} $^

# 主要內容
# Main content
.PHONY : all
all : build_executable

.PHONY : build_executable
build_executable : compile link

.PHONY : build_library
build_library : compile archive_library

.PHONY : compile
compile : ${name_module}${postfix_type_object_code}

.PHONY : archive_library
archive_library : compile
	${command_build_static_library} *${postfix_type_object_code}
	
.PHONY : link
link : compile
	${command_link_executable} *${postfix_type_object_code}

.PHONY : install
install : all
	

.PHONY : uninstall
uninstall : 
	

.PHONY : clean
clean :
	${command_remove_built_artifacts} *${postfix_type_object_code} *${postfix_type_executable} *${postfix_type_dynamic_library} *${postfix_type_static_library}
