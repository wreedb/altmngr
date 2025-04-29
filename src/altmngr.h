#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdio.h>

#define ALTMNGR_VERSION "0.1.0"

int is_symlink(const char *path)
{
    struct stat path_stat;
    if (lstat(path, &path_stat) < 0)
    {
        perror("lstat");
        return 0;
    }
    return S_ISLNK(path_stat.st_mode);
}

#define MERGED_SBIN is_symlink("/usr/sbin")