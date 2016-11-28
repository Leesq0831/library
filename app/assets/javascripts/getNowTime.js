	function getTime() {
		//var tt1 = new Date().format("yyyy-mm-dd HH:mm:ss");
		var tt = new Date();
		var m = "";
		var time = "";
		var day = "";
		var h = "";
		var min = "";
		var sec = "";
		if((tt.getMonth() + 1 )<10){
			m = "0" + (tt.getMonth() + 1);
			}else{
			m = (tt.getMonth() + 1);
				}
		if(tt.getDate()<10){
			day = "0" + tt.getDate();
 			}else{
				day = tt.getDate();


				}
		if(tt.getHours()<10){
			h = "0" + tt.getHours();
			}else{
			h =  tt.getHours();
}
		if(tt.getMinutes()<10){
			min =  "0" + tt.getMinutes();
			}else{
				min = tt.getMinutes();
				}
		if(tt.getSeconds()<10){
			sec =  "0" + tt.getSeconds();
			}else{
				sec = tt.getSeconds();
			}
		//获取年月日
		time = "当前时间:" + tt.getFullYear() + "年" + m + "月"+ day + "日 " + h + ":" + min+ ":" + sec + " " + getWeek();
		document.getElementById("time").innerHTML = time;
	}
	function getWeek() {
		var date = new Date();
		var int = date.getDay();
		var week = "";
		switch (int) {
		case 0:
			week = "星期日";
			break;
		case 1:
			week = "星期一";
			break;
		case 2:
			week = "星期二";
			break;
		case 3:
			week = "星期三";
			break;
		case 4:
			week = "星期四";
			break;
		case 5:
			week = "星期五";
			break;
		case 6:
			week = "星期六";
			break;
		}
		return week;
	}//getweek
	window.setInterval("getTime()", 1000);