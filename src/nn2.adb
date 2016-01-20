with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body NN2 is


   procedure Target ( N : out Network; T : Vector ) is
   begin
      N.T (1 .. T'Length) := T;
   end;

   procedure Input ( N : out Network; X : Vector ) is
   begin
      N.Y (N.Y'First).all (1 .. X'Length) := X;
   end;

   procedure Forward ( N : in out Network ) is
   begin
      for I in 2 .. N.N loop
         Forward (N.Y (I - 1).all, N.W (I).all, N.Y (I).all);
      end loop;
   end Forward;

   procedure Train (N : in out Network; LR, MR : Float; X : Vector; T : Vector; E : out Vector) is
   begin

      --Calculate error of last layer using target.
      Error (T, N.Y (N.Y'Last).all, E, N.D (N.D'Last).all);

      --Calculate error throgh the entire network.
      for I in reverse 2 .. N.N loop
         Backpropagate (N.D (I-1).all, N.Y (I-1).all, N.W (I).all, N.D (I).all);
      end loop;

      --Set new wieghts.
      for I in 2 .. N.N loop
         Adjust (N.Y (I - 1).all, N.W (I).all, N.M (I).all, N.D (I).all, LR, MR);
      end loop;

   end;


   function Create ( L, B : Topology; G : Generator; WAB : Float ) return Network is
      N : Network (L'Length, L (L'Last));
   begin

      --Create new layers.
      for I in 1 .. N.N loop

         --Create layers for output and delta with enough nodes to hold biases also.
         N.Y (I) := new Vector (1 .. L (I) + B (I));
         N.D (I) := new Vector (1 .. L (I) + B (I));

         --Set bias node output to constant.
         if B (I) > 0 then
            N.Y (I).all (L (I)+1 .. N.Y (I)'Last) := (others => 1.0);
         end if;

      end loop;

      --Create new moment and wieght matrices.
      for I in 2 .. N.N loop

         N.W (I) := new Matrix (1 .. L (I - 1) + B (I - 1), 1 .. L (I));
         N.M (I) := new Matrix (1 .. L (I - 1) + B (I - 1), 1 .. L (I));

         --Randomize the weights.
         Random (G, WAB, N.W (I).all);

         --Moment matrix can begin at 0 speed.
         N.M (I).all := (others => (others => 0.0));

      end loop;

      return N;
   end;

--     procedure Put ( N : Network ) is
--     begin
--        for I in 2 .. N.N loop
--           Put ( "T" & N.W (I)'Length (1)'Img & " x" & N.W (I)'Length (2)'Img);
--           New_Line;
--           Put (N.W (I).all);
--           New_Line;
--        end loop;
--
--        for I in 1 .. N.N loop
--           Put ( "L" & N.Y (I)'Length'Img);
--           New_Line;
--           Put (N.Y (I).all);
--           New_Line;
--        end loop;
--     end Put;

end NN2;
