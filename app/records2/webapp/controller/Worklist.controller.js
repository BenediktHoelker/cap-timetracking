sap.ui.define(
  [
    "./BaseController",
    "sap/ui/model/json/JSONModel",
    "../model/formatter",
    "sap/ui/model/Filter",
    "sap/ui/model/FilterOperator",
    "sap/m/MessageToast"
  ],
  function(
    BaseController,
    JSONModel,
    formatter,
    Filter,
    FilterOperator,
    MessageToast
  ) {
    "use strict";

    return BaseController.extend(
      "iot.timetracking.records.controller.Worklist",
      {
        formatter: formatter,

        onInit: function() {
          this._aTableSearchState = [];
          this.setModel(new JSONModel(), "viewModel");
        },

        onAfterRendering: function() {
          this.getRouter()
            .getRoute("worklist")
            .attachPatternMatched(this._onRouteMatched, this);
        },

        _onRouteMatched: function() {
          this.byId("table")
            .getBinding("items")
            .refresh();
        },

        onPressCreateInvoice: function() {
          const oTable = this.byId("table");

          const aItems = oTable
            .getSelectedItems()
            .map(item => item.getBindingContext().getObject())
            .filter(record => record.status === "INITIAL")
            .map(record => ({ record_ID: record.ID }));

          if (aItems.length === 0) {
            return MessageToast.show("Keine offenen Positionen ausgewählt.");
          }

          const oContext = this.getModel()
            .bindList("/Invoices")
            .create({
              ID: this._generateUUID(),
              items: aItems
            });

          oContext.created().then(() => {
            oTable.getBinding("items").refresh();
            MessageToast.show(
              `Rechnung für ${aItems.length} Positionen erzeugt.`
            );
          });
        },

        onSearch: function(oEvent) {
          if (oEvent.getParameters().refreshButtonPressed) {
            this.onRefresh();
          } else {
            var aTableSearchState = [];
            var sQuery = oEvent.getParameter("query");

            if (sQuery && sQuery.length > 0) {
              aTableSearchState = [
                new Filter("name", FilterOperator.Contains, sQuery)
              ];
            }
            this._applySearch(aTableSearchState);
          }
        },

        onRefresh: function() {
          this.byId("table")
            .getBinding("items")
            .refresh();
        },

        _applySearch: function(aTableSearchState) {
          const oTable = this.byId("table");
          const oViewModel = this.getModel("viewModel");

          oTable.getBinding("items").filter(aTableSearchState, "Application");

          if (aTableSearchState.length !== 0) {
            oViewModel.setProperty(
              "/tableNoDataText",
              this.getResourceBundle().getText("worklistNoDataWithSearchText")
            );
          }
        }
      }
    );
  }
);
