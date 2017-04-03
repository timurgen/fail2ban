with Ada.Command_Line;
with Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Help; use Help;

procedure Main is
   package SOUT renames Ada.Text_IO;
   -- parse command line arguments
   package CLI renames Ada.Command_Line;
   Arg_Count : Natural := CLI.Argument_Count;
begin
   if Arg_Count < 1 then
      Display_Help;
      return;
   elsif Arg_Count = 1 then
      if CLI.Argument(1) = "-h" then
         Display_Help;
         return;
      elsif CLI.Argument(1) = "-v" then
         Display_Version;
         return;
      end if;
   end if;


end Main;
