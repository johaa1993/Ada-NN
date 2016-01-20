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

   procedure Backpropagate ( W : Matrix; D : Vector; Y : Vector; R : out Vector) is
   begin
      for I in W'Range (1) loop
         R (I) := Activation_Derivative_Reuse (Y (I)) * Dot2 (W, D, I);
      end loop;
   end;


   procedure Adjust (LR, MR : Float; X : Vector; D : Vector; W, M : in out Matrix) is
   begin
      for I in W'Range (1) loop
         for J in W'Range (2) loop
            M (I, J) := (LR * D (J) * X (I)) + (MR * M (I, J));
            W (I, J) := W (I, J) + M (I, J);
         end loop;
      end loop;
   end Adjust;

   procedure Adjust_2 (Learning_Rate, Momemtum_Rate : Float; Input : Vector; Error : Vector; W, M : in out Matrix) is
   begin
      for I in W'Range (1) loop
         for J in W'Range (2) loop
            M (I, J) := (Learning_Rate * Error (J) * Input (I)) + (Momemtum_Rate * M (I, J));
            W (I, J) := W (I, J) + M (I, J);
         end loop;
      end loop;
   end;


end NN;
