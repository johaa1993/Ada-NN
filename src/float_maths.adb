with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics; use Ada.Numerics;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

package body Float_Maths is

   function Random ( G : Generator; A, B : Float ) return Float is
      D : Float := B - A;
   begin
      Put (D, 3, 3, 0);
      Put (A, 3, 3, 0);
      New_Line;
      return D * Random (G) + A;
   end Random;

   procedure Random (M : out Matrix; A, B : Float) is
      D : Float := B - A;
      G : Generator;
   begin
      Reset (G);
      for I in M'Range (1) loop
         for J in M'Range (2) loop
            M (I, J) := D * Random (G) + A;
         end loop;
      end loop;
   end;

   function Sigmoid ( X : Float ) return Float is
   begin
      return 1.0 / (1.0 + e ** (-X));
   end;

   function Sigmoid_dd ( X : Float ) return Float is
   begin
      return X * (1.0 - X);
   end;

   function Tanh_dd ( X : Float ) return Float is
   begin
      return 1.0 - (X ** 2);
   end;

   function Dot1 ( M : Matrix; V : Vector; R : Positive ) return Float is
      S : Float := 0.0;
   begin
      for I in M'Range (1) loop
         S := S + V (I) * M (I, R);
      end loop;
      return S;
   end;

   function Dot2 ( M : Matrix; V : Vector; R : Positive ) return Float is
      S : Float := 0.0;
   begin
      for I in M'Range (2) loop
         S := S + V (I) * M (R, I);
      end loop;
      return S;
   end;


   procedure Put ( M : Matrix ) is
   begin
      for I in M'Range (1) loop
         for J in M'Range (2) loop
            Put (M (I, J), 3, 3, 0);
         end loop;
         New_Line;
      end loop;
   end;

   procedure Put ( V : Vector ) is
   begin
      for I in V'Range loop
         Put (V (I), 3, 3, 0);
      end loop;
   end;

   procedure Subtract ( A,B : Vector; R : out Vector ) is
   begin
      for I in R'Range loop
         R (I) := A(I) - B(I);
      end loop;
   end;


end Float_Maths;
