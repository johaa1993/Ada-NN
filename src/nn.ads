with Ada.Numerics;
with Ada.Numerics.Float_Random;


package NN is

   subtype Generator is Ada.Numerics.Float_Random.Generator;

   type Nodation is new Float;
   type Weight is new Float;
   type Descent is new Float;
   type Net is array (Integer range <>, Integer range <>) of Weight;
   type Gradient is array (Integer range <>) of Descent;
   type Layer is array (Integer range <>) of Nodation;

   procedure Randomize (G : Generator; A, B : Weight; W : out Net);

   generic
      with function Activate (X : Float) return Float;
   function Forward_Single (X : Layer; W : Net; I : Integer) return Nodation;

   generic
      with function Activate (X : Float) return Float;
   procedure Forward (X : Layer; W : Net; Y : out Layer);

   generic
      with function Activate (X : Float) return Float;
   function Backpropagate_Single (D : Gradient; W : Net; A : Layer; I : Integer) return Descent;

   generic
      with function Activate (X : Float) return Float;
   procedure Backpropagate (D : Gradient; W : Net; A : Layer; R : out Gradient);

   procedure Adjust (LR : Float; MR : Float; DR : Float; X : Layer; D : Gradient; W : in out Net; M : in out Net);

   generic
      with function Activate (X : Float) return Float;
   procedure Error (T : Layer; Y : Layer; E : out Layer; D : out Gradient);


   function Activate_Tanh (X : Float) return Float;
   function Activate_Tanh_Derivative (X : Float) return Float;

end NN;
