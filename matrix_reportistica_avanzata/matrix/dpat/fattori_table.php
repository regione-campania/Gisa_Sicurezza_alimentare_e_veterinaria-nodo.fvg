<?php
    $row = $_GET['row'];
    $id = $_GET['nominativo'];
?>
<style>
table {
  border-collapse: collapse;
  margin: 10px;
}
table, td, th {
  border: 1px solid black;
}
th {
    background-color: rgb(204, 192, 218);
    text-align: center;
}

</style>

<script src="https://d3js.org/d3.v4.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<table id="table">
<tr>
    <th>N.</th>
    <th></th>
    <th style="max-width: 300px; text-align: center">Causale</th>
    <th style="text-align: center; width:80px">Percentuale</th>
    <th style="text-align: center; width:120px">*</th>
</tr>
</table>
<div style="margin-left: 10px">Note:</div>
<textarea style="margin: 10px" rows="5" cols="50" id="note" enabled></textarea>
<br>
<button onclick="save()">Salva</button>
<br>
<script>
    var id_nominativo = <?php echo $id ?>;
    var row = <?php echo $row ?>;
    var fattori = [];

    var globData = null;
    var altreStrutture = null;

    var httpRequest = new XMLHttpRequest();
    httpRequest.open('GET', 'fattori_json.php?id=' + id_nominativo);
    httpRequest.send();
    httpRequest.onreadystatechange = function() {
      if (httpRequest.readyState === 4 && httpRequest.status === 200) {
        var httpResult = JSON.parse(httpRequest.responseText);
        createTable(httpResult.data);
      }
    }

    function createTable(data){
        console.log(data)
        globData = data;
        d3.select("#note")._groups[0][0].value = data[0].fattori_text;
        altreStrutture = data[0].altre_strutture != '' ? data[0].altre_strutture : null;
        data.forEach(function(v){ delete v.altre_strutture }); //le rimuovo perchè gli accenti danno fastidio nel check

        data.forEach(function(d,i){
            fattori.push(d);
            var checked = "";
            var disabled = "disabled";
            if(d.valore != ""){
                checked = "checked";
                disabled = "";
            }
            var disableTpal = "";
            if(d.solo_tpal == 't' && d.is_tpal == 'f')
                disableTpal = "disabled";
            
            var altre = (altreStrutture && d.mostra_altre_uos =='t') ? (" ["+altreStrutture+"]") : ''
            d3.select("#table").append("tr").html(" \
                <td>"+d.numero+"</td>  \
                <td><input type=\"checkbox\" "+checked+" id=\"check"+d.id_fattore+"\" onchange='change("+JSON.stringify(d)+")' "+disableTpal+"></td> \
                <td id=\"descr"+d.id_fattore+"\">"+d.descr + altre + " </td> \
                <td> <input type=\"text\" style=\"width: 30px;\" max="+d.max_perc+" id=\"perc"+d.id_fattore+"\" "+disabled+" value="+d.valore+"> <div style=\"font-size: 10px\">(max "+d.max_perc+"%)<div></td> \
                <td style=\"font-size: 10px\">"+d.note+"</td> \
                ")
        })
        data.forEach(function(d){
            if(d.valore != "")//se checkato simulo click per settare i disabled sui fattori incompatibili
                change(d);
        })
        console.log(fattori);
    }

    function change(d){
        console.log(d);
        let esclusioni = d.numero_incompatibile.split(",");
        console.log(esclusioni);
        let daEscludere = globData.filter(function(g){
            return esclusioni.indexOf(g.numero) > -1;
        })
        console.log(daEscludere)

        if(d3.select("#check"+d.id_fattore)._groups[0][0].checked){
            d3.select("#perc"+d.id_fattore).property("disabled", "")
                daEscludere.forEach(function(dd){
                d3.select("#check"+dd.id_fattore).property("disabled", "disabled")
            })
        }
        else{
            d3.select("#perc"+d.id_fattore).property("disabled", "disabled")
                daEscludere.forEach(function(dd){
                d3.select("#check"+dd.id_fattore).property("disabled", "")
            })
        }

    }

    function save(){
        var note = d3.select("#note")._groups[0][0].value;
        console.log(note);
        var causaliRicalcoloCf = [];
        fattori.forEach(function(f){ //primo ciclo per controllare validità
            if(d3.select("#check"+f.id_fattore)._groups[0][0].checked){
                console.log( d3.select("#descr"+f.id_fattore)._groups[0][0]);
                var val = d3.select("#perc"+f.id_fattore)._groups[0][0].value.trim();
                if(!/^\d+$/.test(val)){
                    alert("Puoi inserire solo numeri nel campo percentuale")
                    throw "errore inserimento";
                }
                var max = d3.select("#perc"+f.id_fattore)._groups[0][0].attributes.max.value;
                if(parseFloat(val) > parseFloat(max)){
                    var descr = d3.select("#descr"+f.id_fattore)._groups[0][0].innerText;
                    alert("Il valore massimo per '"+descr+"' è "+max+ ". Inserito "+ val);
                    throw "errore inserimento";
                }
                if(f.ricalcolo_cf == 't')
                    causaliRicalcoloCf.push(f.descr)
            }
        })

        if(causaliRicalcoloCf.length > 0 && altreStrutture){
            if(!confirm(`Le causali ${causaliRicalcoloCf.join(', ')} verranno impostate sulla persona anche in tutte le altre strutture di appartenenza: ${altreStrutture}. Riverificare i calcoli sulle altre strutture!`))
                return;
        }

        var precSottr = 100;
        var valuesFattori = [[null, id_nominativo, null, note]]; //entro almeno una volta per eliminare i valori precedenti
        fattori.forEach(function(f){ //secondo ciclo per calcoli
            if(d3.select("#check"+f.id_fattore)._groups[0][0].checked){
                var val = parseFloat(d3.select("#perc"+f.id_fattore)._groups[0][0].value.trim());
                console.log("sottraggo "+ val);
                precSottr = precSottr - (precSottr*val/100);
                console.log("nuovo " + precSottr);
                valuesFattori.push([f.id_fattore, id_nominativo, val, note, f.univoco_asl == 't', f.limite_asl != '', f.limite_uoc != '', f.ricalcolo_cf == 't']);
            }
        })
        console.log(valuesFattori);
        $.ajax({
            type: "POST",
            data: {values: valuesFattori},
            url: "update_fattori.php",
            dataType: "text",
            async: false,
            success: function(risposta) {
            console.log(risposta);
            
            if(risposta.startsWith("KO"))
                alert(risposta);
            else{
                var sottr = 100 - precSottr;
                console.log("da sottrarre " + sottr);
                window.opener.$("[id=sottr1][row="+row+"]").val(sottr);
                window.opener.$("[id=sottr1uba][row="+row+"]").val(sottr);
                window.opener.CHANGED_FATTORI = true;
                window.opener.calculate(row);
                alert("Salvataggio avvenuto con successo");
                self.close();
            }
            },
            error: function(risposta){
            console.log("Errore ajax");
            }
        })

    }

</script>