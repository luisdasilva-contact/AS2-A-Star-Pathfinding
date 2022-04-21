class pathfinding.Path {
	public var length:Number = -1;
    public var bestCase:Number = -1;
    public var nodes:Array;
	private var _path:Array;
	
	public function Path($length:Number, $bestCase:Number, $path:Array) {
		if (!$length){
			length = -1;
		} else {
		length = $length;
		}
		
		if (!$bestCase){
			bestCase = -1;
		} else {
			bestCase = $bestCase;
		}
		
		if (!$path){
			_path = new Array();
		} else {
			_path = $path;
		}			
    }
	
	public function destroy():Void {
		_path = null;
		nodes = null;
    }
	public function clone():Path {
		return new Path(length, bestCase, _path.slice());
    }
	
	public function get hasLength():Boolean {
		return length + bestCase >= 0;
    }
	
	public function get lastElement():String {
		return _path.slice(-1)[0];
    }
	
	public function containsNode($id:String):Boolean {
        return _path.indexOf($id) > -1;
    }
	
	public function addNode($id:String):Void {
        if (!containsNode($id)){
			_path.push($id);
		}
    }
	
	public function getPath():Array{
		return _path;
	}
	
	public function toString():String {
        return "[Path] length:"+ length +", nodes:("+ _path +")";
    }
}