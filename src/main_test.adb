with Ada.Text_IO;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with System;

procedure Main_Test is

   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Integer_Text_IO;

   type Float_Array is array (Integer range <>) of Float;
   type Float_Vector is array (Integer range <>) of Float;

   F : Float_Array (1 .. 2) := (others => 0.0);
   G : Float_Vector (1 .. 3) := (others => 0.0);

   C : Character;



begin

   F := Float_Array (G (2..3));
   F := Float_Array (G (1..2));

   Get_Immediate (C);

   null;
end;
