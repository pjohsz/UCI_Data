// get data from data.js input file.  
var tableData = data;
  console.log("accepting the data file");
  console.log(tableData);

// Get references to the tbody element and the date of the input
var tbody = document.querySelector("tbody");
var button = d3.select("#filter-btn");

// Event listener for updates on to the searchButton.  
document.getElementById("filter-btn").addEventListener("click", handleSearchButtonClick);

// Initial render of the table (all data) renderTable creates the tableData into the tbody
function initRenderTable() {
  tbody.innerHTML = "";
  console.log("Initial Render of the table")

  // Load the table from input file

  for (var i = 0; i < tableData.length; i++) {
    
    // Get get the current sighting object and its fields
    var sighting = tableData[i];
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

function handleSearchButtonClick() {
  // Get rid of the leading and trailing whitespace in the input field so we can use the date in the table search. 
  var filterDate = dateInput.value.trim();
    console.log("Search button clicked");
    console.log(filterDate)
  
  if (filterDate.length != 0){
    filteredUFO = dataSet.filter(function(sighting) {
      var sightingDate = sighting.datetime;
       return sightingDate === filterDate;
         });
  }
  else {
    fileredUFO = dataSet
  }
  if (filterState.length != 0){
    filteredUFO = filteredUFO.filter(function(sighting) {
      var sightingState = sighting.state;
       return sightingState === filterState;
         });
  }
  else {
    filteredUFO = filteredUFO
  }
  renderTable();
}

// Render the table for the first time on page load
renderTable();