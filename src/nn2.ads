with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Mathematics; use Mathematics;
with NN; use NN;



package NN2 is

   type Matrix_Access is access all Matrix;
   type Vector_Access is access all Vector;

   type Matrix_Access_Array is array (Positive range <>) of Matrix_Access;
   type Vector_Access_Array is array (Positive range <>) of Vector_Access;

   type Network (N : Natural; O : Natural) is record
      W : Matrix_Access_Array (2 .. N);
      M : Matrix_Access_Array (2 .. N);
      Y : Vector_Access_Array (1 .. N);
      D : Vector_Access_Array (1 .. N);
      T : Vector (1 .. O);
   end record;

   type Topology is array (Positive range <>) of Natural;

   procedure Train (N : in out Network; LR, MR : Float; X : Vector; T : Vector; E : out Vector);

   function Create ( L,B : Topology; G : Generator; WAB : Float ) return Network;

--     procedure Put ( N : Network );

end NN2;
