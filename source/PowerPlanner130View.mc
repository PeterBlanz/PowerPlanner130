import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Application.Storage;

class PowerPlanner130View extends WatchUi.DataField
{
	hidden var _width as Float;
	hidden var _alpha as Float;
	hidden var _distanceIndex as Number;
    hidden var _filteredPower as Float;
    hidden var _segmentPowerSum as Float;
    hidden var _segmentDistanceRemaining as Float;
    hidden var _segmentSamples as Number;
    hidden var _segmentData as Array;

    function initialize()
    {
		// basic init
        DataField.initialize();
		
		// parse power plan
		_segmentData = new[1000];
		var segInd = 0;
		segInd = parsePlan(Application.getApp().getProperty("planPart01"), segInd);
		segInd = parsePlan(Application.getApp().getProperty("planPart02"), segInd);
		segInd = parsePlan(Application.getApp().getProperty("planPart03"), segInd);
		segInd = parsePlan(Application.getApp().getProperty("planPart04"), segInd);
		segInd = parsePlan(Application.getApp().getProperty("planPart05"), segInd);
        
        // initialize variables
        _alpha = Application.getApp().getProperty("filtering");
        _distanceIndex = 0;
        _filteredPower = -1000.0f;
        _segmentPowerSum = 0.0f;
        _segmentSamples = 0;
        _segmentDistanceRemaining = _segmentData[0];
    }
    
    function parsePlan(planPart as String, segInd as number) as Number
    {
    	var charArr = planPart.toCharArray();
    	var i as Number = 0;
    	var j as Number = 0;
    	var len as Number = charArr.size();
    	while(i < len)
		{
			j = i + 1;
			while(j < len)
			{
				if(charArr[j] == ',' || charArr[j] == ';') { break; }
				j++;
			}
			_segmentData[segInd] = planPart.substring(i, j).toFloat();
			i = j + 1;
			segInd++;
		}
		return segInd;
    }

    // Set your layout here.
    function onLayout(dc as Dc) as Void
    {
        View.setLayout(Rez.Layouts.MainLayout(dc));
        
        var indView = View.findDrawableById("indicator");
        indView.locY = indView.locY - 16;
        (indView as Text).setColor(Graphics.COLOR_BLACK);
        indView.setText("|");
        
        var midView = View.findDrawableById("midpoint");
        midView.locY = indView.locY + 1;
        (midView as Text).setColor(Graphics.COLOR_BLACK);
        midView.setText(">> <<");
        
        var valueView = View.findDrawableById("value");
        valueView.locY = valueView.locY + 13;
        (valueView as Text).setColor(Graphics.COLOR_BLACK);
        
        _width = dc.getWidth();
    }

    // The given info object contains all the current workout information. Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void
    {
    	// calculate filtered power
        if(!(info has :currentPower)) { return; }
        var alpha = _filteredPower > 0 ? _alpha : 0.0f;
        var currentPower as Float = info.currentPower != null ? info.currentPower as Float : 0.0f;
        _filteredPower = (1.0f - alpha) * currentPower + alpha * _filteredPower;
        
        // calculate remaining distance
        if(!(info has :elapsedDistance)) { return; }
        var elapsedKm = info.elapsedDistance != null ? info.elapsedDistance * 0.001f : 0.0f;
        var newRemaining as Float = _segmentData[_distanceIndex] - elapsedKm;
        if(newRemaining == _segmentDistanceRemaining) { return; }
        
        // check segment, update values
        if(newRemaining < 0)
        {
        	_segmentPowerSum = currentPower;
        	_segmentSamples = 1;
        	if(_distanceIndex < _segmentData.size() - 2)
        	{
        		_distanceIndex += 2;
        		newRemaining = _segmentData[_distanceIndex] - elapsedKm;
        	}
        }
        else
        {
	        _segmentPowerSum += currentPower;
	        _segmentSamples += 1;
        }
        _segmentDistanceRemaining = newRemaining;
    }

    // Display the value you computed here. This will be called once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void
    {
    	// set the background color
        (View.findDrawableById("Background") as Text).setColor(Graphics.COLOR_WHITE);
          
        // set indicator
        var tgtPower = _segmentData[_distanceIndex + 1];
        var powerLoc = (_filteredPower - tgtPower) / 100 + 0.5f;
        if(powerLoc < 0.0f) { powerLoc = 0.0f; }
        else if(powerLoc > 1.0f) { powerLoc = 1.0f; } 
        View.findDrawableById("indicator").locX = 10 + powerLoc * (_width - 20);
        
        // set value
        var avgPower =  _segmentSamples > 0 ? _segmentPowerSum / _segmentSamples : 0.0f;
        var value = View.findDrawableById("value") as Text;
        value.setText(avgPower.format("%.0f") + "/" + tgtPower.format("%.0f") + "  " +  _segmentDistanceRemaining.format("%.2f"));

        // call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
