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
    	// TEMP!!!!!
		Storage.setValue("PowerPlan1", "0.99,180;3.89,225;4.3,180;7.02,224;8.43,245;8.75,278;9.25,210;9.48,271;9.55,189;9.72,237;9.87,75;10.07,254;10.51,189;11.68,216;11.98,282;12.58,255;12.87,145;13.13,184;14.86,241;15.77,210;15.99,262;16.07,127;16.19,294;16.53,188;17.1,227;17.24,131;17.45,227;17.85,173;18.55,221;18.92,250;19.04,290;19.25,166;20.31,258;20.68,161;20.99,274;21.33,148;22.96,234;23.5,278;24.24,196;25.29,244;25.44,164;25.6,279;27.5,247;28.11,181;28.51,260;29.57,213;29.82,264;30.2,217;30.73,169;32.32,236;34.12,229;34.43,267;35.68,217;36.56,262;37.7,207;38.12,277;38.58,241;40.29,195;40.38,297;41.06,238;41.47,265;41.79,175;42.47,252;42.8,187;43.32,224;43.53,264;43.9,186;46.47,236;46.86,172;47.1,272;47.29,177;47.61,260;47.81,192;48.16,280;48.93,193;50.18,239;50.71,201;55.64,239;60.2,225;60.67,275;61.34,196;62.26,242;63.09,194;65.44,247;67.18,224;67.47,173;68.3,239;68.83,189;69.1,270;69.32,166;69.9,255;70.12,177;70.32,284;70.4,0;71.04,240;71.55,196;72.81,247;73.66,204;74.26,254;74.84,201");
		Storage.setValue("PowerPlan2", "74.97,295;75.18,175;75.49,279;75.63,167;76.35,207;77.57,244;78.56,252;80.01,210;80.71,253;80.77,0;81.37,241;81.48,161;81.54,0;81.61,282;81.76,148;83.19,237;83.34,146;83.58,226;83.92,278;84.89,213;88.82,231;89.28,230;89.51,283;89.68,223;89.99,173;90.66,233;90.92,188;92.38,229;92.58,272;92.94,186;93.7,231;93.86,158;94.09,259;94.19,151;94.29,208;95.93,232;96.12,274;96.83,229;97,185;97.32,231;97.5,280;1000,100");
		Storage.setValue("PowerPlan3", "094.04,228;094.15,187;094.93,198;095.12,206;095.86,229;096.32,241;096.50,205;096.72,170;096.85,220;097.13,233;097.20,239;097.40,233;999.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000");
		Storage.setValue("PowerPlan4", "000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000");
		Storage.setValue("PowerPlan5", "000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000");
		
		// basic init
        DataField.initialize();
		
		// parse power plan
		_segmentData = new[1000];
		var segInd = 0;
		segInd = parsePlan(Storage.getValue("PowerPlan1"), segInd);
		segInd = parsePlan(Storage.getValue("PowerPlan2"), segInd);
		//segInd = parsePlan(Storage.getValue("PowerPlan3"), segInd);
		//segInd = parsePlan(Storage.getValue("PowerPlan4"), segInd);
		//segInd = parsePlan(Storage.getValue("PowerPlan5"), segInd);
        
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
