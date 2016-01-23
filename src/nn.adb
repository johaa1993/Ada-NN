with Mathematics;
with Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Float_Random;

package body NN is

   function Randomize (G : Generator) return Weight is (Weight (Ada.Numerics.Float_Random.Random (G)));

   procedure Randomize (G : Generator; A, B : Weight; W : out Net) is
      function Randomize (A, B : Weight) return Weight is
      begin
         return (B - A) * Randomize (G) + A;
      end;
   begin
      for I in W'Range(1) loop
         for J in W'Range(2) loop
            W (I, J) := Randomize (A, B);
         end loop;
      end loop;
   end;


   generic
      type Index is range <>;
      type Left is digits <>;
      type Right is digits <>;
      type Result is digits <>;
      type Vector is array (Index range <>) of Right;
      type Matrix is array (Index range <>, Index range <>) of Left;
   function Dot_1 (A : Matrix; X : Vector; J : Index) return Result;

   function Dot_1 (A : Matrix; X : Vector; J : Index) return Result is
      Y : Result := 0.0;
   begin
      for I in A'Range (1) loop
         Y := Y + Result (X (I)) * Result (A (I, J));
      end loop;
      return Y;
   end;

   generic
      type Index is range <>;
      type Left is digits <>;
      type Right is digits <>;
      type Result is digits <>;
      type Vector is array (Index range <>) of Right;
      type Matrix is array (Index range <>, Index range <>) of Left;
   function Dot_2 (A : Matrix; X : Vector; I : Index) return Result;

   function Dot_2 (A : Matrix; X : Vector; I : Index) return Result is
      Y : Result := 0.0;
   begin
      for J in A'Range (2) loop
         Y := Y + Result (X (J)) * Result (A (I, J));
      end loop;
      return Y;
   end;

   function Activate_Logistic ( X, A, K, B, V, Q : Float ) return Float is
      use Ada.Numerics.Elementary_Functions;
      use Ada.Numerics;
   begin
      return A + ((K - A) / ((1.0 + Q * e ** (-B * X)) ** (1.0 / V)));
   end;

   function Activate_Sigmoid ( X : Float ) return Float is
      use Ada.Numerics.Elementary_Functions;
   begin
      return 1.0 / (1.0 + Exp (-X));
   end;

   function Activate_Sigmoid_Derivative ( X : Float ) return Float is
   begin
      return X * (1.0 - X);
   end;

   function Activate_Tanh (X : Float) return Float is
      use Ada.Numerics.Elementary_Functions;
   begin
      return Tanh (X);
   end;

   function Activate_Tanh_Derivative (X : Float) return Float is
   begin
      return 1.0 - (X ** 2);
   end;


   function Forward_Single (X : Layer; W : Net; I : Integer) return Nodation is
      function Sum is new Dot_1 (Integer, Weight, Nodation, Float, Layer, Net);
   begin
      return Nodation (Activate (Sum (W, X, I)));
   end;



   procedure Forward (X : Layer; W : Net; Y : out Layer) is
      function Sum is new Dot_1 (Integer, Weight, Nodation, Float, Layer, Net);
   begin
      for I in W'Range (2) loop
         Y (I) := Nodation (Activate (Sum (W, X, I)));
      end loop;
   end;

   procedure Error (T : Layer; Y : Layer; E : out Layer; D : out Gradient) is
   begin
      for I in D'Range loop
         E (I) := T (I) - Y (I);
         D (I) := Descent (Activate (Float (Y (I)))) * Descent (E (I));
      end loop;
   end;

   function Backpropagate_Single (D : Gradient; W : Net; A : Layer; I : Integer) return Descent is
      function Sum is new Dot_2 (Integer, Weight, Descent, Float, Gradient, Net);
   begin
      return Descent (Sum (W, D, I) * Activate (Float (A (I))));
   end;

   procedure Backpropagate (D : Gradient; W : Net; A : Layer; R : out Gradient) is
      function Sum is new Dot_2 (Integer, Weight, Descent, Float, Gradient, Net);
   begin
      for I in W'Range (1) loop
         R (I) := Descent (Sum (W, D, I) * Activate (Float (A (I))));
      end loop;
   end;

   procedure Adjust (LR : Float; MR : Float; DR : Float; X : Layer; D : Gradient; W : in out Net; M : in out Net) is
   begin
      for I in W'Range (1) loop
         for J in W'Range (2) loop
            M (I, J) := Weight (MR * Float (M (I, J)) + LR *  Float (D (J)) * Float (X (I)));
            W (I, J) := W (I, J) + M (I, J);
         end loop;
      end loop;
   end;

end NN;
