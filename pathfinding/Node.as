import flash.geom.Point;
import pathfinding.*;

class Node extends Point {
	public var id:String = "";	
	private var _neighbors:Array;
	
	public function Node(key:String, x:Number, y:Number, neighbors:Array) {
		super(x, y);
		if (!key){
			key = "";
		}
		if (!x){
			x = 0;
		}
		
		if (!y){
			y = 0;
		}	
		
		id = key;
		_neighbors = neighbors;
    }
	
	public function cloneNode():Node {
		var node:Node = new Node(id, x, y, _neighbors);
		
		// shouldn't need parseNeighbors & addNeighbor because of neighbors arg
		// in Node 
		return node;
	}
	
	public function getNeighbor(index:Number):String{
		if ((index >= 0) && (index < _neighbors.length)){
			return _neighbors[index];
		};
        return null;
	};
	
	public function get numNeighbors():Number{
		return _neighbors.length;
	};
	
	public function containsNeighbor(id:String):Boolean{
		return _neighbors.indexOf(id) > -1;
	}
	
	public function expandNamespace(key:String):Void {
		/* Appends an additional namespace key onto all Node references.
		Avoids conflicts during Grid unions.*/
		id += key;
		for (var j = 0; j < _neighbors.length; j++){
			_neighbors[j] += key;
		}	
	}
	
	public function toString():String {
		return "[Node] id:"+ id +", x:" + x + ", y:" + y + 
		", neighbors:(" + _neighbors + ")";
	}
}