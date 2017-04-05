package body Sys_Interface.Daemon is

   procedure C_daemonize;
   pragma Import (C, C_daemonize, "daemonize");

   procedure Daemonize is
   begin
      C_daemonize;
   end Daemonize;

end Sys_Interface.Daemon;
