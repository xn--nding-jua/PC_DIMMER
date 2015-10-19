// link.cpp : Defines the entry point for the console application.
//


#include <stdio.h>
#include <process.h>
#include <string.h>
#include <io.h>
#include <stdlib.h>

void copy(char *fi)
{
	char buffer[1024];
	char *ptr = strstr(fi, ".OBJ");
	if (!ptr) return;
	_snprintf(buffer, 1024, "copy \"%s\" \"%s_\"", fi, fi);
	system(buffer);
}


int main(int argc, char* argv[], char**envp)
{
	FILE *f;
	int i;
	char **na;
	char *path = NULL;
	char *out = NULL;  
	int is_dll = 0;
	char buffer[1024];
  	
	
	
	for (i = 0; i < argc; i++) {
		copy(argv[i]);
		if (!path  && strstr(argv[i], ".OBJ")) {
			int j;
			path = strdup(argv[i]);
			for (j = strlen(path) - 1; j > 0 && path[j] != '\\'; j--) {;} 
			path[j] = 0;
		}
		if (strstr(argv[i], "/OUT:")) {
			//_snprintf(buffer, 1024, "copy %s %s_", argv[i], argv[i] );
			//system(buffer); 
			out = strdup(argv[i] + 5);
		}
		if (strstr(argv[i], "/DLL")) {
			is_dll = 1;
		}
	}
	na = argv;

	if (path) {
		_snprintf(buffer, 1024, "%s\\link.def", path);
		if (!_access(buffer, 0)) {
			int j = 0;
			is_dll = 1;
			na = (char**) malloc(sizeof(char*) * (argc + 2));
			for (i = 0; i < argc; i++) {
				int inq = 0;
				char *ptr;
				if (strstr(argv[i], "/OUT")) {
					_snprintf(buffer, 1024, "/DEF:\"%s\\link.def\"", path);
					na[j++] = strdup(buffer);
				}
				ptr = argv[i];
				if (argv[i][0] == '/') inq = 1;
				while (*ptr && !inq) {
					if (*ptr == '"') inq = 1;
					ptr++;
				}
				if (!inq) {
					if (strstr(argv[i], "/BASE:")) {
						_snprintf(buffer, 1024, "/DLL /BASE:0x11000000 ");
					} else {	
						_snprintf(buffer, 1024, "\"%s\"", argv[i]);
					}
				} else {
					if (strstr(argv[i], "/ENTRY:")) {
						_snprintf(buffer, 1024, "/DLL /ENTRY:DllMain startup.lib");
					} else 	if (strstr(argv[i], "/BASE:")) {
						_snprintf(buffer, 1024, "/BASE:0x11000000 ");
					} else 	if (strstr(argv[i], "/OUT:")) {
						_snprintf(buffer, 1024, "%s", argv[i]);
						ptr = strstr(buffer, ".exe");
						if (ptr) {
							ptr[1] = 'd';
							ptr[2] = 'l';
							ptr[3] = 'l';
						}
					} else {		
						_snprintf(buffer, 1024, "%s", argv[i]);
					}
					
				}
				na[j++] = strdup(buffer);
			}
			na[argc + 1] = 0;
		}
		
	}
	
	f = fopen("link.bat", "wb");
	for (i = 0; na[i]; i++) {
		if (i == 0) {
			fprintf(f, "link_.exe /machine:I386 /nologo ");
		} else if (1 /*!strstr(na[i], "/OPT:") && !strstr(na[i], "/SUBSYSTEM:")*/) {
			fprintf(f, "%s ", na[i]);
		}
	}
	
	fprintf(f, " > log.txt \r\n", out, path);
	//fprintf(f, "copy %s com.txt \r\n", argv[1] + 1);
	fclose (f);
	
	
	if (is_dll && path) {
		system("link.bat");
		return 0;
	}

	return execve("link_.exe", argv, envp);
}

