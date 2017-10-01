document.addEventListener('turbolinks:load', function() {
	activeEventYear()
	activeEventMonth()
	hideNoticeAndAlert()
})


function activeEventYear(){
	years = document.querySelectorAll('.event-years-cnt a')
	urlStr = window.location.href 
	url = new URL(urlStr)
	currentYear = url.searchParams.get('year')

	if(currentYear === null){
		date = new Date()
		currentYear = date.getFullYear()
	}

	for(var i = 0 ; i < years.length ; i++){
		if(currentYear == years[i].innerText){
			years[i].classList.add('active-year')
		}
	}
}


function activeEventMonth(){
  month = document.querySelectorAll('.event-months-cnt a')
	urlStr = window.location.href 
	url = new URL(urlStr)
	currentMonth = url.searchParams.get('month')

	if(currentMonth === null){
		date = new Date()
		currentMonth = date.getMonth() + 1
	}

	for(var i = 0 ; i < month.length ; i++){
		if(currentMonth == i+1){
			month[i].classList.add('active-month')
		}
	}	
}


function hideNoticeAndAlert(){
	notice = document.getElementsByClassName('notice')[0]
	alert = document.getElementsByClassName('alert')[0]

	setTimeout(function(){
		if(notice){ notice.style.display = 'none' }
		if(alert){ alert.style.display = 'none' }
	}, 3000);

}