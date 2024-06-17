<script>

function exportCSV_3(nomeTabella, nomeFile){
    /* Get the HTML data using Element by Id */
    var table = document.getElementById(nomeTabella);
 
    /* Declaring array variable */
    var rows =[];
 
      //iterate through rows of table
    for(var i=0,row; row = table.rows[i];i++){
        //rows would be accessed using the "row" variable assigned in the for loop
        //Get each cell value/column from the row
        column1 = row.cells[0].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column2 = row.cells[1].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column3 = row.cells[2].innerText.replace(/(\r\n|\n|\r)/gm, " ");

    /* add a new records in the array */
        rows.push(
            [
                column1,
                column2,
                column3
            ]
        );
 
        }
        csvContent = "data:text/csv;charset=utf-8,";
         /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
        rows.forEach(function(rowArray){
            row = rowArray.join("$");
            csvContent += row + "\r\n";
        });
 
        /* create a hidden <a> DOM node and set its download attribute */
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", nomeFile+".csv");
        document.body.appendChild(link);
        link.click();
}

function exportCSV_6(nomeTabella, nomeFile){
    /* Get the HTML data using Element by Id */
    var table = document.getElementById(nomeTabella);
 
    /* Declaring array variable */
    var rows =[];
 
      //iterate through rows of table
    for(var i=0,row; row = table.rows[i];i++){
        //rows would be accessed using the "row" variable assigned in the for loop
        //Get each cell value/column from the row
        column1 = row.cells[0].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column2 = row.cells[1].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column3 = row.cells[2].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column4 = row.cells[3].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column5 = row.cells[4].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column6 = row.cells[5].innerText.replace(/(\r\n|\n|\r)/gm, " ");

    /* add a new records in the array */
        rows.push(
            [
                column1,
                column2,
                column3,
                column4,
                column5,
                column6
            ]
        );
 
        }
        csvContent = "data:text/csv;charset=utf-8,";
         /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
        rows.forEach(function(rowArray){
            row = rowArray.join("$");
            csvContent += row + "\r\n";
        });
 
        /* create a hidden <a> DOM node and set its download attribute */
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", nomeFile+".csv");
        document.body.appendChild(link);
        link.click();
}


function exportCSV_7(nomeTabella, nomeFile){
    /* Get the HTML data using Element by Id */
    var table = document.getElementById(nomeTabella);
 
    /* Declaring array variable */
    var rows =[];
 
      //iterate through rows of table
    for(var i=0,row; row = table.rows[i];i++){
        //rows would be accessed using the "row" variable assigned in the for loop
        //Get each cell value/column from the row
        column1 = row.cells[0].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column2 = row.cells[1].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column3 = row.cells[2].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column4 = row.cells[3].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column5 = row.cells[4].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column6 = row.cells[5].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column7 = row.cells[6].innerText.replace(/(\r\n|\n|\r)/gm, " ");

    /* add a new records in the array */
        rows.push(
            [
                column1,
                column2,
                column3,
                column4,
                column5,
                column6,
                column7
            ]
        );
 
        }
        csvContent = "data:text/csv;charset=utf-8,";
         /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
        rows.forEach(function(rowArray){
            row = rowArray.join("$");
            csvContent += row + "\r\n";
        });
 
        /* create a hidden <a> DOM node and set its download attribute */
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", nomeFile+".csv");
        document.body.appendChild(link);
        link.click();
}

function exportCSV_15(nomeTabella, nomeFile){
    /* Get the HTML data using Element by Id */
    var table = document.getElementById(nomeTabella);
 
    /* Declaring array variable */
    var rows =[];
 
      //iterate through rows of table
    for(var i=0,row; row = table.rows[i];i++){
        //rows would be accessed using the "row" variable assigned in the for loop
        //Get each cell value/column from the row
        column1 = row.cells[0].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column2 = row.cells[1].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column3 = row.cells[2].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column4 = row.cells[3].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column5 = row.cells[4].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column6 = row.cells[5].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column7 = row.cells[6].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column8 = row.cells[7].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column9 = row.cells[8].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column10 = row.cells[9].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column11 = row.cells[10].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column12 = row.cells[11].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column13 = row.cells[12].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column14 = row.cells[13].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column15 = row.cells[14].innerText.replace(/(\r\n|\n|\r)/gm, " ");

    /* add a new records in the array */
        rows.push(
            [
                column1,
                column2,
                column3,
                column4,
                column5,
                column6,
                column7,
                column8,
                column9,
                column10,
                column11,
                column12,
                column13,
                column14,
                column15
            ]
        );
 
        }
        csvContent = "data:text/csv;charset=utf-8,";
         /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
        rows.forEach(function(rowArray){
            row = rowArray.join("$");
            csvContent += row + "\r\n";
        });
 
        /* create a hidden <a> DOM node and set its download attribute */
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", nomeFile+".csv");
        document.body.appendChild(link);
        link.click();
}

function exportCSV_16(nomeTabella, nomeFile){
    /* Get the HTML data using Element by Id */
    var table = document.getElementById(nomeTabella);
 
    /* Declaring array variable */
    var rows =[];
 
      //iterate through rows of table
    for(var i=0,row; row = table.rows[i];i++){
        //rows would be accessed using the "row" variable assigned in the for loop
        //Get each cell value/column from the row
        column1 = row.cells[0].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column2 = row.cells[1].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column3 = row.cells[2].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column4 = row.cells[3].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column5 = row.cells[4].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column6 = row.cells[5].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column7 = row.cells[6].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column8 = row.cells[7].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column9 = row.cells[8].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column10 = row.cells[9].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column11 = row.cells[10].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column12 = row.cells[11].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column13 = row.cells[12].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column14 = row.cells[13].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column15 = row.cells[14].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column16 = row.cells[15].innerText.replace(/(\r\n|\n|\r)/gm, " ");

    /* add a new records in the array */
        rows.push(
            [
                column1,
                column2,
                column3,
                column4,
                column5,
                column6,
                column7,
                column8,
                column9,
                column10,
                column11,
                column12,
                column13,
                column14,
                column15,
                column16
            ]
        );
 
        }
        csvContent = "data:text/csv;charset=utf-8,";
         /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
        rows.forEach(function(rowArray){
            row = rowArray.join("$");
            csvContent += row + "\r\n";
        });
 
        /* create a hidden <a> DOM node and set its download attribute */
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", nomeFile+".csv");
        document.body.appendChild(link);
        link.click();
}

function exportCSV_17(nomeTabella, nomeFile){
    /* Get the HTML data using Element by Id */
    var table = document.getElementById(nomeTabella);
 
    /* Declaring array variable */
    var rows =[];
 
      //iterate through rows of table
    for(var i=0,row; row = table.rows[i];i++){
        //rows would be accessed using the "row" variable assigned in the for loop
        //Get each cell value/column from the row
        column1 = row.cells[0].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column2 = row.cells[1].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column3 = row.cells[2].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column4 = row.cells[3].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column5 = row.cells[4].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column6 = row.cells[5].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column7 = row.cells[6].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column8 = row.cells[7].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column9 = row.cells[8].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column10 = row.cells[9].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column11 = row.cells[10].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column12 = row.cells[11].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column13 = row.cells[12].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column14 = row.cells[13].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column15 = row.cells[14].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column16 = row.cells[15].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column17 = row.cells[16].innerText.replace(/(\r\n|\n|\r)/gm, " ");

    /* add a new records in the array */
        rows.push(
            [
                column1,
                column2,
                column3,
                column4,
                column5,
                column6,
                column7,
                column8,
                column9,
                column10,
                column11,
                column12,
                column13,
                column14,
                column15,
                column16,
                column17
            ]
        );
 
        }
        csvContent = "data:text/csv;charset=utf-8,";
         /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
        rows.forEach(function(rowArray){
            row = rowArray.join("$");
            csvContent += row + "\r\n";
        });
 
        /* create a hidden <a> DOM node and set its download attribute */
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", nomeFile+".csv");
        document.body.appendChild(link);
        link.click();
}

function exportCSV_18(nomeTabella, nomeFile){
    /* Get the HTML data using Element by Id */
    var table = document.getElementById(nomeTabella);
 
    /* Declaring array variable */
    var rows =[];
 
      //iterate through rows of table
    for(var i=0,row; row = table.rows[i];i++){
        //rows would be accessed using the "row" variable assigned in the for loop
        //Get each cell value/column from the row
        column1 = row.cells[0].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column2 = row.cells[1].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column3 = row.cells[2].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column4 = row.cells[3].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column5 = row.cells[4].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column6 = row.cells[5].innerText.replace(/(\r\n|\n|\r)/gm, " ");
        column7 = row.cells[6].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column8 = row.cells[7].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column9 = row.cells[8].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column10 = row.cells[9].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column11 = row.cells[10].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column12 = row.cells[11].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column13 = row.cells[12].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column14 = row.cells[13].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column15 = row.cells[14].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column16 = row.cells[15].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column17 = row.cells[16].innerText.replace(/(\r\n|\n|\r)/gm, " ");
	 column18 = row.cells[17].innerText.replace(/(\r\n|\n|\r)/gm, " ");

    /* add a new records in the array */
        rows.push(
            [
                column1,
                column2,
                column3,
                column4,
                column5,
                column6,
                column7,
                column8,
                column9,
                column10,
                column11,
                column12,
                column13,
                column14,
                column15,
                column16,
                column17,
                column18
            ]
        );
 
        }
        csvContent = "data:text/csv;charset=utf-8,";
         /* add the column delimiter as comma(,) and each row splitted by new line character (\n) */
        rows.forEach(function(rowArray){
            row = rowArray.join("$");
            csvContent += row + "\r\n";
        });
 
        /* create a hidden <a> DOM node and set its download attribute */
        var encodedUri = encodeURI(csvContent);
        var link = document.createElement("a");
        link.setAttribute("href", encodedUri);
        link.setAttribute("download", nomeFile+".csv");
        document.body.appendChild(link);
        link.click();
}
</script>