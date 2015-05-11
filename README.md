# NN-Ada
A simple neural network written in Ada.

## Types

The weight matrix is the learning knowledge.
It's actualy a matrix transformation from layer to layer.

```Ada
type Weight_Matrix is array (Positive range <>, Positive range <>) of Weight;
W : NN.Weight_Matrix (1 .. 3, 1 .. 2);
```

The `W` variable means:
* Mathematically it means `T(x) = Wx, T : R^3 -> R^2`.
* Neurologically it means a layer with 3 nodes to a layer with 2 nodes.
* `W(3,2)` means the weight of the connection between neuron 3 to neuron 2 of respective layer.

## Procedures

The procedures arguments is written so that (arg1,arg2,arg3) means (layer1,weights between layer1 and layer2, layer2)

```Ada
procedure Forward ( X : Float_Array; W : Weight_Matrix; L : out Layer );
procedure Forward ( A : Layer; W : Weight_Matrix; B : out Layer );

procedure Backpropagation ( A : out Layer; W : Weight_Matrix; B : Layer );

procedure Adjust ( X : Float_Array; W : in out Weight_Matrix; B : Layer );
procedure Adjust ( A : Layer; W : in out Weight_Matrix; B : Layer );
```
