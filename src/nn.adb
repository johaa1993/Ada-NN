package body NN is

   function Activation (X : Float) return Float is
   begin
      return Tanh (X);
   end;

   function Activation_Derivative_Reuse (X : Float) return Float is
   begin
      return Tanh_Derivative_Reuse (X);
   end;

   procedure Forward ( X : Vector; W : Matrix; Y : out Vector ) is
   begin
      for I in W'Range (2) loop
         Y (I) := Activation (Dot1 (W, X, I));
      end loop;
   end;

   procedure Error ( T, Y : Vector; E, D : out Vector ) is
   begin
      for I in D'Range loop
         E (I) := T (I) - Y (I);
         D (I) := Activation_Derivative_Reuse (Y (I)) * E (I);
      end loop;
   end;

   procedure Backpropagate ( W : Matrix; D : Vector; Y : Vector; Result : out Vector) is
   begin
      for I in W'Range (1) loop
         Result (I) := Activation_Derivative_Reuse (Y (I)) * Dot2 (W, D, I);
      end loop;
   end;


   procedure Adjust ( Y1 : Vector; W, M : in out Matrix; D2 : Vector; LR, MR : Float) is
      -- C : Float;
   begin
      for I in W'Range (1) loop
         for J in W'Range (2) loop
            -- C := D2 (J) * Y1 (I);
            -- W (I, J) := W (I, J) + (LR * C) + (MR * M (I, J));
            M (I, J) := (LR * D2 (J) * Y1 (I)) + (MR * M (I, J));
            W (I, J) := W (I, J) + M (I, J);
         end loop;
      end loop;
   end Adjust;

end NN;
