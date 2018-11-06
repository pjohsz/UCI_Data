// get data from data.js input file.
var tableData = data;
// console.log("accepting the data file");
// console.log(tableData);

// Get references to the tbody element and the date of the input
var tbody = document.querySelector("tbody");
var dateInput = document.getElementById("datetime");
var stateInput = document.getElementById("stateFilter");

// Event listener for updates on to the searchButton.
// document
//   .getElementById("filter-btn")
//   .addEventListener("click", handleSearchButtonClick, false);

document
  .getElementById("filter-btn")
  .addEventListener("click", handleFilterClick, false);

// Event listener for state select
// document
//   .getElementById("stateFilter")
//   .addEventListener("change", handleCityChange, false);

// Initial render of the table (all data) renderTable creates the tableData into the tbody
function renderTable(dtaSet) {
  tbody.innerHTML = "";
  // console.log("Initial Render of the table");

  // Load the table from input file

  for (var i = 0; i < dtaSet.length; i++) {
    // Get get the current sighting object and its fields
    var sighting = dtaSet[i];
    var fields = Object.keys(sighting);
    // Create a new row in the tbody, set the index to be i + startingIndex
    var row = tbody.insertRow(i);
    for (var j = 0; j < fields.length; j++) {
      // For every field in the address object, create a new cell at set its inner text to be the current value at the current address's field
      var field = fields[j];
      var cell = row.insertCell(j);
      cell.innerText = sighting[field];
    }
  }
}

function handleFilterClick(e) {
  e.preventDefault();

  var fitlerDate = dateInput.value.trim();
  var selectedState = stateInput.options[
    stateInput.selectedIndex
  ].value.toLowerCase();

  if (fitlerDate.length != 0 && selectedState != "-") {
    // filter by date and state
    filteredUFO = tableData.filter(function(sighting) {
      var sightingDate = sighting.datetime;
      var sightingState = sighting.state;
      return sightingDate === fitlerDate && sightingState === selectedState;
    });
  } else if (fitlerDate.length != 0) {
    filteredUFO = tableData.filter(function(sighting) {
      var sightingDate = sighting.datetime;
      return sightingDate === filterDate;
    });
  } else if (selectedState != "-") {
    filteredUFO = tableData.filter(function(sighting) {
      var sightingState = sighting.state;
      return sightingState === selectedState;
    });
  } else {
    filteredUFO = dataSet;
  }

  renderTable(filteredUFO);
}

function handleSearchButtonClick(e) {
  e.preventDefault();
  // Get rid of the leading and trailing whitespace in the input field so we can use the date in the table search.
  var filterDate = dateInput.value.trim();
  // console.log("Search button clicked");
  // console.log(filterDate);

  if (filterDate.length != 0) {
    filteredUFO = tableData.filter(function(sighting) {
      var sightingDate = sighting.datetime;
      return sightingDate === filterDate;
    });
  } else {
    fileredUFO = dataSet;
  }

  renderTable(filteredUFO);
}

function handleCityChange(e) {
  e.preventDefault();

  var selectedState = stateInput.options[
    stateInput.selectedIndex
  ].value.toLowerCase();

  if (selectedState != "-") {
    filteredUFO = tableData.filter(function(sighting) {
      var sightingState = sighting.state;
      return sightingState === selectedState;
    });
  } else {
    filteredUFO = dataSet;
  }

  renderTable(filteredUFO);
}

// Render the table for the first time on page load
renderTable(tableData);
