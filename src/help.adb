with GNAT.Command_Line; use GNAT.Command_Line;
with Ada.Command_Line;
with GNAT.OS_Lib;
with Config.Options;
with Ada.Text_IO; use Ada.Text_IO;
package body Help is
   ---------------
   -- Init_Help --
   ---------------

   procedure Init_Cli is
   begin
      Set_Usage(Config_Cli,Usage => "-d");
      Define_Switch(Config_Cli, Config.Options.Start_As_Daemon'Access,  Switch => "-d", Help => "Start as daemon");
      Define_Switch(Config_Cli, Switch => "-v", Help => "Show version");
      Define_Switch(Config_Cli, cONFIG.Options.Display_Help'Access, Switch => "--help", Help => "Show help (this text)");
      Define_Switch(Config_Cli, Config.Options.Verbose'Access, Switch => "--verbose", Help => "Show verbose output");
   end Init_Cli;

   ------------------
   -- Display_Help --
   ------------------

   procedure Display_Help is
   begin
      GNAT.Command_Line.Display_Help(Config_Cli);
      GNAT.OS_Lib.OS_Exit (0);
   end Display_Help;

   ------------------
   -- Capture_Args --
   ------------------

   procedure Capture_Args is
   begin
      if Ada.Command_Line.Argument_Count = 0 then
         Display_Help;
      end if;
      Getopt(Config_Cli);
      if Config.Options.Display_Help = True then
         Display_Help;
      end if;
   end Capture_Args;


end Help;
