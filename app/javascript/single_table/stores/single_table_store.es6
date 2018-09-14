class SingleTableStore {
  constructor(store) {
    this.store = store
  }

  dataForTab(tab) {
    // This returns the labware object linked to the tab
    for (var key in this.params) {
      if ($(tab).attr('href') === ('#Labware' + this.params[key].labware_index)) {
        return this.params[key];
      }
    }
    return null;
  }

  getDataForInput(inputData) {
    var data = this.dataForTab(inputData.tab)
    var address = inputData.address
    var fieldName = inputData.fieldName
    if (data && data["contents"] && address && data["contents"][address] && fieldName) {
      return data["contents"][address][fieldName];
    }
    return null;
  }

  setDataForInput(inputData) {
    var data = this.dataForTab(inputData.tab)
    if (data == null) {
      return;
    }

    var info = inputData
    var input = inputData.input

    if (info && data.labware_index == info.labwareIndex) {

      // Get and santize the value of the input
      var v = $(input).val();
      if (v != null) {
        v = $.trim(v);
        if (v == '') {
          v = null;
        }
      }
      if (v) {
        if (!data["contents"]) {
          data["contents"] = {}
        }
        if (!data["contents"][info.address]) {
          data["contents"][info.address] = {}
        }
        data["contents"][info.address][info.fieldName] = v;
      } else if (this.fieldData(data, info.address, info.fieldName) != null) {
        data["contents"][info.address][info.fieldName] = null;
      }
    }    
  }
}

export default SingleTableStore