pragma License (GPL);

with Ada.Unchecked_Conversion;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with Interfaces.C; use Interfaces.C;
with Interfaces; use Interfaces;
with Interfaces.C_Streams; use Interfaces.C_Streams;
-- interface for operating system
package body Sys_Interface is


   procedure C_perror (descr : chars_ptr);
   pragma Import (C, C_perror, "perror");

   function C_system (command : chars_ptr) return Integer;
   pragma Import (C, C_system, "system");

   procedure C_syslog (Log_Priority : in Integer; Format : in chars_ptr; Text : in chars_ptr);
   pragma Import (C, C_syslog, "syslog");

   function C_fork return pid_t;
   pragma Import (C, C_fork, "fork");

   procedure C_wait (pid : out pid_t; status : out Integer);
   pragma Import (C, C_wait, "wait");
   pragma Import_Valued_Procedure (C_wait);

   procedure C_waitpid (pid : out pid_t; pid_or_gid : in pid_t; status : out Integer; options : Integer);
   pragma Import (C, C_waitpid, "waitpid");
   pragma Import_Valued_Procedure (C_waitpid);

   procedure C_getpid (PID : out pid_t);
   pragma Import (C, C_getpid, "getpid");
   pragma Import_Valued_Procedure (C_getpid);

   function C_kill (PID : pid_t; Signal : Integer) return Integer;
   pragma Import (C, C_kill, "kill");

   function C_killpg (PID : pid_t; Signal : Integer) return Integer;
   pragma Import (C, C_killpg, "killpg");

   procedure C_setpgid (PID : pid_t; PGRP : pid_t);
   pragma Import (C, C_setpgid, "setpgid");

   --  Sysinterface body

   function LPT_To_Int is new Ada.Unchecked_Conversion
     (Source => Log_Prioriry_Type, Target => Integer);

   function Signal_Type_To_Int is new Ada.Unchecked_Conversion
     (Source => Signal_Type, Target => Integer);

   procedure Perror (Descr : in String) is
      C_descr : chars_ptr;
   begin
      C_descr := New_String (Descr);
      C_perror (C_descr);
      Free (C_descr);
   end Perror;

   procedure System (Command : String; Return_Val : out Integer; Signal : out Integer) is
      C_command : chars_ptr;
      C_Ret_Val : Integer;
   begin
      C_command := New_String (Command);
      C_Ret_Val := C_system (C_command);
      Return_Val := Integer (Shift_Right (Unsigned_32 (C_Ret_Val), 8));
      --  Return_Val = -1 .... fork or waitpid failed
      --  Return_Val = 127 ... missing binary to be executed
      Signal := Integer (Unsigned_32 (C_Ret_Val) and 255);
      Free (C_command);
      return;
   end System;

   function System (Command : String) return Integer is
      Ret_Val : Integer;
      Signal : Integer;
   begin
      System (Command, Ret_Val, Signal);
      return Ret_Val;
   end System;

   procedure System (Command : in String) is
      Ret_Val : Integer;
   begin
      Ret_Val := System (Command);
      pragma Unreferenced (Ret_Val);
   end System;

   procedure Syslog (Log_Priority : in Log_Prioriry_Type; Text : in String) is
      Format_String : constant String := "%s";
      C_Format : chars_ptr;
      C_Text : chars_ptr;
   begin
      C_Format := New_String (Format_String);
      C_Text := New_String (Text);
      C_syslog (LPT_To_Int (Log_Priority), C_Format, C_Text);
      Free (C_Format);
      Free (C_Text);
   end Syslog;

   function Fork return pid_t is
   begin
      return C_fork;
   end Fork;

   procedure SetPGID (PID : pid_t; PGRP : pid_t) is
   begin
      C_setpgid (PID, PGRP);
   end SetPGID;

   procedure Wait (PID : out pid_t; Status : out Integer) is
   begin
      C_wait (PID, Status);
   end Wait;

   procedure Wait_Pid (PID : out pid_t; PID_or_GID : in pid_t; Status : out Integer; Options : Integer) is
   begin
      C_waitpid (PID, PID_or_GID, Status, Options);
   end Wait_Pid;

   function GetPID return pid_t is
      PID : pid_t;
   begin
      C_getpid (PID);
      return PID;
   end GetPID;

   function Kill (PID : pid_t; Signal : Signal_Type) return Integer is
   begin
      return C_kill (PID, Signal_Type_To_Int (Signal));
   end Kill;

   function Kill_PG (PID : pid_t; Signal : Signal_Type) return Integer is
   begin
      return C_killpg (PID, Signal_Type_To_Int (Signal));
   end Kill_PG;

   function C_popen (Command, Mode : String)  return FILEs;
   pragma Import (C, C_popen, "popen");

   procedure C_pclose (Result : out Integer; FID : FILEs);
   pragma Import (C, C_pclose, "pclose");
   pragma Import_Valued_Procedure (C_pclose);

end Sys_Interface;
