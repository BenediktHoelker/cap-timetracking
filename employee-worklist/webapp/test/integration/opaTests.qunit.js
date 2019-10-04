/* global QUnit */

QUnit.config.autostart = false;

sap.ui.getCore().attachInit(function() {
	"use strict";

	sap.ui.require([
		"iot/timetracking-worklist/test/integration/AllJourneys"
	], function() {
		QUnit.start();
	});
});