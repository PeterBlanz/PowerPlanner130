import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Application.Storage;

class PowerPlanner130View extends WatchUi.DataField
{
	hidden var _width as Float;
	hidden var _powerBias as Float;
	hidden var _speedBias as Float;
	hidden var _distanceIndex as Number;
    hidden var _segmentAvgPower as Float;
    hidden var _segmentAvgSpeed as Float;
    hidden var _segmentDistanceRemaining as Float;
    hidden var _segmentSamples as Number;
    hidden var _segmentData as Array;
    hidden var _nData as Number;

    function initialize()
    {
		// basic init
        DataField.initialize();
		
		// parse power plan
		_segmentData = new[1500];
		_nData = 0;
		parsePlan(Application.getApp().getProperty("planPart01"));
		parsePlan(Application.getApp().getProperty("planPart02"));
		parsePlan(Application.getApp().getProperty("planPart03"));
		parsePlan(Application.getApp().getProperty("planPart04"));
		parsePlan(Application.getApp().getProperty("planPart05"));
        
        // initialize variables
        _powerBias = Application.getApp().getProperty("powerBias");
        _speedBias = Application.getApp().getProperty("speedBias");
        _distanceIndex = 0;
        _segmentSamples = 0;
        _segmentAvgSpeed = 0.0f;
        _segmentAvgPower = 0.0f;
        _segmentDistanceRemaining = _segmentData[0];
    }
    
    function parsePlan(planPart as String) as Void
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
			_segmentData[_nData] = planPart.substring(i, j).toFloat();
			i = j + 1;
			_nData++;
		}
    }

    // Set your layout here.
    function onLayout(dc as Dc) as Void
    {
        View.setLayout(Rez.Layouts.MainLayout(dc));
        _width = dc.getWidth() * 0.75f;
        
        var segRemView = View.findDrawableById("segmentRemaining");
        
        // set up power display
        var pwrIndView = View.findDrawableById("powerIndicator");
        pwrIndView.locY = segRemView.locY - 15;
        pwrIndView.setText("|");
        var pwrMidView = View.findDrawableById("powerMidpoint");
        pwrMidView.locY = pwrIndView.locY + 1;
        pwrMidView.locX = _width / 2;
        pwrMidView.setText(">> <<");
        var pwrLblView = View.findDrawableById("powerLabel");
        pwrLblView.locY = pwrMidView.locY;
        pwrLblView.setText("P");
        
        // set up speed display
        var spdIndView = View.findDrawableById("speedIndicator");
        spdIndView.locY = segRemView.locY + 15;
        spdIndView.setText("|");
        var spdMidView = View.findDrawableById("speedMidpoint");
        spdMidView.locY = spdIndView.locY + 1;
        spdMidView.locX = pwrMidView.locX;
        spdMidView.setText(">> <<");
        var spdLblView = View.findDrawableById("speedLabel");
        spdLblView.locY = spdMidView.locY;
        spdLblView.setText("S");
    }

    // The given info object contains all the current workout information. Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void
    {
    	// check info
    	if(!(info has :currentPower)) { return; }
        if(!(info has :currentSpeed)) { return; }
        if(!(info has :elapsedDistance)) { return; }
        
    	// get current power and speed
        var currentPower as Float = info.currentPower != null ? info.currentPower * 1.0f : 0.0f;
        var currentSpeed as Float = info.currentSpeed != null ? info.currentSpeed * 3.6f : 0.0f;
        
        // calculate remaining distance
        var elapsedKm = info.elapsedDistance != null ? info.elapsedDistance * 0.001f : 0.0f;
        var newRemaining as Float = _segmentData[_distanceIndex] - elapsedKm;
        if(newRemaining == _segmentDistanceRemaining) { return; }
        
        // check segment, update values
        if(newRemaining < 0)
        {
	        _segmentSamples = 1;
            _segmentAvgPower = currentPower;
            _segmentAvgSpeed = currentSpeed;
        	while(newRemaining < 0 && _distanceIndex < _nData - 3)
        	{
        		_distanceIndex += 3;
        		newRemaining = _segmentData[_distanceIndex] - elapsedKm;
        	}
        }
        else
        {
	        _segmentAvgPower = (_segmentSamples * _segmentAvgPower + currentPower) / (_segmentSamples + 1);
            _segmentAvgSpeed = (_segmentSamples * _segmentAvgSpeed + currentSpeed) / (_segmentSamples + 1);
	        _segmentSamples += 1;
        }

        _segmentDistanceRemaining = newRemaining;
    }

    // Display the value you computed here. This will be called once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void
    {
    	// set the background color
        (View.findDrawableById("Background") as Text).setColor(Graphics.COLOR_WHITE);
          
        // set power indicator
        var tgtPower as Float = _segmentData[_distanceIndex + 1] + _powerBias;
        var powerLoc as Float = (_segmentAvgPower - tgtPower) / 100.0f + 0.5f;
        if(powerLoc < 0.0f) { powerLoc = 0.0f; }
        else if(powerLoc > 1.0f) { powerLoc = 1.0f; } 
        View.findDrawableById("powerIndicator").locX = 17 + powerLoc * (_width - 34);
        
        // set speed indicator
        var tgtSpeed as Float = _segmentData[_distanceIndex + 2] + _speedBias;
        var speedLoc as Float = (_segmentAvgSpeed - tgtSpeed) / 20.0f + 0.5f;
        if(speedLoc < 0.0f) { speedLoc = 0.0f; }
        else if(speedLoc > 1.0f) { speedLoc = 1.0f; } 
        View.findDrawableById("speedIndicator").locX = 17 + speedLoc * (_width - 34);
        
        // set values
        var segRemView = View.findDrawableById("segmentRemaining") as Text;
        segRemView.setText(_segmentDistanceRemaining.format("%.2f"));

        // call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
