with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

with Mathematics; use Mathematics;
with Text; use Text;
with NN2; use NN2;


procedure Dev2 is
   G : Generator;
   C : Character;

   -- Create 2 Inputs, 2 Hiddens, 1 output. One bias.
   -- +/- 0.5 random init weight matrices.
   N : Network := Create ((2, 2, 1), (0, 0, 0), G, 0.5);

   type State is record
      I : Vector (1 .. 2);
      O : Vector (1 .. 1);
   end record;

   E : Vector (1 .. 1);
   E_Sum : Float;

   X : array (1 .. 4) of State := (((1.0, 1.0), (1 => 0.0)), ((0.0, 1.0), (1 => 1.0)), ((0.0, 0.0), (1 => 0.0)), ((1.0, 0.0), (1 => 1.0)));

   K : Natural := Natural'First;
begin

   Put_Line("Commence aether");

   loop
      Get_Immediate(C);
      exit when C = 'q';
      E_Sum := 0.0;
      for Xi of X loop
         -- Train network with Learing rate 0.3 and Moment rate 0.1.
         -- Error vector is E.
         Train (N, 0.3, 0.1, Xi.I, Xi.O, E);
         K := Natural'Succ (K);
         Put ("I");
         Put (K, 4);
         Put (" E");
         Put (E (1), 3, 3, 0);
         New_Line;
         E_Sum := E_Sum + abs(E(1));
      end loop;
      Put ("E_Sum");
      Put (E_Sum, 3, 3, 0);
      New_Line;
      Put ("Ratio");
      Put (E_Sum / 4.0, 3, 3, 0);
      New_Line(2);
   end loop;

end;
