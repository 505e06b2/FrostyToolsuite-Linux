#include <libloaderapi.h>
#include <direct.h>

#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <process.h>

#ifndef PATH_MAX
//taken from https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation
#define PATH_MAX 0x7FFF
#endif

#define RUN_SCRIPT L"runMod"

size_t remove_file_from_path(wchar_t *path, uint32_t path_strlen) {
	for(wchar_t *current_char = path + path_strlen; current_char != path; current_char--) {
		if(*current_char == L'\\') {
			*current_char = L'\0';
			return current_char - path - 1; //the -1 keeps this consistent with strlen
		}
	}
	return 0;
}

int main(int argc, char *argv[]) {
	//cd to exe directory in case cwd isn't as expected - win32api
	wchar_t exe_path[PATH_MAX];

	size_t exe_path_strlen = GetModuleFileNameW(NULL, exe_path, sizeof(exe_path));
	if(exe_path_strlen == 0) {
		fprintf(stderr, "Unable to get this executable's location\n");
		return 1;
	}

	exe_path_strlen = remove_file_from_path(exe_path, exe_path_strlen);
	if(exe_path_strlen == 0) {
		fprintf(stderr, "Unable to find top level of path\n");
		return 1;
	}

	if(_wchdir(exe_path) != 0) {
		fprintf(stderr, "Unable to change directory to \"%ls\": %s\n", exe_path, strerror(errno));
		return 1;
	}

	wchar_t *exe_as_arg = exe_path + exe_path_strlen + 2; //+1 to get to the \0, then +1 to the beginning of the filename
	_wspawnl(P_WAIT, RUN_SCRIPT, RUN_SCRIPT, exe_as_arg, NULL);

	return 0;
}
