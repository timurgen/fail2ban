pragma License (GPL);

with GNAT.Directory_Operations; use GNAT.Directory_Operations;

package Config is
   pragma Pure;
   -- folder containing config files
   Config_Dir : constant String := Format_Pathname("/etc/adaban");
   -- folder containing lock file
   Lockfile_Dir: constant String := Format_Pathname("/var/lock");
   -- folder containg log file
   Logfile_Dir : constant String := Format_Pathname("/var/log");
   -- database file
   Db_File : constant String := Format_Pathname("/opt/adaban/db.sqlite");
end Config;
