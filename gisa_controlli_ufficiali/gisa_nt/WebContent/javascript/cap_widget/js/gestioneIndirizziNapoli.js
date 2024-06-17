var selezioneIndirizzoNapoli = false;
var indirizzoNapoliSelezionato = '';
var optionsNapoli = {
		
		url: "../../ServletStradeNapoli", 
		
		getValue: function(element){
			var out_top = element.split("|")[1];
			var out_via = element.split("|")[0];
			var out_cap = element.split("|")[2];
			return (out_top + "|" + out_via + "|" + out_cap).replace(/\|/gi, ' ');
		},
		
		list: {	
			maxNumberOfElements: 15,
			
			onChooseEvent: function() {    
			      var viaNapoli =  $("#napoli").getSelectedItemData();
			      indirizzoNapoliSelezionato = viaNapoli.split("|")[1] + "|" + viaNapoli.split("|")[0] + "|" + viaNapoli.split("|")[2];
			      $("#napoli").val(indirizzoNapoliSelezionato.replace(/\|/gi, ' ')).trigger("change");			      
			      selezioneIndirizzoNapoli = true;
			      var arrayIndirizzo = indirizzoNapoliSelezionato.split("|");
			  	  $("#top").val(arrayIndirizzo[0]).trigger("change");
			  	  $("#topId").val(toponimi[arrayIndirizzo[0]]).trigger("change");
			  	  $("#via").val(arrayIndirizzo[1]).trigger("change");
			  	  $("#cap").val(arrayIndirizzo[2]).trigger("change");
			  },
			
			/*
			onSelectItemEvent: function() {    
			      var viaNapoli =  $("#napoli").getSelectedItemData();
			      indirizzoNapoliSelezionato = viaNapoli;
			      $("#napoli").val(viaNapoli).trigger("change");			      
			      selezioneIndirizzoNapoli = true;
			  },
			  */
              
		      match: {
		    	  enabled: true,
		    	  /*method:  function(element, phrase) {
		    		  phrase = phrase.replace(/\|/gi, ' ');
		    		  element = element.replace(/\|/gi, ' ');
		              if(element.indexOf(phrase) === 0) {
		                return true;
		              } else {
		                return false;
		              }
		            } */
		      }
	      }
    };

$("#napoli").easyAutocomplete(optionsNapoli);

$("#napoli").on('focus', function() {
	selezioneIndirizzoNapoli = false;
    $(this).val('');    
    $("#top").val(null);
    $("#topId").val(null);
    $("#via").val(null);
    $("#civ").val(null);
    $("#cap").val(null);
}).on('blur', function() {
    if (!selezioneIndirizzoNapoli || ($("#napoli").val() != indirizzoNapoliSelezionato.replace(/\|/gi, ' '))) {
    	$(this).val(null);
        indirizzoNapoliSelezionato = '';
      } else {
    	$(this).val(indirizzoNapoliSelezionato.replace(/\|/gi, ' '));
        var arrayIndirizzo = indirizzoNapoliSelezionato.split("|");
  	    $("#top").val(arrayIndirizzo[0]).trigger("change");
  	    $("#topId").val(toponimi[arrayIndirizzo[0]]).trigger("change");
  	    $("#via").val(arrayIndirizzo[1]).trigger("change");
  	    $("#cap").val(arrayIndirizzo[2]).trigger("change");
      }
    });;