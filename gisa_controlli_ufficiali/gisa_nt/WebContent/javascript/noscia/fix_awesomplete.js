//avoid Redeclaration Error
if(!window.isAwesompleteInitialized)
	window.isAwesompleteInitialized = false

function initAwesomplete(...args) {
	if(isAwesompleteInitialized)
		return
	//default config
	let inputId = 'comune_nascita_rapp_legaleLabel'
	let hiddenId = 'comune_nascita_rapp_legale'
	let options =  {
		list: cArray,
		maxItems: 20,
		autoFirst: true,
		replace: function(item) {
			input.value = item.label
			hidden.value = item.value
		},
		filter: Awesomplete.FILTER_STARTSWITH
	}
	//looking for new configuration
	args.forEach(arg => {
		if(typeof arg === 'object') {
			if('inputId' in arg)
				inputId = arg.inputId
			if('hiddenId' in arg)
				hiddenId = arg.hiddenId
			if('options' in arg)
				options = arg.options
		}
	})

	//initialization
	var input = document.getElementById(inputId)
	var hidden = document.getElementById(hiddenId)
	var awesomplete = new Awesomplete(input, options)
	
	isAwesompleteInitialized = true
}