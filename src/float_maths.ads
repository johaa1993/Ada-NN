with Ada.Numerics.Elementary_Functions;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;

package Float_Maths is

   type Vector is array (Positive range <>) of Float;
   type Matrix is array (Positive range <>, Positive range <>) of Float;

   procedure Random (M : out Matrix; A, B : Float);

   function Sigmoid ( X : Float ) return Float;
   function Sigmoid_dd ( X : Float ) return Float;
   function Tanh_dd ( X : Float ) return Float;

   function Dot1 ( M : Matrix; V : Vector; R : Positive ) return Float;
   function Dot2 ( M : Matrix; V : Vector; R : Positive ) return Float;

   procedure Put ( M : Matrix );
   procedure Put ( V : Vector );

   function Tanh( X : Float ) return Float is (Ada.Numerics.Elementary_Functions.Tanh(X));


   function Random ( G : Generator; A, B : Float ) return Float;

end;
