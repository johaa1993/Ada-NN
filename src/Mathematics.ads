with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Text_IO; use Ada.Text_IO;

package Mathematics is

   function Sigmoid ( X : Float ) return Float;
   function Sigmoid_Derivative ( X : Float ) return Float;
   function Sigmoid_Derivative_Reuse ( X : Float ) return Float;

   function Tanh ( X : Float ) return Float;
   function Tanh_Derivative ( X : Float ) return Float;

   -- Use this if X is Tanh (X')
   function Tanh_Derivative_Reuse ( X : Float ) return Float;

   function Map ( X, X1, X2, Y1, Y2 : Float ) return Float;


   type Vector is array (Integer range <>) of Float;
   type Matrix is array (Integer range <>, Integer range <>) of Float;

   function Dot1 ( A : Matrix; X : Vector; I2 : Positive ) return Float with
   Pre => X'First <= A'First (1) and X'Last >= A'Last (1);

   function Dot2 ( A : Matrix; X : Vector; I1 : Positive ) return Float;

   function Random ( G : Generator; X1, X2 : Float ) return Float;
   function Random ( G : Generator; X1 : Float ) return Float;
   procedure Random ( G : Generator; X1, X2 : Float; A : out Matrix);
   procedure Random ( G : Generator; X1 : Float; A : out Matrix);

   procedure Random ( G : Generator; X1, X2 : Float; X : out Vector);
   procedure Random ( G : Generator; X1 : Float; X : out Vector);


   procedure Put (A : Matrix; Fore : Field; Aft : Field; Exp : Field);
   procedure Put (A : Vector; Fore : Field; Aft : Field; Exp : Field);

end Mathematics;
