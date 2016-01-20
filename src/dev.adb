with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

with Mathematics; use Mathematics;


procedure Dev is

   G : Generator;
   A : Matrix (1 .. 3, 1 .. 2);
   X : Vector (1 .. 3);

   V : Float;
begin
   null;

   Random (G, 1.0, A);
   Random (G, 1.0, X);

   V := Dot1 (A, X, 2);
   Put (V, 3, 3, 0);

   V := Dot2 (A, X, 3);
   Put (V, 3, 3, 0);

end;
