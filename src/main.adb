with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random;
with Ada.Strings; use Ada.Strings;
with Ada.Strings.Fixed; use Ada.Strings.Fixed;
with Ada.Numerics.Discrete_Random;
with Ada.Numerics.Float_Random;
with Mathematics; use Mathematics;
with NN; use NN;

procedure Main is
   type State_Index is new Integer range 1 .. 4;

   package Random_States is new Ada.Numerics.Discrete_Random (State_Index);

   G : Generator;
   G2 : Random_States.Generator;
   W1 : Net (1 .. 2, 1 .. 2);
   M1 : Net (1 .. 2, 1 .. 2) := (others => (others => 0.0));
   Y1 : Layer (1 .. 2);-- := (3 => 1.0, others => 0.0);
   D1 : Gradient (1 .. 2);

   W2 : Net (1 .. 2, 1 .. 1);
   M2 : Net (1 .. 2, 1 .. 1) := (others => (others => 0.0));
   Y2 : Layer (1 .. 1);
   D2 : Gradient (1 .. 1);
   E2 : Layer (1 .. 1);

   type State is record
      Input : Layer (1 .. 2);
      Output : Layer (1 .. 1);
   end record;

   type State_Array is array (State_Index) of State;


   Correlation_Array : State_Array :=
     (
        ((1.0, 1.0), (1 =>  0.0)),
      ((0.0, 1.0), (1 => 1.0)),
      ((0.0, 0.0), (1 =>  0.0)),
      ((1.0, 0.0), (1 => 1.0))
     );
   --Correlation_Array : State_Array := (((1.0, 1.0), (1 => -1.0)), ((-1.0, 1.0), (1 => 1.0)), ((-1.0, -1.0), (1 => -1.0)), ((1.0, -1.0), (1 => 1.0)));
   --Correlation_Array : State_Array := (((1.0, 1.0, 1.0), (1 => 0.0)), ((-1.0, 1.0, 1.0), (1 => 1.0)), ((-1.0, -1.0, 1.0), (1 => 0.0)), ((1.0, -1.0, 1.0), (1 => 1.0)));


   procedure Forward is new NN.Forward (NN.Activate_Tanh);
   procedure Backpropagate is new NN.Backpropagate (NN.Activate_Tanh_Derivative);
   procedure Error is new NN.Error (NN.Activate_Tanh_Derivative);
   procedure Put is new Mathematics.Put_Matrix (Integer, NN.Weight, NN.Net);
   procedure Put is new Mathematics.Put_Vector (Integer, NN.Nodation, NN.Layer);
   procedure Put is new Mathematics.Put_Vector (Integer, NN.Descent, NN.Gradient);

   C : Character;
   Iteration : Natural := Natural'First;
   --I : State_Index;
   N : Natural := 0;
begin
   Ada.Numerics.Float_Random.Reset (G, 1000);

   --Put (Sigmoid_Derivative_Reuse (1.0), 3, 3, 0);
   --loop null; end loop;

   NN.Randomize (G, -0.1, 0.1, W1);
   NN.Randomize (G, -0.1, 0.1, W2);

   Put (W1, 3, 2, 0);
   New_Line;
   Put (W2, 3, 2, 0);
   New_Line;

   loop
      Put (Head ("  Iteration", 20));
      Put ("|");
      Put (Head ("  Output", 20));
      Put ("|");
      Put (Head ("  Expected Output", 20));
      Put ("|");
      Put (Head ("  Error", 20));
      Put ("|");
      Put (Head ("  Delta", 20));
      New_Line;
      Get_Immediate (C);

      case C is
         when 'r' =>
            NN.Randomize (G, -0.1, 0.1, W1);
            NN.Randomize (G, -0.1, 0.1, W2);
            N := 0;
         when '1' =>
            N := 1;
         when '2' =>
            N := 10;
         when others =>
            N := 0;
      end case;

      for J in 1 .. N loop
         --I := Random_States.Random (G2);
         for I in State_Index loop
            Iteration := Natural'Succ (Iteration);
            Forward (Correlation_Array (I).Input, W1, Y1);
            Forward (Y1, W2, Y2);
            Error (Correlation_Array (I).Output, Y2, E2, D2);
            Backpropagate (D2, W2, Y1, D1);
            Adjust (0.01, 0.0, 0.000, Correlation_Array (I).Input, D1, W1, M1);
            Adjust (0.01, 0.0, 0.000, Y1, D2, W2, M2);
         end loop;
      end loop;


      for I in State_Index loop
         Forward (Correlation_Array (I).Input, W1, Y1);
         Forward (Y1, W2, Y2);
         Error (Correlation_Array (I).Output, Y2, E2, D2);

         Put (Iteration, 20);
         Put ("|");
         Put (Y2, 3, 16, 0);
         Put ("|");
         Put (Correlation_Array (I).Output, 3, 16, 0);
         Put ("|");
         Put (E2, 3, 16, 0);
         Put ("|");
         Put (D2, 3, 16, 0);
         New_Line;
      end loop;


      Put (W1, 3, 2, 0);
      New_Line;
      Put (W2, 3, 2, 0);
      New_Line;
   end loop;



end;
