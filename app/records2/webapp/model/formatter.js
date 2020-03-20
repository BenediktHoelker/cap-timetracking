sap.ui.define([], function() {
  "use strict";

  return {
    statusIcon: function(sStatus) {
      switch (sStatus) {
        case "INITIAL":
          return "sap-icon://status-inactive";
        case "BILLED":
          return "sap-icon://status-completed";
        default:
          return "sap-icon://status-inactive";
      }
    },

    statusColour: function(sStatus) {
      switch (sStatus) {
        case "INITIAL":
          return "None";
        case "BILLED":
          return "Success";
        default:
          return "None";
      }
    },

    dynamicText: function(sKey) {
      return this.getModel("i18n")
        .getResourceBundle()
        .getText(sKey);
    }
  };
});
