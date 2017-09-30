document.addEventListener('turbolinks:load', function() {

	activeEventYear()
	activeEventMonth()

})


function activeEventYear(){
	years = document.querySelectorAll('.event-years-cnt a')
	urlStr = window.location.href 
	url = new URL(urlStr)
	currentYear = url.searchParams.get('year')

	for(var i = 0 ; i < years.length ; i++){
		if(currentYear === years[i].innerText){
			years[i].classList.add('active-year')
		}
	}
}


function activeEventMonth(){
  month = document.querySelectorAll('.event-months-cnt a')
	urlStr = window.location.href 
	url = new URL(urlStr)
	currentMonth = url.searchParams.get('month')

	for(var i = 0 ; i < month.length ; i++){
		if(currentMonth == i+1){
			month[i].classList.add('active-month')
		}
	}	
}