pragma License (GPL);

with Ada.Text_IO; use ada.Text_IO;
with Help; use Help;
with Config.Options; use Config.Options;
with Ada.Exceptions; use Ada.Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Command_Line; use Ada.Command_Line;
with Sys_Interface.Daemon; use Sys_Interface.Daemon;
with Sys_Interface; use Sys_Interface;

procedure Main is

begin
   Init_Cli;
   Capture_Args;

   if Start_As_Daemon then
      if Verbose then
         Syslog(Log_Priority => LOG_NOTICE,
                Text         => "Starting adaban as a daemon");
      end if;
      Daemonize;
      if Verbose then
         Syslog(Log_Priority => LOG_NOTICE,
                Text         => "Daemon started");
      end if;

   end if;

end Main;
