with Ada.Command_line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

with NN;

procedure Test_XOR is

   procedure Put ( W : NN.Weight_Matrix ) is
   begin
      for I in W'Range(1) loop
         for J in W'Range(2) loop
            Put (W (I, J), 5, 4, 0);
         end loop;
         New_Line;
      end loop;
   end Put;


   procedure Train ( A, B, T : Float; W1 : in out NN.Weight_Matrix; W2 : in out NN.Weight_Matrix ) is
      H : NN.Layer (3);
      R : NN.Layer (1);
      X : NN.Float_Array(1..3) := (A, B, 1.0);
   begin
      NN.Forward (X, W1, H);
      NN.Forward (H, W2, R);
      R.D(1) := T - R.Y(1);
      NN.Backpropagation (H, W2, R);
      NN.Adjust (X, W1, H);
      NN.Adjust (H, W2, R);
   end Train;

   procedure Test ( A, B, T : Float; W1 : in NN.Weight_Matrix; W2 : in NN.Weight_Matrix ) is
      H : NN.Layer (3);
      R : NN.Layer (1);
      X : NN.Float_Array(1..3) := (A, B, 1.0);
   begin
      NN.Forward (X, W1, H);
      NN.Forward (H, W2, R);
      Put (T, 5, 4, 0);
      Put (R.Y (1), 5, 4, 0);
      Put (T - R.Y (1), 5, 4, 0);
   end Test;

   W1 : NN.Weight_Matrix (1 .. 3, 1 .. 3);
   W2 : NN.Weight_Matrix (1 .. 3, 1 .. 1);

   C : Character;
   N : Natural := 0;

begin

   NN.Random (W1);
   NN.Random (W2);

   loop
      Get_Immediate (C);
      N := Natural'Succ(N);
      Train (0.0, 0.0, 0.0, W1, W2);
      Train (1.0, 0.0, 1.0, W1, W2);
      Train (1.0, 1.0, 0.0, W1, W2);
      Train (0.0, 1.0, 1.0, W1, W2);
      Put_Line("Weights (3->3)");
      Put (W1);
      New_Line;
      Put_Line("Weights (3->1)");
      Put (W2);
      New_Line;
      Put_Line("Target Output Error");
      Test (0.0, 0.0, 0.0, W1, W2);New_Line;
      Test (1.0, 0.0, 1.0, W1, W2);New_Line;
      Test (1.0, 1.0, 0.0, W1, W2);New_Line;
      Test (0.0, 1.0, 1.0, W1, W2); New_Line;
      New_Line;
      Put("Iteration: ");Put (N);
      New_Line (5);
      exit when C = 'q';
   end loop;

end;


