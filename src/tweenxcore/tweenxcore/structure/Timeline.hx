package tweenxcore.structure;
using tweenxcore.Tools;

class Timeline<T>
{
    var totalWeight:Float;
    var dataArray:Array<T>;
    var weightArray:Array<Float>;

    public var length(get, null):Int;

    function get_length():Int
    {
        return dataArray.length;
    }

    public inline function new()
    {
        this.dataArray = [];
        this.weightArray = [];
        totalWeight = 0;
    }

    public inline function add(data:T, weight:Float = 1.0):Timeline<T>
    {
        if (weight <= 0) {
            throw "weight must be positive number";
        }
        if (dataArray.length == 0) {
            totalWeight = weight;
        } else {
            weightArray.push(totalWeight);
            totalWeight += weight;
        }
        dataArray.push(data);
        return this;
    }

    public inline function searchByRate(rate:Float, boundaryMode:BoundaryMode = BoundaryMode.Left):TimelineSeachResult<T>
    {
        if (dataArray.length == 0) {
            throw "timeline is not initialized";
        }

        var searchResult = weightArray.binarySearch(rate * totalWeight, boundaryMode);
        var baseWeight = if (searchResult == 0) {
            0;
        } else {
            weightArray[searchResult - 1] / totalWeight;
        }

        var nextWeight = if (searchResult == dataArray.length - 1) {
            1;
        } else {
            weightArray[searchResult] / totalWeight;
        }

        return new TimelineSeachResult(
            dataArray[searchResult],
            searchResult,
            baseWeight,
            nextWeight
        );
    }

    public inline function dataAt(index:Int):T
    {
        if (dataArray.length == 0) {
            throw "timeline is not initialized";
        }
        return dataArray[index];
    }
}
