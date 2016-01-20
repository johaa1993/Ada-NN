with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;

with NN; use NN;
with Mathematics; use Mathematics;

procedure Main is

   G : Generator;
   W1 : Matrix (1 .. 2, 1 .. 2);
   M1 : Matrix (1 .. 2, 1 .. 2) := (others => (others => 0.0));
   Y1 : Vector (1 .. 2);
   D1 : Vector (1 .. 2);

   W2 : Matrix (1 .. 2, 1 .. 1);
   M2 : Matrix (1 .. 2, 1 .. 1) := (others => (others => 0.0));
   Y2 : Vector (1 .. 1);
   D2 : Vector (1 .. 1);
   E2 : Vector (1 .. 1);

   type State is record
      Input : Vector (1 .. 2);
      Output : Vector (1 .. 1);
   end record;

   type State_Array is array (Integer range <>) of State;

   Correlation_Array : State_Array := (((1.0, 1.0), (1 => 0.0)), ((0.0, 1.0), (1 => 1.0)), ((0.0, 0.0), (1 => 0.0)), ((1.0, 0.0), (1 => 1.0)));

   C : Character;

begin

   Reset (G);

   Random (G, 0.3, W1);
   Random (G, 0.3, W2);

   Put (W1, 3, 2, 0);
   New_Line;
   Put (W2, 3, 2, 0);
   New_Line;

   loop
      Put (Head ("  Output", 20));
      Put ("|");
      Put (Head ("  Expected Output", 20));
      Put ("|");
      Put (Head ("  Error", 20));
      Put ("|");
      Put (Head ("  Delta", 20));
      New_Line;
      Get_Immediate (C);

      for I in Correlation_Array'Range loop
         Forward (Correlation_Array (I).Input, W1, Y1);
         Forward (Y1, W2, Y2);
         Error (Correlation_Array (I).Output, Y2, E2, D2);

         Put (Y2, 3, 16, 0);
         Put ("|");
         Put (Correlation_Array (I).Output, 3, 16, 0);
         Put ("|");
         Put (E2, 3, 16, 0);
         Put ("|");
         Put (D2, 3, 16, 0);
         New_Line;

         Backpropagate (W2, D2, Y1, D1);
         Adjust (Correlation_Array (I).Input, W1, M1, D1, 0.2, 0.8);
         Adjust (Y1, W2, M2, D2, 0.3, 0.1);
      end loop;
      Put (W1, 3, 2, 0);
      New_Line;
      Put (W2, 3, 2, 0);
      New_Line;
   end loop;



end;
