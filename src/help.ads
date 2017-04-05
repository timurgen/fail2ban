pragma License (GPL);

with GNAT.Command_Line; use GNAT.Command_Line;

package Help is
   -- build help/usage text
   procedure Init_Cli;
   -- show help/usage text
   procedure Display_Help;
   -- register configuration options
   procedure Capture_Args;

private
   Config_Cli: Command_Line_Configuration;
end Help;
