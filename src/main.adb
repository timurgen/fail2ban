pragma License (GPL);

with Ada.Text_IO; use ada.Text_IO;
with Help; use Help;
with Config.Options;

procedure Main is
   function getpid return Integer;
   pragma Import (C, getpid);
   PID : constant Integer := getpid;
begin
   Init_Cli;
   Capture_Args;
   Put_Line(Integer'Image(PID));
end Main;
