package NN is

   Learning_Rate : Float := 0.5;

   subtype Weight is Float;

   type Weight_Matrix is array (Positive range <>, Positive range <>) of Weight;

   type Float_Array is array (Positive range <>) of Float;

   type Layer (N : Positive) is record
      D : Float_Array (1 .. N) := (others => 0.0);
      S : Float_Array (1 .. N) := (others => 0.0);
      Z : Float_Array (1 .. N) := (others => 0.0);
      Y : Float_Array (1 .. N) := (others => 0.0);
   end record;


   procedure Forward ( X : Float_Array; W : Weight_Matrix; L : out Layer );
   procedure Forward ( A : Layer; W : Weight_Matrix; B : out Layer );

   procedure Backpropagation ( A : out Layer; W : Weight_Matrix; B : Layer );

   procedure Adjust ( X : Float_Array; W : in out Weight_Matrix; B : Layer );
   procedure Adjust ( A : Layer; W : in out Weight_Matrix; B : Layer );

   procedure Random ( W : out Weight_Matrix );

end NN;
