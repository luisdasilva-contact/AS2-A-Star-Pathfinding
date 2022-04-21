import flash.geom.Point;
import pathfinding.*;

class pathfinding.Grid extends Object {	
	 private var _nodes:Object;

	public function Grid() {
		super();		
		this._nodes = new Object();
	};
	
	public function parseXML(ptArray:Array):Void {
		for (var i = 0; i < ptArray.length; i++){
			var pt = ptArray[i];			
			var node:Node = new Node(pt.id, pt.x, pt.y, pt.connected);
			_nodes[node.id] = node;
		};		
	};
	
	public function getNodeById(id:String):Node {
		if (_nodes[id] != undefined){
			return _nodes[id];
		}
		return null;
    }
	
	public function findPath(startId:String, goalId:String):Path {
		var stack:Array = new Array(new Path(0, 0, [startId]));
		var best:Path = new Path();
		var reachedNodes:Object = new Object();
		var cyc:Number = 0;
		 while (stack.length > 0) {
			 var searchPath = stack.shift();
			 var searchNode:Node = getNodeById(searchPath.lastElement);
			 
			 for (var j = 0; j < searchNode.numNeighbors; j++){
				 var branch:Path = searchPath.clone();
				 var expandNode:String = searchNode.getNeighbor(j);
				 if (!branch.containsNode(expandNode)) {
					var prevCoord:Node = getNodeById(branch.lastElement);
					var currentCoord:Node = getNodeById(expandNode);
					var goalCoord:Node = getNodeById(goalId);
					branch.addNode(expandNode);
					branch.length += Point.distance(prevCoord, currentCoord);
                    branch.bestCase = branch.length + Point.distance(currentCoord, goalCoord);
					var shortest:Number = reachedNodes[expandNode];
					if (isNaN(shortest)){
						shortest = branch.length;
					}
					
					if (branch.length <= shortest && (!best.hasLength || branch.bestCase < best.length)) {
                            reachedNodes[expandNode] = branch.length;

                            // If the expansion node is the goal, save branch as the parth to beat.
                            // Otherwise, add the branch back into the search stack.
                            if (expandNode == goalId){
								best = branch;
							} else {
								stack.push(branch);
							}
                    }					 
				 }
			 }
			 var priority:Function = function(a:Path, b:Path):Number {
				if (a.bestCase < b.bestCase){
					return -1;
				} else if (a.bestCase > b.bestCase) {
					return 1;
				}  else {
					return 0;
				}
			}
			stack.sort(priority);
			cyc++;
		
		
		 }
		return best;
	}
}