with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Numerics.Float_Random;

package body NN is

   function Sigmoid(X : Float) return Float is
      package Math is new Ada.Numerics.Generic_Elementary_Functions(Float); use Math;
      e : constant Float := 2.7;
   begin
      return 1.0 / (1.0 + e**(-X));
   end;

   function Sigmoid_Derivative (X : Float) return Float is
   begin
      return Sigmoid(X) * (1.0 - Sigmoid(X));
   end;


   procedure Forward ( X : Float_Array; W : Weight_Matrix; L : out Layer ) is
   begin
      for I in 1 .. L.N loop
         L.S (I) := 0.0;
         for J in X'Range loop
            L.S (I) := L.S (I) + X (J) * W (J, I);
         end loop;
         L.Y (I) := Sigmoid ( L.S (I) );
         L.Z (I) := Sigmoid_Derivative ( L.S (I) );
      end loop;
   end Forward;

   procedure Forward ( A : Layer; W : Weight_Matrix; B : out Layer ) is
   begin
      Forward (A.Y, W, B);
   end;

   procedure Backpropagation ( A : out Layer; W : Weight_Matrix; B : Layer ) is
   begin
      for I in 1 .. A.N loop
         A.D (I) := 0.0;
         for J in 1 .. B.N loop
            A.D (I) := A.D (I) + B.D (J) * W (I, J);
         end loop;
      end loop;
   end Backpropagation;

   procedure Adjust ( X : Float_Array; W : in out Weight_Matrix; B : Layer ) is
      D : Float;
      Z : Float;
   begin
      for I in 1 .. B.N loop
         D := B.D (I);
         Z := B.Z (I);
         for J in X'Range loop
            W (J, I) := W (J, I) + Learning_Rate * D * Z * X (J);
         end loop;
      end loop;
   end Adjust;

   procedure Adjust ( A : Layer; W : in out Weight_Matrix; B : Layer ) is
   begin
      Adjust (A.Y, W, B);
   end Adjust;


   procedure Random ( W : out Weight_Matrix ) is
      use Ada.Numerics.Float_Random;
      G : Generator;
   begin
      Reset (G);
      for I in W'Range(1) loop
         for J in W'Range (2) loop
            W (I, J) := Random(G);
         end loop;
      end loop;
   end Random;


end NN;
