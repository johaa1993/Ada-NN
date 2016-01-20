with Ada.Text_IO; use Ada.Text_IO;
with System.Img_WIU; use System.Img_WIU;



package body Text is

   function Resize ( X : String; N : Natural; C : Character := ' ' ) return String is
      Y : String (X'First .. X'First + N - 1) := (others => C);
   begin
      if X'Length > N then
         Y := X (Y'Range);
      else
         Y (X'Range) := X;
      end if;
      return Y;
   end;

   function Resize_Right ( X : String; N : Natural; C : Character := ' ' ) return String is
      Y : String (X'First .. X'First + N - 1) := (others => C);
   begin
      if X'Length > N then
         Y := X (Y'Range);
      else
         Y (Y'Last - X'Length + 1 .. Y'Last) := X;
      end if;
      return Y;
   end;

   function Resize ( X : Integer; N : Natural; C : Character := ' ' ) return String is
      B : String (1 .. Field'Last) := (others => C);
      P : Natural := 0;
   begin
      System.Img_WIU.Set_Image_Width_Integer (X, N, B, P);
      return B (1 .. P);
   end;

   procedure Put (X : Integer; L : Natural; C : Character := ' ') is
   begin
      null;
      --Ada.Text_IO.Put (Resize (S, L, C));
   end;

end;
