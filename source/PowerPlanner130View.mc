import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Application.Storage;

class PowerPlanner130View extends WatchUi.DataField
{
	hidden var _width as float;
	hidden var _currentSegment as Number;
    hidden var _currentPower as Float;
    hidden var _segmentPowerSum as Float;
    hidden var _powerRange as Float;
    hidden var _segmentDistanceRemaining as Float;
    hidden var _segmentSamples as Number;
    hidden var _segmentData as Array;

    function initialize()
    {
		Storage.setValue("PowerPlan1", "000.16,122;000.24,172;000.49,209;000.67,235;001.29,192;001.43,287;001.50,149;001.63,135;002.12,205;002.75,209;002.93,292;003.07,126;003.31,217;003.42,290;004.48,203;004.78,277;004.94,268;005.10,171;005.24,173;005.44,252;005.59,234;005.81,241;005.86,224;006.47,192;006.62,164;006.86,279;007.07,185;007.53,220;007.82,281;007.91,263;008.70,169;009.57,179;010.57,216;011.13,204;012.65,240;013.04,193;013.40,269;013.65,221;013.97,136;014.34,287;014.85,180;015.41,197;015.75,247;016.05,283;016.16,281;016.59,189;016.66,250;016.81,273;016.95,151;017.64,197;018.08,245;018.68,239;018.95,244;019.31,197;019.85,177;019.96,159;020.13,269;020.25,282;020.68,149;021.09,176;021.20,218;021.89,247;022.00,240;022.20,188;022.46,236;022.74,143;023.03,291;023.26,203;023.93,180;024.69,249;024.94,185;025.18,150;025.87,209;026.29,257;026.47,264;027.11,187;027.26,290;027.44,140;027.67,268;028.20,172;028.41,285;028.65,148;029.02,299;029.53,222;029.64,253;030.00,168;030.29,281;031.11,205;031.56,261;032.15,206;032.60,145;033.16,217;033.97,192;034.74,253;035.27,238;036.09,193;036.40,283;036.74,259;037.38,158;038.85,214");
		Storage.setValue("PowerPlan2", "039.42,242;040.89,204;041.94,247;042.85,186;044.13,219;044.53,182;045.02,200;046.70,220;046.95,193;047.34,271;048.53,196;049.36,258;049.69,117;049.89,277;050.16,172;050.49,196;050.95,266;052.29,209;053.34,199;053.81,241;053.94,276;054.67,205;054.93,279;055.40,188;055.69,181;055.99,285;056.41,157;056.89,229;057.28,168;058.65,262;058.86,257;059.34,197;059.75,137;060.37,218;060.70,282;060.82,290;061.26,177;061.75,150;062.55,228;063.00,252;063.07,225;063.32,153;063.59,224;065.01,212;065.29,223;065.79,197;066.31,202;066.69,235;067.26,290;067.62,230;067.87,155;067.99,294;068.95,232;069.31,158;069.91,274;070.62,150;071.48,209;073.16,204;073.31,280;073.88,254;074.47,143;075.51,195;076.07,232;076.38,295;076.74,145;076.96,292;077.09,279;077.93,183;078.19,150;078.37,291;078.52,115;079.14,214;079.45,197;080.24,271;081.28,233;081.57,180;081.77,190;082.48,236;082.54,179;082.95,168;084.14,216;084.45,254;084.77,286;085.39,187;085.46,150;085.64,000;086.37,252;086.43,258;087.46,221;087.69,293;087.80,182;088.08,166;088.78,219;089.25,202;089.56,170;090.33,183;090.88,224;093.07,218;093.37,282;093.47,235");
		Storage.setValue("PowerPlan3", "094.04,228;094.15,187;094.93,198;095.12,206;095.86,229;096.32,241;096.50,205;096.72,170;096.85,220;097.13,233;097.20,239;097.40,233;999.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000");
		Storage.setValue("PowerPlan4", "000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000");
		Storage.setValue("PowerPlan5", "000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000;000.00,000");
		
		_segmentData = new[1000];
		parsePlan(Storage.getValue("PowerPlan1"), 0);
		parsePlan(Storage.getValue("PowerPlan2"), 200);
		parsePlan(Storage.getValue("PowerPlan3"), 400);
		parsePlan(Storage.getValue("PowerPlan4"), 600);
		parsePlan(Storage.getValue("PowerPlan5"), 800);
        
        // basic init
        DataField.initialize();
        _currentSegment = 0;
        _currentPower = -1000.0f;
        _segmentPowerSum = 0.0f;
        _segmentSamples = 0;
        _segmentDistanceRemaining = _segmentData[2 * _currentSegment];
        _powerRange = 80.0f;
    }
    
    function parsePlan(planPart as Text, j as number) as Void
    {
    	for(var i = 0; i < 100; i++)
		{
			var dist = planPart.substring(i * 11, i * 11 + 6);
			var pwr = planPart.substring(i * 11 + 7, i * 11 + 10);
			_segmentData[j] = dist.toFloat(); j++;
			_segmentData[j] = pwr.toFloat(); j++;
		}
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
        midView.locY = indView.locY + 6;
        (midView as Text).setColor(Graphics.COLOR_BLACK);
        midView.setText("*");
        
        var valueView = View.findDrawableById("value");
        valueView.locY = valueView.locY + 10;
        (valueView as Text).setColor(Graphics.COLOR_BLACK);
        
        _width = dc.getWidth();
    }

    // The given info object contains all the current workout information. Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void
    {
    	// sanity checks
        if(!(info has :currentPower)) { return; }
        var alpha = _currentPower > 0 ? 0.9f : 0.0f;
        _currentPower = info.currentPower != null ? (1.0f - alpha) * (info.currentPower as Float) + alpha * _currentPower : 0.0f;
        if(!(info has :elapsedDistance)) { return; }
        var elapsedKm = info.elapsedDistance != null ? info.elapsedDistance * 0.001f : 0.0f;
        if(elapsedKm == 0) { return; }
        
        // check segment
        if(elapsedKm > _segmentData[2 * _currentSegment])
        {
        	_segmentPowerSum = 0;
        	_segmentSamples = 0;
        	if(_currentSegment < _segmentData.size() / 2 - 1) { _currentSegment += 1; }
        }
        
        // update values
        _segmentPowerSum += (info.currentPower as Float);
        _segmentSamples += 1;
        _segmentDistanceRemaining = _segmentData[2 * _currentSegment] - elapsedKm;
    }

    // Display the value you computed here. This will be called once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void
    {
    	// set the background color
        (View.findDrawableById("Background") as Text).setColor(Graphics.COLOR_WHITE);
          
        // set indicator
        var tgtPower = _segmentData[2 * _currentSegment + 1];
        var powerLoc = (_currentPower - tgtPower + 0.5f * _powerRange) / _powerRange;
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
