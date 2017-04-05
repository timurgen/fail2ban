pragma License (GPL);

with Config.Options; use Config.Options;

package body Sys_Interface.Daemon is

   procedure C_daemonize;
   pragma Import (C, C_daemonize, "daemonize");

   procedure Daemonize is
   begin
      if Verbose then
         Syslog(Log_Priority => LOG_NOTICE,
                Text         => "Starting adaban as a daemon");
      end if;
      C_daemonize;
      if Verbose then
         Syslog(Log_Priority => LOG_NOTICE,
                Text         => "Daemon started");
      end if;
   end Daemonize;

end Sys_Interface.Daemon;
