with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Text_IO; use Ada.Text_IO;

package Mathematics is

   generic
      type Index is range <>;
      type Element is digits <>;
      type Matrix is array (Index range <>, Index range <>) of Element;
   procedure Put_Matrix (A : Matrix; Fore : Field; Aft : Field; Exp : Field);

   generic
      type Index is range <>;
      type Element is digits <>;
      type Vector is array (Index range <>) of Element;
   procedure Put_Vector (A : Vector; Fore : Field; Aft : Field; Exp : Field);

end Mathematics;
