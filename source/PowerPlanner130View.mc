import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;

class PowerPlanner130View extends WatchUi.DataField
{
	hidden var _currentSegment as Number;
    hidden var _currentPower as Float;
    hidden var _segmentPowerSum as Float;
    hidden var _segmentSamples as Number;
    hidden var _segmentData as Array;

    function initialize()
    {
    	// basic init
        DataField.initialize();
        _currentSegment = 0;
        _currentPower = 0.0f;
        _segmentPowerSum = 0.0f;
        _segmentSamples = 0;
        
        // create power segments
        _segmentData = new[20];
        _segmentData[0] = 100f;
        _segmentData[1] = 0.1f;
        _segmentData[2] = 105f;
        _segmentData[3] = 0.2f;
        _segmentData[4] = 110f;
        _segmentData[5] = 0.3f;
        _segmentData[6] = 115f;
        _segmentData[7] = 0.4f;
        _segmentData[8] = 120f;
        _segmentData[9] = 0.5f;
        _segmentData[10] = 125f;
        _segmentData[11] = 0.6f;
        _segmentData[12] = 130f;
        _segmentData[13] = 0.7f;
        _segmentData[14] = 135f;
        _segmentData[15] = 0.8f;
        _segmentData[16] = 140f;
        _segmentData[17] = 0.9f;
        _segmentData[18] = 145f;
        _segmentData[19] = 1.0f;
        
        
    }

    // Set your layout here. Anytime the size of obscurity of
    function onLayout(dc as Dc) as Void
    {
        var obscurityFlags = DataField.getObscurityFlags();

        // quadrant layouts
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT))
        {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));
        }
        else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT))
        {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));
        }
        else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT))
        {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));
        }
        else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT))
        {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));
        }

        // generic, centered layout
        else
        {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            var labelView = View.findDrawableById("label");
            labelView.locY = labelView.locY - 16;
            var valueView = View.findDrawableById("value");
            valueView.locY = valueView.locY + 7;
        }

        (View.findDrawableById("label") as Text).setText("TODO");
    }

    // The given info object contains all the current workout information. Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no guarantee that compute() will be called before onUpdate().
    function compute(info as Activity.Info) as Void
    {
        if(!(info has :currentPower && info has :elapsedDistance)) { return; }
        
        
        _currentPower = info.currentPower != null ? info.currentPower as Float : 0.0f;
        var elapsedKm = info.elapsedDistance * 0.001f;
        
        if(elapsedKm > _segmentData[2 * _currentSegment + 1])
        {
        	_segmentPowerSum = 0;
        	_segmentSamples = 0;
        	if(_currentSegment < _segmentData.size() / 2 - 1) { _currentSegment += 1; }
        }
        _segmentPowerSum += _currentPower;
        _segmentSamples += 1;
        
    }

    // Display the value you computed here. This will be called once a second when the data field is visible.
    function onUpdate(dc as Dc) as Void
    {
        // Set the background color
        (View.findDrawableById("Background") as Text).setColor(getBackgroundColor());

        // Set the foreground color and value
        var value = View.findDrawableById("value") as Text;
        if (getBackgroundColor() == Graphics.COLOR_BLACK)
        {
            value.setColor(Graphics.COLOR_WHITE);
        }
        else
        {
            value.setColor(Graphics.COLOR_BLACK);
        }
        value.setText(_currentPower.format("%.2f"));

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
    }

}
