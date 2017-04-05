#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int getdtablesize();
int fork();
int setsid();

void daemonize(void)
{
  int i,n = getdtablesize();

  if (chdir("/")) {
    perror("chdir to /");
    exit(EXIT_FAILURE);
  }
  for (i=0; i<n; i++)
    (void) close(i);

  switch (fork()) {
    case -1:
      perror("daemonize fork");
      exit(EXIT_FAILURE);
    case 0:
      if(setsid() == -1) {
	perror("setsid");
	exit(EXIT_FAILURE);
      }
      break;
    default:
      exit(EXIT_SUCCESS);
  }
}
