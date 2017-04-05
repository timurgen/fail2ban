package Db is
   -- open or create if not exist db file
   procedure Init_Db;
   -- close database
   procedure Close_Db;

private
   procedure Check_Db_Version;

end Db;
