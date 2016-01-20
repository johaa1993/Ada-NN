with Mathematics; use Mathematics;

package NN is

   procedure Forward ( X : Vector; W : Matrix; Y : out Vector );

   procedure Error ( T, Y : Vector; E, D : out Vector );

   -- W is the net.
   -- D is delta error for Y.
   -- Y is input value for net W.
   -- Result is delta error for previus layer.
   procedure Backpropagate ( W : Matrix; D : Vector; Y : Vector; Result : out Vector);

   procedure Adjust ( Y1 : Vector; W, M : in out Matrix; D2 : Vector; LR, MR : Float);

end NN;
