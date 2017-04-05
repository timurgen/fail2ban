pragma License (GPL);

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
-- interface for operating system
package Sys_Interface is

   type OS_Type is (FreeBSD, Linux, Windows);
   Running_OS : OS_Type := FreeBSD;


   --  errno : Integer;
   --  pragma Import (C, errno);
   --  XXX: doesn't work on Linux properly; why? how to do it? GNAT.Os_Lib?

   procedure Perror (Descr : String);

   procedure System (Command : String; Return_Val : out Integer; Signal : out Integer);
   function System (Command : String) return Integer;
   procedure System (Command : in String);

   type Log_Prioriry_Type is (LOG_EMERG, LOG_ALERT, LOG_CRIT, LOG_ERR,
                              LOG_WARNING, LOG_NOTICE, LOG_INFO, LOG_DEBUG);
   procedure Syslog (Log_Priority : in Log_Prioriry_Type; Text : in String);

   type pid_t is new Integer;
   function Fork return pid_t;
   procedure SetPGID (PID : pid_t; PGRP : pid_t);
   function GetPID return pid_t;
   procedure Wait (PID : out pid_t; Status : out Integer);
   procedure Wait_Pid (PID : out pid_t; PID_or_GID : in pid_t; Status : out Integer; Options : Integer);

   type Signal_Type is (SIGHUP, SIGINT, SIGQUIT, SIGKILL, SIGPIPE, SIGALRM,
                        SIGTERM, SIGSTOP, SIGTSTP, SIGCONT, SIGINFO, SIGUSR1, SIGUSR2);
   function Kill (PID : pid_t; Signal : Signal_Type) return Integer;
   function Kill_PG (PID : pid_t; Signal : Signal_Type) return Integer;

private

   for Log_Prioriry_Type use (LOG_EMERG => 0, LOG_ALERT => 1, LOG_CRIT => 2,
                              LOG_ERR => 3, LOG_WARNING => 4, LOG_NOTICE => 5, LOG_INFO => 6,
                              LOG_DEBUG => 7);
   for Log_Prioriry_Type'Size use Integer'Size;

   for Signal_Type use (SIGHUP => 1, SIGINT => 2, SIGQUIT => 3, SIGKILL => 9,
                        SIGPIPE => 13, SIGALRM => 14, SIGTERM => 15, SIGSTOP => 17,
                        SIGTSTP => 18, SIGCONT => 19, SIGINFO => 29, SIGUSR1 => 30,
                        SIGUSR2 => 31);
   for Signal_Type'Size use Integer'Size;

end Sys_Interface;
