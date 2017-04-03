with Ada.Text_IO;
package body Help is
   package SOUT renames Ada.Text_IO;
   ------------------
   -- Display_Help --
   ------------------

   procedure Display_Help is
      use ASCII;
      Help_Text: String := "Usage: " & Program_Name & " --config=<path_to_file>" & LF &
        "-h" & HT & "show this message" & LF &
        "-v" & HT & "show version" & LF;
   begin
      SOUT.Put_Line(Help_Text);
   end Display_Help;

   procedure Display_Version is
   begin
      SOUT.Put_Line(Version);
   end Display_Version;


end Help;
