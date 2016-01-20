with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

with Ada.Text_IO;
with Ada.Float_Text_IO;

--with System.Img_LLD;

package body Mathematics is

   function Logistic ( X, A, K, B, V, Q : Float ) return Float is
   begin
      return A + ((K - A) / ((1.0 + Q * e ** (-B * X)) ** (1.0 / V)));
   end;

   function Sigmoid ( X : Float ) return Float is
   begin
      return 1.0 / (1.0 + e ** (-X));
   end;

   function Sigmoid_Derivative ( X : Float ) return Float is
      A : Float := Sigmoid(X);
   begin
      return A * (1.0 - A);
   end;

   function Sigmoid_Derivative_Reuse ( X : Float ) return Float is
   begin
      return X * (1.0 - X);
   end;

   function Tanh( X : Float ) return Float is (Elementary_Functions.Tanh(X));

   function Tanh_Derivative ( X : Float ) return Float is
   begin
      return 1.0 - (Tanh(X) ** 2);
   end;

   -- Use this if X is Tanh (X')
   function Tanh_Derivative_Reuse ( X : Float ) return Float is
   begin
      return 1.0 - (X ** 2);
   end;

   function Map ( X, X1, X2, Y1, Y2 : Float ) return Float is
   begin
      return (X - X1) * (Y2 - Y1) / (X2 - X1) + Y1;
   end;

   function Dot1 ( A : Matrix; X : Vector; I2 : Positive ) return Float is
      Y : Float := 0.0;
   begin
      for I1 in A'Range (1) loop
         Y := Y + X (I1) * A (I1, I2);
      end loop;
      return Y;
   end;

   function Dot2 ( A : Matrix; X : Vector; I1 : Positive ) return Float is
      Y : Float := 0.0;
   begin
      for I2 in A'Range (2) loop
         Y := Y + X (I2) * A (I1, I2);
      end loop;
      return Y;
   end;

   function Random ( G : Generator; X1, X2 : Float ) return Float is
   begin
      return (X2 - X1) * Random (G) + X1;
   end Random;

   function Random ( G : Generator; X1 : Float ) return Float is
   begin
      return Random (G, -X1, X1);
   end Random;

   procedure Random ( G : Generator; X1, X2 : Float; A : out Matrix) is
   begin
      for I1 in A'Range(1) loop
         for I2 in A'Range(2) loop
            A (I1, I2) := Random (G, X1, X2);
         end loop;
      end loop;
   end;

   procedure Random ( G : Generator; X1 : Float; A : out Matrix) is
   begin
      Random (G, -X1, X1, A);
   end;

   procedure Random ( G : Generator; X1, X2 : Float; X : out Vector) is
   begin
      for I in X'Range loop
         X (I) := Random (G, X1, X2);
      end loop;
   end;

   procedure Random ( G : Generator; X1 : Float; X : out Vector) is
   begin
      for I in X'Range loop
         X (I) := Random (G, -X1, X1);
      end loop;
   end;


   procedure Put_Sign_Space (Item : Float; Fore : Field; Aft : Field; Exp : Field) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      if Item >= 0.0 then
         Put (" ");
      end if;
      Put (Item, Fore, Aft, Exp);
   end;


   procedure Put (A : Matrix; Fore : Field; Aft : Field; Exp : Field) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for I in A'Range (1) loop
         for J in A'Range (2) loop
            Put (A (I,J), Fore, Aft, Exp);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Put (A : Vector; Fore : Field; Aft : Field; Exp : Field) is
      use Ada.Text_IO;
      use Ada.Float_Text_IO;
   begin
      for I in A'Range loop
         Put (A (I), Fore, Aft, Exp);
      end loop;
   end;

end Mathematics;
