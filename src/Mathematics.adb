with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Text_IO;
with Ada.Float_Text_IO;

package body Mathematics is


   procedure Put_Matrix (A : Matrix; Fore : Field; Aft : Field; Exp : Field) is
      package Float_IO is new Ada.Text_IO.Float_IO (Element);
      use Float_IO;
      use Ada.Text_IO;
   begin
      for I in A'Range (1) loop
         for J in A'Range (2) loop
            Put (A (I, J), Fore, Aft, Exp);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Put_Vector (A : Vector; Fore : Field; Aft : Field; Exp : Field) is
      package Float_IO is new Ada.Text_IO.Float_IO (Element);
      use Float_IO;
      use Ada.Text_IO;
   begin
      for I in A'Range loop
         Put (A (I), Fore, Aft, Exp);
      end loop;
   end;

end Mathematics;
