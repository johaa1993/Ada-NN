with Mathematics; use Mathematics;

package NN is

   procedure Forward ( X : Vector; W : Matrix; Y : out Vector );

   procedure Error ( T, Y : Vector; E, D : out Vector );

   -- W is the net.
   -- D is delta error result from W.
   -- Y is input value for net W.
   -- R is delta error for previus layer.
   procedure Backpropagate ( W : Matrix; D : Vector; Y : Vector; R : out Vector);


   -- LR is learning rate.
   -- MR is Momentum rate.
   -- X is input.
   -- D is delta error.
   -- W is net.
   -- M is momentum.
   procedure Adjust (LR, MR, DR : Float; X : Vector; D : Vector; W, M : in out Matrix);


end NN;
