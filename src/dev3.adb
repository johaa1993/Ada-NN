with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Command_Line; use Ada.Command_Line;


with Mathematics; use Mathematics;
with Text; use Text;
with NN2; use NN2;


procedure Dev3 is

   generic
      type Index is (<>);
      with function Get (I : Index) return String;
   package Theta is
      subtype Vector is Mathematics.Vector (Index'Pos (Index'First)+1 .. Index'Pos (Index'Last)+1);
   end Theta;


begin




   null;
end;
