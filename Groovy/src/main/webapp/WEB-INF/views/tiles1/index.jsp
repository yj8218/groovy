<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<% String ctxPath = request.getContextPath(); %>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Outlined" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Round" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Sharp" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Icons+Two+Tone" rel="stylesheet"/>
<style type="text/css">

	body {background-color: #f2f2f2;}

	table.tbl_boardInCard td {padding: 10px;}
	
	.fas, .far {margin-right: 10px;}
	
	label.btn_inputFile {
		padding: 5px;
		background-color: transparent;
		border: solid 1px lightgray;
		border-radius: 5px;
		cursor: pointer;
	}
	
	div#fixedTab {
		padding: 30px 30px 0px 30px;
	
		position: fixed;
		top: 45px;
    	left: 230px;
    	
    	width: 100%;
    	height: 145px;
    	background-color: white;
    	border-bottom: solid 1px lightgray;
    	
    	z-index: 1;
	}
	
	div#content {margin-top: 10px;}
	
	div.inputfileDiv {position: relative;}
	
	div.inputfileDiv #inputfile {
		position: absolute;
		left: 100px;
		top: 5px;
	}
	
	div.feedAll {box-shadow: 1px 1px 5px lightgray;}
	
	div#inputFileDiv {
		position: relative;
		display: inline-block;
	}
	
	div.prjSetting a {font-size: 10pt;}
	
	div.emotion a {display: inline;}
	
	table#tblEmpList i {color: #c6c6c6;}
	table#tblEmpList i:hover, div#groupchat:hover {color: #6449fc; cursor: pointer;}
	
	a#showAllEmployee {
		display: inline-block;
		font-size: 10pt; 
		margin-right: 5px; 
		cursor: pointer; 
		text-decoration: none;
		color: black;
	}
	
	button#groupchat {border: none; width: 100%; height: 100%; background-color: transparent;}
	
	a#dept {
		display: block; 
		width: 100%; 
		padding: 10px; 
		margin-bottom: 10px; 
		text-decoration: none;
		font-weight: bold;
		background-color: #f7f7f7;
		border-radius: 10px;
	}
	
	.scrollover { -ms-overflow-style: none; } 
	.scrollover::-webkit-scrollbar { display:none; }
	
	 .empProfile > img {
		width: 45px;
		height: 45px;
		overflow: hidden;
	}
	
	
	tr#tablehover:hover{
		background: #f8f6ff;
		color:#6449fc;
	/* 	border: 1px solid #6449fc; */
	}
	
	
	
	
	
	


/*  글한개보기 css 시작*/	
 /*  ///////// */
 
 
 div.showBoardDetail{ 
 	width: 674px;
    /* height: 100%; */
    min-height: auto;
    max-height: max-content;
    position: absolute;
    top: -30px;
    bottom: 0;
    right: -20px;
    z-index: 2;
    overflow: hidden;
    background: #f9f9f9;
    border-radius: 0;
    border-left: 1px solid #ccc;
        border: 1px solid #ccc;
    box-shadow: -10px 10px 15px rgb(0 0 0 / 4%);
    display:block;
    font-size: 14px;
    font-weight: 400;
 }
  
  div.showBoardDetail div.card-header{
  	overflow: hidden;
    padding: 10px 20px;
    height: 45px;
    background: #fff;
    border-bottom: 1px solid #eee;
  }
  
  div.showBoardDetail div.card-header h3{
  	float: left;
    width: 100%;
    font-size: 14px;
    color: #333;
    
    margin: 0;
    padding: 0;
  }
  div.showBoardDetail div.card-header h3 span.js-project-title-button {
 	 overflow: hidden;
   /*  display: inline-block; */
    max-width: 300px;
    text-overflow: ellipsis;
    white-space: nowrap;
   
   margin-left: 5px;

  }
  div.showBoardDetail div.card-header button.close{
  	top: 8px;
    right: 20px;
        float: right;
    margin-top: 1px;
    position: absolute;
    color: #333;
  }
  div.showBoardDetail div.card-header button.close span{
  /* font-family: icon-contents!important; */
    font-style: normal;
    /* font-weight: 400; */
    font-variant: normal;
    text-transform: none;
    line-height: 1;
    -webkit-font-smoothing: antialiased;
    
  }
  
  div.showBoardDetail div.card-body{
  border-radius: 0;
  background: #faf9f9;
  
   flex: none;
    min-height: auto;
    padding: 0;
  
  }
  
  
  div.showBoardDetail div.card-scroll{
  	max-height: calc(100vh - 78px);
    overflow-y: auto;
    overflow-x: hidden;
    min-height: 100px;
    box-sizing: border-box;
	}
  
  
  div.showBoardDetail div.card-body-top{
 	 position: relative;
 	 display: flex;	
     -webkit-box-pack: justify;
     justify-content: space-between;
    padding: 14.5px 30px;
    background: #fff;

  }
  
  div.showBoardDetail div.card-author{
  -webkit-box-flex: 1;
    flex: 1;
    display: -webkit-box;
    display: flex;
    float: initial;
    width: calc(100% - 77px);
  }
  div.showBoardDetail span.card-profileImg{
	background-image: url('<%=ctxPath %>/resources/images/kimyj/profileImg-default.png');
	width: 40px;
    height: 40px;
    display: inline-block;
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-color: #fff;
    border: 1px solid #eee;
     border-radius: 16px;
    cursor: pointer;
    box-sizing: border-box;
    vertical-align: middle;
  }
   div.showBoardDetail dl.card-author-info{
  
    display: -moz-box;
    display: flex;
    -webkit-box-flex: 1;
    flex: 1;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    flex-direction: column;
    -webkit-box-pack: center;
    justify-content: center;
    
     margin: 0;
    padding: 0;
    overflow: hidden;
    width: 70%;
    line-height: 18px;
    margin-left: 10px;
    vertical-align: middle;
    text-align: left;
    
    font-size: 14px;
    
   
   }
   
    div.showBoardDetail dl.card-author-info dt{
    display: flex;
    color: #555;
    line-height: 1.1;
    }
   
    div.showBoardDetail strong.author-name{
    
   overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    display: inline-block;
    margin-right: 3px;
    vertical-align: middle;
    line-height: 18px;
    max-width: 70%;
    font-weight: 700;
    }
  
   div.showBoardDetail span.author-date{
       display: inline-block;
    min-width: 120px;
    margin: 2px 0 0 7px;
    color: #aaa;
    font-family: Roboto;
    vertical-align: middle;
    line-height: 1.1;
     font-weight: normal;
   }
   
   div.showBoardDetail div.card-option{
       display: flex;
   	 -webkit-box-align: center;
   	     align-items: center;
    -webkit-box-pack: justify;
        justify-content: flex-end;
    height: 40px;
   }
   
   div.showBoardDetail button.card-option-btn{
       margin: -1px 0 0 20px;
       padding: 4px 8px;
  
    vertical-align: middle;
    cursor: pointer;
        background-color: transparent;
        border-radius: 0;
    border: 0;
        color: #999;
        font-size: 100%;
    line-height: normal;
    background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-option.svg');
    width: 20px;
    height: 20px;
    

   }
   
    div.showBoardDetail button.card-option-btn span{
        width: 2px;
    height: 2px;
    background: #777;
    margin: 0;
    display: block;
    }
    
    div.showBoardDetail ul.card-option-ul{
    overflow: hidden;
    position: absolute;
    z-index: 1;
    top: 50px;
    right: 35px;
    background: #fff;
    border: 1px solid #555;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    border-radius: 6px;
    padding: 4px 0;

    }
    
   div.showBoardDetail li.card-option-li{
   display: block;
   position: relative;
   }
   
   div.showBoardDetail li.card-option-li a{
   	display: block;
    height: 19px;
    margin: 5px 0;
    padding: 0 14px;
    line-height: 19px;
    font-size: 13px;
    color: #555;
        text-decoration: none;
    
    cursor: pointer;
   }
   
   div.showBoardDetail li.card-option-li a i {
   display: inline-block;
    margin: -4px 6px 0 0;
    vertical-align: middle; 
   
    font-style: normal;
    font-weight: 400;
    font-variant: normal;
    text-transform: none;
    line-height: 1;
     color: #999;
      width: 13px;
    height: 13px;
    filter: invert(66%) sepia(4%) saturate(26%) hue-rotate(338deg) brightness(94%) contrast(78%);
   }
   
   div.showBoardDetail li.card-option-li a i.icon-edit{
   background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-edit-13.svg');
   fill: blue;
   color: red;
   }
div.showBoardDetail li.card-option-li a i.icon-delete{
 background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-delete-13.svg');
}

div.showBoardDetail div.card-body-bottom{
position: relative;
    overflow: hidden;
    display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
    width: 100%;
    height: auto;
    padding: 10px 30px 10px 30px;
    background: #fff;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
    -moz-box-pack: justify;
    justify-content: space-between;
}

div.showBoardDetail div.card-schedule-date{
    display: table-cell;
    height: 74px;
    overflow: hidden;
    margin: 5px 20px 5px 0;
    width: 68px;
   
    border-radius: 6px;
  
    box-shadow: 0 0 6px rgb(0 0 0 / 10%);
    font-family: Roboto;
    text-align: center;
    vertical-align: middle;
}
div.showBoardDetail strong.card-month{
display: block;
    padding: 8px 0;
    font-size: 12px;
    color: #00b19c;
    
    height: 30px;
    line-height: 1;
    list-style-image: none;
    list-style-position: outside;
    list-style-type: none;
}

div.showBoardDetail strong.card-day{
	display: block;
    padding: 5px 0;
    font-size: 28px;
    color: #fff;
    background: #00b19c;
    height: 44px;
    line-height: 1;
    list-style-image: none;
    list-style-position: outside;
    list-style-type: none;
}

div.showBoardDetail div.card-schedule-title-area{
padding-left: 20px;

display: -webkit-box;
    display: -webkit-flex;
    display: -moz-box;
    display: flex;
    -webkit-box-orient: vertical;
    -webkit-box-direction: normal;
    -webkit-flex-direction: column;
    -moz-box-orient: vertical;
    -moz-box-direction: normal;
    flex-direction: column;
    -webkit-box-pack: center;
    -webkit-justify-content: center;
    -moz-box-pack: center;
    justify-content: center;
    -webkit-box-flex: 1;
    -webkit-flex: 1;
    -moz-box-flex: 1;
    flex: 1;
    width: 100%;
}

div.showBoardDetail h4.card-schedule-title{

    overflow: hidden;
    text-overflow: ellipsis;
    margin: 0;
    font-size: 18px;
    font-weight: 700;
    vertical-align: middle;
    word-break: break-word;
}

div.showBoardDetail div.card-schedule-day{
display: block;
margin-top: 10px;

}


div.showBoardDetail span.card-schedule-startDate{
font-family: Roboto;
    font-size: 16px;
    color: #333;


}
div.showBoardDetail span.card-schedule-endDate{
    display: inline-block;
font-family: Roboto;
    font-size: 16px;
    color: #333;
}

			
	div.showBoardDetail span.card-schedule-endDate:before{
    display: inline-block;
    content: "";
    width: 12px;
    height: 1px;
    margin: -2px 6px 0 3px;
    background: #333;
    vertical-align: middle;
}		  	 

div.showBoardDetail div.card-body-bottom:after {
    content: '';
    position: absolute;
    height: 1px;
    width: -webkit-calc(100% - 60px);
    width: calc(100% - 60px);
    left: 30px;
    bottom: 0;
    background: #eee;
}


div.showBoardDetail div.card-container{
    padding: 10px 0 20px;
    background: #fff;
}

div.showBoardDetail div.card-content{
font-size: 14px;
    word-break: break-word;
    line-height: 25px;
    color: #333;
    padding: 15px 30px 0;
}

div.showBoardDetail ul.card-content-group{
margin: 0;
    padding: 0;
    list-style: none;
}

div.showBoardDetail ul.card-content-group li {
    display: table;
    width: 100%;
    table-layout: fixed;
    margin-bottom: 11px;
        margin: 0;
    padding: 0;
    padding-left: 2px;
}

div.showBoardDetail div.card-content-title{
vertical-align: top;

    
        box-sizing: content-box;
    width: 20px;
    padding: 7px 20px 0 0;
    color: #555;
    font-weight: 700;
    font-size: 14px;
    margin-top: 30px;
    padding-top: 14px;
    word-break: break-all;
    
        position: relative;
        
            display: table-cell;
    height: 35px;

}

div.showBoardDetail i.icon-text{
background-image: url(/groovy/resources/images/kimyj/icon-text.svg)!important;
    width: 20px;
    height: 20px;
    position: absolute;
}

div.showBoardDetail div.card-content-memo{
margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    
    
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
    

}

div.showBoardDetail span.memo-span{
white-space: pre-wrap;
}

div.showBoardDetail span.memo-span a{

}

div.showBoardDetail div.card-vote{
display: block;
margin: 30px 0 0;
    padding: 35px 0 15px 0;
    border-top: 1px solid #eee;
    text-align: center;
    font-size: 0;

}
div.showBoardDetail button.vote-btn-yes{

    color: #00b19c;
 background-color: transparent;
    width: 74px;
    height: 34px;
    border: 1px solid #00b19c;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    text-align: center;
    font-weight: 500;
    font-size: 15px;
    
        cursor: pointer;
            font-family: inherit;
        line-height: normal;
   
    margin: 0;
    padding: 0;
}

div.showBoardDetail button.vote-btn-no{
    line-height: normal;
    margin: 0;
padding: 0;

    color: #ff6b6b;
        margin-left: 20px;
        background-color: transparent;
            width: 74px;
    height: 34px;
        border: 1px solid #ff6b6b;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    text-align: center;
    font-weight: 500;
    font-size: 15px;
    font-family: inherit;
    cursor: pointer;

}
	
div.showBoardDetail button.vote-btn-undefined{
    margin: 0;
    padding: 0;
 
  color: #777;
    margin-left: 20px;
    background-color: transparent;
        width: 74px;
    height: 34px;
 border: 1px solid #777;
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    -webkit-border-radius: 6px;
    border-radius: 6px;
    text-align: center;
    font-weight: 500;
    font-size: 15px;
        cursor: pointer;
            line-height: normal;
    font-family: inherit;
}
	


div.showBoardDetail div.card-footer{
padding: 0;
border: 0;
border-radius: 0;
background: #f9f9f9;

}

div.showBoardDetail ul.card-footer-group{
color: #555;
    list-style: none;
    margin: 0;
    padding: 0;
  border-top: 1px solid #ddd;
}

div.showBoardDetail li.card-footer-li{
    margin: 0;
    padding: 0;

display: flex;
    margin-top: -1px;
    padding: 10px 30px;
    padding-top: 20px;
    border-bottom: 1px solid #eee;
}
}

div.showBoardDetail div.comment-user-profile{
    float: left;
}

div.showBoardDetail span.comment-user-profile-span{

	width: 40px;
    height: 40px;
        border-radius: 16px;


display: inline-block;
   
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-color: #fff;
    border: 1px solid #eee;
   
    cursor: pointer;
   
    box-sizing: border-box;
    vertical-align: middle;
    background-image: url('<%=ctxPath %>/resources/images/kimyj/profileImg-default.png');


}	
			               
div.showBoardDetail div.comment-container{
display: block;

    
    position: relative;
   
    width: calc(100% - 52px);
    margin-left: 10px;
  
    box-sizing: border-box;
    float: left;

}

div.showBoardDetail div.comment-user-area{
width: 100%;
    line-height: 21px;
}
div.showBoardDetail div.comment-user-area:after{
    display: block;
    content: "";
    clear: both;
}
div.showBoardDetail div.comment-user{
float: left;
}
    
div.showBoardDetail span.comment-user-name{
    display: inline-block;
    font-weight: 700;
    font-size: 14px;
    color: #555;

}		
			                  
div.showBoardDetail span.comment-user-position	{
display: inline-block;
    font-size: 14px;
    color: #555;
}		 

div.showBoardDetail span.record-date{
display: inline-block;
    margin-top: -2px;
    font-size: 14px;
    font-family: Roboto;
    color: #999;
        margin-left: 5px;
}			                     

div.showBoardDetail div.comment-writer-menu{
float: right;
}


div.showBoardDetail button.card-edit{
margin: 0;
    padding: 0;
font-size: 14px;
    color: #999;
    cursor: pointer;
     display: inline-block;
   border-radius: 0;
    border: 0;
    background-color: transparent;
        font-family: inherit;
            line-height: normal;
    margin: 0;
   
}
div.showBoardDetail button.card-delete{
margin: 0;
    padding: 0;
    display: inline-block;
    font-size: 14px;
    color: #999;
    cursor: pointer;
    
    border-radius: 0;
    border: 0;
    background-color: transparent;
        font-family: inherit;
            line-height: normal;
    margin: 0;
    margin-left: 5px;
   
}











div.showBoardDetail button.comment-edit{
margin: 0;
    padding: 0;
font-size: 14px;
    color: #999;
    cursor: pointer;
     display: inline-block;
   border-radius: 0;
    border: 0;
    background-color: transparent;
        font-family: inherit;
            line-height: normal;
    margin: 0;
   
}
div.showBoardDetail button.comment-delete{
margin: 0;
    padding: 0;
    display: inline-block;
    font-size: 14px;
    color: #999;
    cursor: pointer;
    
    border-radius: 0;
    border: 0;
    background-color: transparent;
        font-family: inherit;
            line-height: normal;
    margin: 0;
    margin-left: 5px;
   
}

div.showBoardDetail button.comment-cancell{
margin: 0;
    padding: 0;
font-size: 14px;
    color: #999;
    cursor: pointer;
     display: inline-block;
   border-radius: 0;
    border: 0;
    background-color: transparent;
        font-family: inherit;
            line-height: normal;
    margin: 0;
}

			                   
div.showBoardDetail div.comment-content{

}            
div.showBoardDetail div.comment-text-area{
}

div.showBoardDetail div.comment-text{
word-break: break-all;
    white-space: pre-wrap;
    line-height: 30px;
}	                
			              


div.showBoardDetail div.card-footer2{
  overflow: hidden;
  padding: 14px 30px;
  
  position: sticky;
  bottom: 0;
  margin: 0;
  background: #faf9f9;
 /*  box-shadow: 0 -2px 6px rgba(0, 0, 0, 0.06); */
}


div.showBoardDetail div.card-footer2.sticky {
  position: sticky;
  bottom: 0;
  margin: 0;
  background: #faf9f9;
  box-shadow: 0 -2px 6px rgba(0, 0, 0, 0.06);
}

div.showBoardDetail div.card-footer2 {
  cursor: default;
}


div.showBoardDetail div.comment-writer-profile{
    float: left;

}
div.showBoardDetail span.comment-writer-profile-span{
    cursor: default;
        width: 40px;
    height: 40px;
        border-radius: 16px;
        
        display: inline-block;
   
    background-repeat: no-repeat;
    background-size: cover;
    background-position: center;
    background-color: #fff;
    border: 1px solid #eee;
   background-image: url('<%=ctxPath %>/resources/images/kimyj/profileImg-default.png');
    cursor: pointer;
   
    box-sizing: border-box;
    vertical-align: middle;


}
	
div.showBoardDetail form.comment-writer-container{
margin: 0;
    padding: 0;
display: block;

    position: relative;
   
    width: calc(100% - 52px);
    margin-left: 10px;
   
    box-sizing: border-box;
        float: left;

}

div.showBoardDetail form.comment-writer-container fieldset{
position: relative;
    border: 0;
       margin: 0;
    padding: 0;

}

div.showBoardDetail div.comment-writer-text[contenteditable]{
 width: 100%;
  padding: 11px 60px 11px 20px;
  min-height: 44px;
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  color: #555;
  word-break: break-all;
  white-space: pre-wrap;
  cursor: text;
}

div.showBoardDetail input.comment-writer-text{
 width: 100%;
  padding: 11px 60px 11px 20px;
  min-height: 44px;
  background: #fff;
  border: 1px solid #ddd;
  border-radius: 4px;
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  color: #555;
  word-break: break-all;
  white-space: pre-wrap;
  cursor: text;
}

div.showBoardDetail div.comment-writer-text[contenteditable]:empty:before{
	    display: block;
    content: attr(placeholder);
    color: #999;
}


div.showBoardDetail div.comment-writer-text[contenteditable=true]:hover,
div.showBoardDetail div.comment-writer-text[contenteditable=true]:focus {
  border-color: #555;
  -webkit-box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.15);
  box-shadow: 2px 2px 6px rgba(0, 0, 0, 0.15);
}


div.showBoardDetail div.card-content-map{
width:100%;
height:200px; 
display: block; 
}

div.showBoardDetail i.icon-place{
  background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-place.svg')!important;
    width: 20px;
    height: 20px;
    position: absolute;
}

div.showBoardDetail i.icon-file-download{
  background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-file-download.svg')!important;
    width: 20px;
    height: 20px;
    position: absolute;
}
div.showBoardDetail div.card-content-place{
margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
}
div.showBoardDetail span.place-span{
white-space: pre-wrap;
}
div.showBoardDetail span.place-span div{
display: inline-block;
}

div span.place-span a{
margin-left: 8px;
    color: #6449fc;
    line-height: 26px;
    text-decoration: underline;
    text-underline-position: under;
}
div.showBoardDetail div.card-content-download{
	margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
}
div.showBoardDetail span.download-span{
white-space: pre-wrap;
}
div.showBoardDetail span.download-span a{
color: #6449fc;
text-decoration: underline;
text-underline-offset : 2px;
}

div.showBoardDetail h3.card-title i{

    /* width: 20px;
    height: 20px; */
    display: inline-block;

      vertical-align: middle;
}


div.showBoardDetail div.card-content-share{
	margin-top: 30px;
    padding-top: 10px;
    vertical-align: top;
    word-break: break-all;
    position: relative;
    display: table-cell;
    height: 35px;
    color: #333;
}

div.showBoardDetail span.share-span{
white-space: pre-wrap;
}

div.showBoardDetail i.icon-share{
  background-image: url('<%=ctxPath %>/resources/images/kimyj/icon-share.svg')!important;
    width: 20px;
    height: 20px;
    position: absolute;
}


div.showBoardDetail div.voteTotalCnt{
display: block;
    overflow: hidden;
       margin-bottom: 10px;
}
div.showBoardDetail span.yesCnt{
color: #00b695;
   
    font-size: 15px;
    
    line-height: 19px;
    
        position: relative;
    display: flex;
    cursor: pointer;
}

div.showBoardDetail span.noCnt{
    margin-left: 55px;
        color: #fb2a2a;
        
    font-size: 15px;
        line-height: 19px;
        
        display: flex;
         cursor: pointer;
}
div.showBoardDetail span.undefinedCnt{
  margin-left: 55px;
        color: #999;
      
    font-size: 15px;
        line-height: 19px;
        
        display: flex;
         cursor: pointer;
}

div.showBoardDetail span.yesCnt span{
color: #00b695;
line-height: 19px;
   font-size: 15px;
}

div.showBoardDetail span.noCnt span{
color: #fb2a2a;
line-height: 19px;
    font-size: 15px;
}
div.showBoardDetail span.undefinedCnt span{
color: #999;
line-height: 19px;
   font-size: 15px;
}


div.showBoardDetail div.vote-group em{
    margin-left: 2px;
    font-weight: 700;
    font-size: 16px;
       font-style: normal;
}



div.showBoardDetail div.vote-group{
    position: relative;
  /*   display: flex; */
    -webkit-box-pack: justify;
    justify-content: space-between;
    
  /*   padding: 14.5px 30px; */
    background: #fff;

}


div.showBoardDetail div.vote-yes-group{
    display: inline-block;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    justify-content: flex-end;
    height: 40px;
}

div.showBoardDetail ul.vote-yes-ul{
    overflow: hidden;
    position: absolute;
    z-index: 1;
   /*  top: 50px; */
    right: 390px;
  /*   background: transparent; */
  background:#fff;
    border: 1px solid #00b695;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    padding: 5px 5px;
    max-width: 200px;
   max-height: 200px;
    text-align: left;
        border-radius: 6px;
        color: #00b695;
        
         display: none;
         
         overflow: scroll;
    -ms-overflow-style: none;
    scrollbar-width: none;

}
div.showBoardDetail ul.vote-yes-ul::-webkit-scrollbar {
    display: none;
}

div.showBoardDetail ul.vote-yes-ul li{
display: block;
    position: relative;
}

div.showBoardDetail div.vote-no-group{
   display: inline-block;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    justify-content: flex-end;
    height: 40px;
}
div.showBoardDetail ul.vote-no-ul li{
display: block;
    position: relative;
}

div.showBoardDetail ul.vote-no-ul{
      overflow: hidden;
    position: absolute;
    z-index: 1;
   /*  top: 50px; */
    right: 300px;
  /*   background: transparent; */
  background:#fff;
    border: 1px solid #fb2a2a;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    padding: 5px 5px;
    max-width: 200px;
    max-height: 200px;
    text-align: left;
        border-radius: 6px;
        color: #fb2a2a;

 display: none;
 
 overflow: scroll;
    -ms-overflow-style: none;
    scrollbar-width: none;
}
div.showBoardDetail ul.vote-no-ul::-webkit-scrollbar {
    display: none;
}

div.showBoardDetail div.vote-undefined-group{
   display: inline-block;
    -webkit-box-align: center;
    align-items: center;
    -webkit-box-pack: justify;
    justify-content: flex-end;
    height: 40px;
}

div.showBoardDetail ul.vote-undefined-ul{
      overflow: hidden;
    position: absolute;
    z-index: 1;
   /*  top: 50px; */
    right: 210px;
  /*   background: transparent; */
  background:#fff;
    border: 1px solid #777;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
    padding: 5px 5px;
    max-width: 200px;
   max-height: 200px;
    text-align: left;
        border-radius: 6px;
        color: #777;
        
        display: none;

overflow: scroll;
    -ms-overflow-style: none;
    scrollbar-width: none;
}
div.showBoardDetail ul.vote-undefined-ul::-webkit-scrollbar {
    display: none;
}

div.showBoardDetail ul.vote-undefined-ul li{
display: block;
    position: relative;
}

div.showBoardDetail ul.vote-undefined-ul li div, div.showBoardDetail ul.vote-no-ul li div, div.showBoardDetail ul.vote-yes-ul li div{
font-size: 13px;

}


div.showBoardDetail input.comment-writer-text:hover,div.showBoardDetail input.comment-writer-text:focus {
	
	border: 1px solid #6449fc  !important;
}


div.comment-text-area input.comment-writer-text{
margin-top: 10px;
margin-bottom: 10px;
}


div.showBoardDetail div.comment-header{
padding: 10px 30px 0 30px;
   /*  border-top: 1px solid #ddd; */
}


h3.card-title i span {
 position: relative;
}




/* 댓글 페이징 */
div.comment-header ul{
list-style: none;
padding: 0;
margin: 0;
text-align: center;

}
div.comment-header ul li{
display: inline;
color: #6449fc;
font-size: 15px;
font-weight: 600;
    cursor: pointer;
    background-color: transparent;
}

div.comment-header ul li.numberli{
padding-left: 7px;
padding-right: 7px;
}
div.comment-header ul li.numberli:last-child{
padding-right: 15px;
}

div.comment-header ul li a{

color: #555;
font-size: 14px;
font-weight: 600;
    cursor: pointer;

}

div.comment-header ul li span{
position: relative;
top:6.5px;
padding: 0;
margin: 0;
}
/* 글한개보기 css 끝 */
	
</style>

<script type="text/javascript">
/* 	$('.modal').on('hidden.bs.modal', function (e) {
		$(this).find('form')[0].reset();
	}); 
	 */
	
	$(document).ready(function() {
		 <%-- === #166. 스마트 에디터 구현 시작 === --%>
	 	//전역변수
	 	<%--
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "content",
	        sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        },
	        fOnAppLoad: function(){
	        	$("iframe").css("width","100%").css("height","300px");
	        }
	    });
	    
	     --%>

	     // === 댓글 입력후 엔터하기 === //
			//$("input#commentContent").keydown(function(key){
			$(document).on('keyup', 'input#commentContent', function (event) {
				
				if(event.keyCode == 13){
					alert(fk_board_seq);
					goAddComment(fk_board_seq);
					
					
				}
			});
				
		 $("div.showBoardDetail").hide();
		<%-- === #166. 스마트 에디터 구현 시작 === --%>
	 	<%-- //전역변수
	    var obj = [];
	    
	    //스마트에디터 프레임생성
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: obj,
	        elPlaceHolder: "smarteditor2",
	        sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,            
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,    
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true,
	        },
	         fOnAppLoad: function(){
	        	$("iframe").css("width","100%").css("height","300px");
	        	editBoardModal();
	        	
	        } 
	    }); --%>
		
	    $(document).on("click", "div.card-header button.close", function(){
			$("div.showBoardDetail").empty();
			$("div.showBoardDetail").hide();
		});
	    
	    $("div.showBoardDetail").hide();
	    

		
	    $('#writeBoardModal').on('show.bs.modal', function (e) {
	    	
			  
			  
		 });
	    
	    $('#writeBoardModal').on('hidden.bs.modal', function (e) {
	    	$("#content").empty();
	    });
		
	    
	    
		showEmpByDept();
		
		goReadBoard();
		
		//goViewComment(1);
		
		$("table.tblEmpList tr:last-child").css({'border-bottom':'none'});
		
		$("i.fa-thumbtack").click(function() {
			alert("상단 고정 클릭 => 상단 고정 하기");
		});
		
		// 프로젝트 즐겨찾기 토글
		$("i.fa-star").click(function() {
			if($(this).hasClass('far')) {
				$(this).removeClass('far');
				$(this).addClass('fas');
			}
			else {
				$(this).removeClass('fas');
				$(this).addClass('far');
			}
		});
		
		// 게시글 북마크 토글
		$("i.fa-bookmark").click(function() {
			if($(this).hasClass('far')) {
				$(this).removeClass('far');
				$(this).addClass('fas');
			}
			else {
				$(this).removeClass('fas');
				$(this).addClass('far');
			}
		}); // $("i.fa-bookmark").click(function() {})
		
		// 단체 채팅방 개설
		$("button#groupchat").click(function() {
			var openchatConfirm = confirm("프로젝트 채팅방을 개설하시겠습니까?\n프로젝트 참여자가 모두 참여하는 채팅방입니다.");
			
			if(openchatConfirm) {
				alert("프로젝트 참여자 모두와 단체 채팅하기 => 팝업창");
				openChat();
			}
		});
		
		// 프로젝트 참여자명 검색 시 검색 목록 보여주기
		$("div#searchEmpList").hide();
		
		$("input#searchEmp").keyup(function() {
			
			const wordLength = $(this).val().trim().length;
			
			if(wordLength == 0) {
				$("div#searchEmpList").hide();
				$("div#defaultEmpList").show();
			}
			else {
				$.ajax({
					url:"<%= ctxPath %>/searchEmp.groovy",
					type:"POST",
					data:{"searchType":"name",
						  "searchWord":$("input#searchEmp").val()},
					dataType:"JSON",
					success:function(json) {
						
						let html = "";
						if(json.length > 0) { // 검색된 데이터가 있는 경우
							$.each(json, function(index, item) {
								html += "<tr style='border-bottom: solid 1px #eeeeee;'>";
								html += "	<td class='empProfile' style='cursor: pointer;' onclick='javascript:showEmpProfile(\""+item.pk_empnum+"\")'>";
								html += "		<img class='my-2 mr-2' src='<%= ctxPath %>/resources/images/프로필사진/"+ item.emppicturename +"' style='border-radius: 15px;'>";
								html += "		<span class='name font-weight-bold'>" + item.name + "</span>";
								html += "		<input type='hidden' id='pk_empnum' value='" + item.pk_empnum + "'/>"	
								html += "	</td>";
								html += "	<td align='right'>";
								html += "		<span style='background-color: #6449fc; border-radius: 20px; color: white; padding: 5px 10px; font-size: 10pt;'>" + item.spotnamekor + "</span>";
								html += "		<i class='fas fa-ellipsis-v ml-2' data-toggle='dropdown'></i>";
								html += "		<div class='dropdown-menu prjSetting my-0 py-0'>";
								html += "			<a class='dropdown-item' href=''>내보내기</a>";
								html += "			<a class='dropdown-item' href=''>" + item.spotnamekor + "해제</a>";
								html += "		</div>";
								html += "	</td>";
								html += "</tr>";
							});
						}
						else {
							html += "<tr>";
							html += "	<td colspan='2' align='center'>검색 결과가 없습니다.</td>";
							html += "</tr>";
						}
						
						$("table#tblSearchEmpList").html(html);
						$("div#defaultEmpList").hide();
						$("div#searchEmpList").show();
					},
					error: function(request, status, error) {
	                  	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                }
				}); // end of $.ajax({})
			}
			
		}); // end of $("input#searchWord").keyup(function() {})
		
		
		// 부서별 직원 목록 보여주기
		$("a#dept").click(function() {
			
			const $target = $(event.target);
			const pk_deptnum = $target.next().val();
			const deptnameeng = $target.next().next().val();
			
			$.ajax({
				url:"<%= ctxPath %>/showEmpByDept.groovy",
				type:"GET",
				data:{"pk_deptnum":pk_deptnum},
				dataType:"JSON",
				success:function(json) {
					
					let html = "<table class='tblEmpList' id='tblEmpList' style='width: 100%;'>";
					
					$.each(json, function(index, item) {
						html += "<tr style='border-bottom: solid 1px #eee;'>";
						html += "	<td class='empProfile' style='cursor: pointer;' onclick='javascript:showEmpProfile(\""+item.pk_empnum+"\")'>";
						html += "		<img class='my-2 mr-2' src='<%= ctxPath %>/resources/images/프로필사진/"+ item.emppicturename +"' style='border-radius: 15px;'";
						html += "		<span class='name font-weight-bold'>" + item.name + "</span>";
						html += "		<input type='hidden' id='pk_empnum' value='" + item.pk_empnum + "'/>";
						html += "	</td>";
						html += "	<td align='right'>";
						html += "		<i class='far fa-comment-dots fa-lg' onclick='javascript:openPersonalChat(\""+item.pk_empnum+"\")'></i>";
						html += "	</td>";
						html += "</tr>";
					});
				
					html += "</table>";
					
					$("div#"+deptnameeng).html(html);
				},
				error: function(request, status, error) {
                  	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
                }
			});
		});
		
		
		
		
		/////////////////////////////////////////
		
		
		

$(document).on('keyup', 'form.comment-writer-container input.comment-writer-text', function (event) {
	if(event.keyCode == 13){ 
		const fk_board_seq = $("input.boardno").val();

		commentAdd(fk_board_seq);
	}
});

		 
		
		
		
		
	}); // end of $(document).ready(function() {})
	
	
	
	
	
function showEmpByDept() {
	
	const length = ${requestScope.empvoList.size()};
}
	

// 프로필을 보여주는 메소드
function showEmpProfile(pk_empnum) {
	
	$.ajax({
		url:"<%= ctxPath %>/showEmpProfile.groovy",
		data:{"pk_empnum":pk_empnum},
		dataType:"JSON",
		success:function(json) {
			$('div#showAllEmpModal').modal('hide');
			$('div#showEmpProfileModal').modal();
			
			$("div#showEmpProfileModal .modal-header").css({'background-image':'url("<%= ctxPath %>/resources/images/프로필사진/'+json.emppicturename+'")',
															'background-repeat':'no-repeat',
															'background-size':'100%'});
			$("div#empName").html(json.name);
			$("td#email").html(json.email);
			$("td#phone").html(json.phone);
			$("button#goChat").attr("onClick", "openPersonalChat('" + pk_empnum + "');");
		},
		error: function(request, status, error) {
           	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }
	}); // $.ajax({})
}
	
// 개인 채팅을 활성화하는 메소드
function openPersonalChat(pk_empnum) {
	
	$.ajax({
		url:"<%= ctxPath %>/openPersonalChat.groovy",
		type:"GET",
		data:{"pk_empnum":pk_empnum},
		dataType:"JSON",
		success:function(json) {
			$('div#showEmpProfileModal').modal('hide');
			
			var url = "<%= ctxPath %>/openPersonalChatEnd.groovy?name=" + json.name;
            var popup_name = "openChat";
            var option = "width = 450, height = 650, top = 300, left = 600";
			
			window.open(url, popup_name, option);
		},
		error: function(request, status, error) {
           	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
           }
	}); // $.ajax({})
}
	
/* 	function showtest(pk_board_seq){
		alert(pk_board_seq);
		
	} */
	
	  
	  // === 페이징 처리 안한 글 읽어오기  === //
	  function goReadBoard() {
		  $("div.showBoardDetail").hide();
		  
		  $("div#feedAllbox").empty();
		  $.ajax({
			  url:"<%= request.getContextPath()%>/readBoard.groovy",
			  dataType:"json",
			  success:function(json){
				  
				 // console.log(json);
				  
				   if(json.length > 0) {
					  $.each(json, function(index, item){
						  
						 	html = "";
						  
							html += "<div class='card mb-4 feedAll' onclick='commentShow(\""+item.pk_board_seq+"\",1)'>";
							html += "<div class='card-body'>";
							html +=  "<table style='width: 95%; margin: auto; padding: 10px;' class='tbl_boardInCard mb-3'>";
							html +=  "<thead>";
							html +=  "<tr>";
							html +=  "<td style='vertical-align:middle;'>";
							html +=  "<a style='margin-right: 5px;'><img style='height:40px; width:40px;      border-radius: 16px;' class='writer-photo' src='<%= ctxPath%>/resources/images/프로필사진/"+item.emppicturename+"'  alt='icon-writerprofile'  /></a>";
							 html +=  "<strong id='write_name' style='vertical-align:middle; color:#555; margin-right: 5px;'>["+item.deptnamekor +" : "+item.spotnamekor+"] " + item.name + "</strong><span></span>  <span id='write_date' style='color:#aaa;'>"+ item.b_regdate + "</span>  ";
							html +=  "</td>";
						   	  
						   	  
						   	html +=  "<td align='right'>"
						   	html +=  "<i class='fas fa-thumbtack'></i>";
						   	html +=  "<i style='padding:3px; cursor:pointer; margin-left:5px;' class='fas fa-ellipsis-v' data-toggle='dropdown'></i>";
						   	html +=  "<div class='dropdown-menu'>";
						   <%-- 	html +=  "  	<a class='dropdown-item' href='<%=ctxPath%>/editBoard.groovy?pk_board_seq="+item.pk_board_seq+"'><i class='far fa-board-alt'></i>수정</a>"; --%>
						    html +=  "  	<a class='dropdown-item'  onclick='editBoardModal("+index+","+item.pk_board_seq+")' data-toggle='modal' data-target='#editBoardModal' style=' cursor: pointer;'><i class='far fa-board-alt'></i>수정</a>";
						   	html +=  "  	<a class='dropdown-item' onclick='delBoard("+item.pk_board_seq+")' href='#'><i class='far fa-trash-alt'></i>삭제</a>";
						   	/* html +=  "  	<a class='dropdown-item' href='#'><i class='fas fa-external-link-alt'></i>다른 프로젝트에 복사</a>";
						   	html +=  "  	<a class='dropdown-item' href='#'><i class='far fa-clone'></i>링크 복사</a>"; */
						   	html +=  "</div>";
						   	html +=  "</td>";
						   	html +=  "</tr>";
						   	html +=  "</thead>";
						   	html +=  "<tbody>";
						   	html +=  "<tr>";
						   	html +=  "<td id='write_subject"+index+"' colspan='2' style='font-size: 18pt;'>"+ item.b_subject + "</td>";
						   	html +=  "</tr>";
						   	html +=  "<tr style='border-top: solid 1px lightgray; border-bottom: solid 1px lightgray; height: 150px;'>";
						   	html +=  "<td id='write_content"+index+"' colspan='2'>"+ item.b_content + "</td>";
						   	html +=  "</tr>";
						   	
						    <%-- === 첨부파일이 있는 경우 === --%> 
							if(item.b_orgfilename != null){ // 로그인을 한 경우 a가 걸리고,
						   	html +=   '<tr><td  colspan="2"><i class="fas fa-paperclip"></i><a id="write_file'+index+'" href="<%= ctxPath%>/downloadfile.groovy?pk_board_seq='+item.pk_board_seq+'">'+item.b_orgfilename+'</a></td>  </tr>';
							}
							//alert(item.b_orgfilename);
						   	
						   	html +=  "<tr>";
						    html +=  "<td style='width: 50%;'>";
							html +=  "<i class='far fa-meh-blank' data-toggle='dropdown'></i>좋아요&nbsp;&nbsp;&nbsp;";
							
							html +=  "<div class='dropdown-menu emotion'>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-smile-beam'></i><span>좋아요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-kiss-beam'></i><span>부탁해요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-sad-tear'></i><span>힘들어요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-grin-stars'></i><span>훌륭해요</span></a>";
							html +=  "<a class='dropdown-item' href=''><i class='far fa-grin-hearts'></i><span>감사해요</span></a>";
							html +=  "</div>";
							html +=  "<i class='far fa-bookmark'></i>북마크";
							/* html +=  "<i class='fas fa-bookmark'></i> 북마크 설정했을때"; */
							html +=  "</td>";
							html +=  "<td align='right'>댓글(댓글수) / 읽음(조회수)</td>";
							html +=  "</tr>";
							html +=  "</tbody>";
							
							html += '<tbody id="commentDisplay'+item.pk_board_seq+'"></tbody>'; /* <ul class="card-footer-group"></ul> */
							
							html +=  "</table> 	";
							html +=  "</div>";
							
							 html+= "<div><ul class='commentDisplay"+item.pk_board_seq+"'></ul></div>" ;
								
							html +=  "<div class='card-footer' align='center'>";
							html +=  " <form name='addCommentFrm' id='addCommentFrm'><i class='far fa-user-circle'></i>";
							html +=  '<input type="hidden" name="fk_board_seq" id="fk_board_seq" class="fk-board-seq" value="'+item.pk_board_seq+'" />';
							html +=  "<input type='text' id='commentContent"+item.pk_board_seq+"'  class='comment-Content comment-writer-text form-control' style='display: inline-block; width: 90%;' placeholder='댓글 입력 Enter' /><input type='text' style='display:none;'> <!--의미없는 태그-->";
							
							
 		/* 					html +=  '<input type="hidden" name="fk_empnum" id="fk_empnum" value="'+${sessionScope.loginuser.pk_empnum}+'" />';
							html +=  '<input type="hidden" name="cmt_name" id="cmt_name" value="'+'${sessionScope.loginuser.name}'+'" />';  */
							html +=  "<label class='btn_inputFile' for='inputFile'><i class='fas fa-paperclip ml-2'></i></label>";
							html +=  "<input type='file' id='commentAttach' style='display: none;'/>";
						    html +=  '<button type="button" class="btn btn-dark btn-sm mr-3" onclick="goAddComment('+item.pk_board_seq+')" >댓글쓰기 확인</button>'; /* style="display:none;" */
							html +=  "</form></div></div><div id='feedpaging'></div>";
							
							/* commentShow(item.pk_board_seq,1); */
							$("div#feedAllbox").append(html);
							
							
							
								
						  /* 
						  
						  goViewComment(index , item.pk_board_seq) ;
						   */
							
						  
					   });
					
					  
				  }
				  else {
					  html += "<div>등록된 댓글이 없습니다.</div>";
	              
					  $("div#feedAllbox").append(html); 
				  }
				  
				   
				   
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
			  
			  
			  //$("div#feedAllbox").html(html); 
			  
		  });
		  
	  }// end of function goReadComment(){}--------------------------
	  
	  
	// === 페이징 처리 안한 글목록 읽어오기  === //
	  function goReadBoardList(currentShowPageNo) {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/readBoard.groovy",
			  data:{"currentShowPageNo":currentShowPageNo},
			  dataType:"json",
			  success:function(json){
				  
				 // console.log(json);
				  
				   if(json.length > 0) {
					   
					 	html = "";
						  
						html += "<div class='card mb-4 feedAll'>";
						html += "<div class='card-body'>";
						html +=  "<table style='width: 95%; margin: auto; padding: 10px;' class='tbl_boardInCard mb-3'>";
						html +=  "<thead>";
						html +=  "<tr><th style='width: 70px;  text-align: center;'>글번호</th>";
						
						html +=   '<th style="width: 360px; text-align: center;">제목</th>';
						html +=   '<th style="width: 70px;  text-align: center;">성명</th>';
						html +=   '<th style="width: 150px; text-align: center;">날짜</th>';
						/* html +=   '<th style="width: 70px;  text-align: center;">조회수</th>'; */
						
					   	html +=  "</tr>";
					   	html +=  "</thead>";
					   	html +=  "<tbody>";
					   	
					   	
					  $.each(json, function(index, item){
	
						   	html +=  "<tr id='tablehover' style='cursor: pointer;' onclick='javascript:goBoardView("+item.pk_board_seq+")'>";
						   	html +=  "<td id='list_seq"+index+"'  >"+ (json.length - index)+ "</td>";
						   	html +=  "<td id='list_subject"+index+"'  ><span class='list_subject' >"+ item.b_subject+"</span>"; 
						   	${boardvo.subject}
						    <%-- === 첨부파일이 있는 경우 === --%> 
							if(item.b_orgfilename != null){ // 로그인을 한 경우 a가 걸리고,
						   	html +=   '<i class="fas fa-paperclip"></i>';
							}
							html += "</td>";
						   	
						   	html +=  "<td id='list_writer"+index+"' >"+ item.name + "</td>";
						   	html +=  "<td id='list_date"+index+"' >"+ item.b_regDate + "</td>";
						   	html +=  "</tr>";
						   	
					   });
					  
						html +=  "</tbody>";
						html += '<tbody id="commentDisplay">';
						
							//commentShow(item.pk_board_seq);
						
						html += '</tbody>';
						html +=  "</table> 	";
						html +=  "</div>";
						html +=  "</div>";
						
					  $("div#feedAllbox").html(html); 
					  /* 
					  
					  goViewComment(index , item.pk_board_seq) ;
					   */
					  
					  
				  }
				  else {
					  html += "<div>등록된 글이 없습니다.</div>";
	              
				  	  $("div#feedAllbox").append(html); 
				  }
				   commentShow(pk_board_seq,1);
				  
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
			  
			  
			 
			  
		  });
		  
	  }// end of function goReadComment(){}--------------------------
	  <%-- 
	// 선택글 한개 보여주는 메소드
	function goBoardView(pk_board_seq) {
		
		$.ajax({
			url:"<%= ctxPath %>/goBoardView.groovy",
			data:{"pk_board_seq":pk_board_seq},
			dataType:"JSON",
			success:function(json) {
				$('div#showAllEmpModal').modal('hide');
				$('div#showEmpProfileModal').modal();
				
				$("div#showEmpProfileModal .modal-header").css({'background-image':'url("<%= ctxPath %>/resources/images/프로필사진/'+json.emppicturename+'")',
																'background-repeat':'no-repeat',
																'background-size':'100%'});
				$("div#empName").html(json.name);
				$("td#email").html(json.email);
				$("td#phone").html(json.phone);
				$("button#goChat").attr("onClick", "openPersonalChat('" + pk_empnum + "');");
			},
			error: function(request, status, error) {
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // $.ajax({})
	}
	   --%>
	  
//자세히보기
function goBoardView(pk_board_seq) {

	 $.ajax({
         url: "<%= ctxPath%>/goBoardView.groovy",
         data:{"pk_board_seq":pk_board_seq},
         dataType: "json",
         success:function(json) {
        	 
        var pk_empnum = "${sessionScope.loginuser.pk_empnum}";
        var regdate = moment(json.map.B_REGDATE).format('YYYY-MM-DD HH:mm'); 
        let html = "";

         html += '<div class="card-header">';
         html += '<h3 class="card-title">';
         html += '<i><span class="material-icons-outlined"> bookmark_border </span></i>';/* <!-- 아이콘 --> */
         html += '<span class="js-project-title-button">게시글-'+pk_board_seq+'</span>';/*  <!-- 대분류캘린더-소분류캘린더 --> */
         html += '</h3>';
         html += '<button type="button" class="close">';
         html += '<span class="material-icons-outlined"> close </span>';
         html += '</button>';
         html += '</div>';
   	
         html += '<div class="card-body">';
         html += '<div class="card-scroll">';
 		
         html += '<div class="card-body-top">';
   	 		
         html += '<div class="card-author">';
         html += '<span class="card-profileImg">';
         
      /*    if(json.map.EMPPICTURENAME != null){ */
         	html += '<a style="margin-right: 5px;"><img style="height:40px; width:40px;      border-radius: 16px;" class="writer-photo" src="<%= ctxPath%>/resources/images/프로필사진/'+json.map.EMPPICTURENAME+'"  alt="icon-writerprofile"  /></a>';
        /*  } */
         
         html += '</span>';/* <!-- 프로필이미지 --> */
         html += '<dl class="card-author-info">';
         html += '<dt>';
         html += '<strong class="author-name"> ['+json.map.DEPTNAMEKOR+' : '+json.map.SPOTNAMEKOR+'] '+json.map.NAME+'</strong>';/* <!-- 작성자이름 -->	  */  		
         html += '<span class="author-date">'+regdate+'</span>';/* <!-- 작성시간 --> */
         html += '</dt>';
         html += '</dl>';
         html += '</div>';
   	 			
         html += '<div>';
         
 				
         if('${sessionScope.loginuser.pk_empnum}' == json.map.FK_EMPNUM){
        	 html += '<div class="card-option">';
        
         html += '<button type="button" class="card-edit" onclick="editBoardModal('+pk_board_seq+')">수정</button>';
         html += '<button type="button" class="card-delete" onclick="delBoard('+pk_board_seq+')">삭제</button>';
         html += '</div>';
         }
        
         html += '</div>';
         
         html += '</div>';
  
         html += '<div class="card-body-bottom">';
         /*         html += '<div class="card-schedule-date">';
          html += '<strong class="card-month" style="color:'+json.map.COLOR+'">'+miniCalendarYM+'</strong><strong class="card-day" style="background-color:'+json.map.COLOR+'">'+miniCalendarDD+'</strong>';<!-- 미니달력 --> 
         html += '</div>';*/
         html += '<div class="card-schedule-title-area">';
         html += '<h4 class="card-schedule-title">'+json.map.B_SUBJECT+'</h4>'; /* <!-- 제목 --> */
         html += '<div class="card-schedule-day">';
/*          html += '<span class="card-schedule-startDate">'+startdate+' ('+startdate_day+'), '+startdate_time+'</span>'; <!-- 시작일 -->
         html += '<span class="card-schedule-endDate">'+enddate+' ('+enddate_day+'), '+enddate_time+'</span>'; <!-- 종료일 --> */
         html += '</div>';
         html += '</div>';
         html += '</div>';
 		
         html += '<div class="card-container">';
         html += '<div class="card-content">';
 				
         html += '<div class="card-content2">';
         html += '<ul class="card-content-group">';	
 				
         html += '<li>';
         html += '<div class="card-content-title"><i class="icon-text"></i></div>';
         html += '<div class="card-content-memo">';
         html += '<span class="memo-span"><div>'+json.map.B_CONTENT+'</div></span>';
         html += '</div>';
         html += '</li>';
      /*    if(json.map.ADDRESSNAME != "-"){
	         html += '<li>';
	         html += '<div class="card-content-title"><i class="icon-place"></i></div>';
	         html += '<div class="card-content-place">';
	         html += '<span class="place-span"><div>';
	        	 if(json.map.PLACENAME != "-"){
	        		html += json.map.PLACENAME+' : ';
	        	 }
		         if(json.map.ADDRESSNAME != "-"){
		        	 html +=json.map.ADDRESSNAME;
	        	 }
		         if(json.map.PLACEPHONE != "-"){
		        	 html +=' 번호 : '+json.map.PLACEPHONE;
	        	 }
		         html +='</div><a  href="'+json.map.PLACEURL+'" target="_blank">상세보기</a></span>';
	         html += '</div>';
	         html += '</li>'; 
	         
	         html += '<li>';
	         html += '<div class="card-content-title"></div>';
	         html += '<div class="card-content-map" id="card-content-map">';
	         html += '</div>';
	         html += '</li>';
         }		*/
         if(json.map.B_ORGFILENAME != null){
	         html += '<li>';
	         html += '<div class="card-content-title"><i class="icon-file-download"></i></div>';
	         html += '<div class="card-content-download">';
	         html += '<span class="download-span"><a href="<%= ctxPath%>/downloadfile.groovy?pk_board_seq='+json.map.PK_BOARD_SEQ+'">'+json.map.B_ORGFILENAME+'</a></span>';
	         html += '</div>';
	         html += '</li>';
	         
         }
         /* 
         if(json.map.JOINUSER != "-"){
	         html += '<li>';
	         html += '<div class="card-content-title"><i class="icon-share"></i></div>';
	         html += '<div class="card-content-share">';
	         html += '<span class="share-span"><div>'+json.map.JOINUSER+'</div></span>';
	         html += '</div>';
	         html += '</li>';
	         
         }
          */

         html += '</ul>';
         html += '</div>';
 			/* 		
		 if(json.map.VOTE == 1){/* 참석유무 *//*
			 html += '<div class="card-vote">';
			 
		        html += '<div class="vote-group">';			
		         html += '<div>';
		         
		         
		         html += '<div class="vote-yes-group">';
		         html += '<span class="yesCnt">';
			     html += '<span>참석</span><em>0</em>';
			   
			     html += '</span>';
		         html += '<ul class="vote-yes-ul">';
		         html += '</ul>';
		         
		         html += '</div>';
		         
		         html += '<div class="vote-no-group">';
		         html += '<span class="noCnt">';
				 html += '<span>불참</span><em>0</em>';

				 html += '</span>';
		         html += '<ul class="vote-no-ul">';
		         html += '</ul>';

		         html += '</div>';
		         
		         html += '<div class="vote-undefined-group">';
		         html += '<span class="undefinedCnt">';
				 html += '<span>미정</span><em>0</em>';
				
				 html += '</span>';	
		         html += '<ul class="vote-undefined-ul">';
		         html += '</ul>';

		         html += '</div>';
		         
		         
		         
		         html += '</div>';
		         
		         html += '</div>';
			 

		         
	         html += '<button class="vote-btn-yes" onclick="voteYesAdd('+json.map.PK_SCHEDULENO+')">참석</button>';
	         html += '<button class="vote-btn-no" onclick="voteNoAdd('+json.map.PK_SCHEDULENO+')">불참</button>';
	         html += '<button class="vote-btn-undefined" onclick="voteUndefinedAdd('+json.map.PK_SCHEDULENO+')">미정</button>';
	         html += '</div>';		
		 }			 */
         html += '</div>';
         html += '</div>';
 		
         html += '<div class="card-footer">';
         /* html += '<div class="comment-header"></div>'; */
         
         html += '<ul class="card-footer-group">';
 	/* 			
         html += '<li class="card-footer-li">';
 			               
         html += '<div class="comment-user-profile">';
         html += '<span class="comment-user-profile-span"></span>';
         html += '</div>';
 			            
         html += '<div class="comment-container">';
         html += '<div class="comment-user-area">';
         html += '<div class="comment-user">';
         html += '<span class="comment-user-name">김영준</span>';
         html += '<span class="comment-user-position"></span>';
         html += '<span class="record-date">2022-05-14 07:26</span>'; 
         html += '</div>';
 			                    
         html += '<div class="comment-writer-menu">';
         html += '<button type="button" class="comment-edit">수정</button>';
         html += '<button type="button" class="comment-delete">삭제</button>';
         html += '</div>'; 
         html += '</div>';
 			                
         html += '<div class="comment-content">';
         html += '<div class="comment-text-area">';
	     html += '<div class="comment-text"><div>댓글</div></div>';
	 	 html += '</div>';	
         html += '</div>'; 
         html += '</div>';

	     html += '</li>'; 
	     
	      */
		 html += '</ul>';
		 html += '<div class="comment-header"></div>';
		 html += '</div>';

		 html += '<div class="card-footer2">';
		 html += '<div class="comment-writer-profile">';
		 html += '<span class="comment-writer-profile-span"><a style="margin-right: 5px;"><img style="height:40px; width:40px;      border-radius: 16px;" class="writer-photo" src="<%= ctxPath%>/resources/images/프로필사진/${sessionScope.loginuser.emppicturename}"  alt="icon-writerprofile"  /></a></span>';
		 html += '</div>';

         html += '<form class="comment-writer-container">';
         html += '<fieldset>';
	  /*    html += '<div class="comment-writer-text" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>'; */
		 html += '<input type="text" class="comment-writer-text"  placeholder="댓글등록은 Enter키 입니다.">';
		 html += '<input type="text" style="display:none;">';
		/*  html += '<input type="hidden" class="boardno">'; */
		 html += '</fieldset>';                     
		 html += '</form>';
         html += '</div>';
		        	 
		        /*  <div class="card showBoardDetail"> */
		 
         $(".boardno").val(pk_board_seq);      
      
        /* 
         if(json.map.ADDRESSNAME != "-"){
         	$("div.card-content-map").hide();
         	showMap(json.map.ADDRESSNAME);
         } */
        
         $("div.showBoardDetail").html(html);
         commentShow(pk_board_seq,1);
         
         $("div.showBoardDetail").show();
        
         ////////////////////
         },
         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		}
         
   });
}	  
	  
	
	  // 특정 글을 수정하는 함수
	  function editBoardModal(index, pk_board_seq){
		  
		  //input 안에 원래 데이터 요소들을 넣어요~~
		  
		  const orgin_subject_text = $("td#write_subject"+index).text(); 
		  $('input#title_edit').attr('value',orgin_subject_text);
		 
		  const origin_content = $("td#write_content"+index).html(); // 원래의 제품후기 엘리먼트
	 	   //alert(origin_content);   
	 	  const orgin_content_text = $("td#write_content"+index).text(); // 원래의 제품후기 내용 
	 	  //alert(orgin_content_text);
		  $('input[name="pk_board_seq"]').attr('value',pk_board_seq); 
		  
		  const b_orgfilename = $("a#write_file"+index).text();
		  
		  
		 // alert(b_orgfilename);
		  
		  document.getElementById("b_content").value = orgin_content_text;
		 
		  /////////
		/* 
			  
			  $('.modal').on('hidden.bs.modal', function (e) {
					$(this).find('form')[0].reset();
				}); 
				 */
		
		  
		  
		 //  oEditors.getById["smarteditor2"].exec("PASTE_HTML", orgin_content_text); //내용밀어넣기
	  }
	  
	  
	  // 특정 글을 삭제하는 함수
	    function delBoard(pk_board_seq){
	       
	       const bool = confirm("정말로 댓글을 삭제하시겠습니까?");
	    //  console.log("bool => " + bool); // bool => true , bool => false
	       
	       if(bool) {
	       
	          $.ajax({
	             url:"<%= ctxPath%>/delBoard.groovy",
	             type:"POST",
	             data:{"pk_board_seq":pk_board_seq},
	             dataType:"JSON",
	             success:function(json) { // {"n":1} 또는 {"n":0}
	                if(json.isSuccess) {
	                   alert("글 삭제가 성공되었습니다.");
	                   location.reload();
	                   
	                }
	                else {
	                   alert("글 삭제가 실패했습니다.");
	                }
	             },
	             error: function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	             }
	          });
	       
	       }
	       
	    }// end of function delMyReview(review_seq) {}--------------------------  
	    
	  
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~댓글구역~~~~~~~~~~~~~	    
	 	// == 댓글쓰기 == 
	    function goAddComment(pk_board_seq){
	  	  
	  	  const commentContent = $("input.comment-Content").val().trim();
	  	  if(commentContent == "") {
	  		  alert("댓글 내용을 입력하세요!!");
	  		  return; // 종료
	  	  }
	  	  
	  	  if($("input#commentAttach").val() == "") {
	  		  // 첨부파일이 없는 댓글쓰기인 경우
	  		  goAddWrite_noAttach();
	  	  }
	  	  else {
	  		 // 첨부파일이 있는 댓글쓰기인 경우 
	  		 goAddWrite_withAttach();
	  	  }
	  	  
	    }// end of function goAddWrite() {}--------------------
	    
	    // == 파일첨부가 없는 댓글쓰기 
	    function goAddWrite_noAttach(){
	  	  
	  	  <%--
	  	      // 보내야할 데이터를 선정하는 또 다른 방법
	  		  // jQuery에서 사용하는 것으로써,
	  		  // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
	  		  const queryString = $("form[name=addCommentFrm]").serialize();
	  	  --%>
	  	  //const ${sessionScope.loginuser.pk_empnum}.val() 
	  	  const fk_board_seq = $("input.fk-board-seq").val();
	  	  $.ajax({
	  		  url:"<%= ctxPath %>/addComment.groovy",
	  		  data:{"fk_empnum":"${sessionScope.loginuser.pk_empnum}" 
	  			   ,"cmt_name":"${sessionScope.loginuser.name}"
	  			   ,"cmt_content":$("input.comment-Content").val() 
	  			   ,"fk_board_seq":fk_board_seq},
	  	 /*   또는
	  	      data:queryString, */	   
	  		  type:"POST",
	  		  dataType:"JSON",
	  		  success:function(json){
	  			 // "{"n":1,"name":"엄정화"}" 또는 "{"n":0,"name":"서영학"}"
	  			 
	  			 const n = json.n;
	  			 if(n == 0) {
	  				 alert(json.name + "님의 포인트는 300점을 초과할 수 없으므로 댓글쓰기가 불가합니다.");
	  			 }
	  			 else {
	  			  	console.log("댓글작성완료");
	  				 // goReadComment();  // 페이징 처리 안한 댓글 읽어오기
	  			     //goViewComment(1); // 페이징 처리한 댓글 읽어오기
	  			 }
	  			 
	  			 $("input.comment-Content").val("");
	  		  },
	  		  error: function(request, status, error){
	  				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  		  }
	  	  });
	  	  
	    }// end of function goAddWrite_noAttach() {}--------------------------
	    
	    
	    // ==== #169. 파일첨부가 있는 댓글쓰기 ==== // 
	    function goAddWrite_withAttach() {
	  	  <%-- === ajax로 파일을 업로드할때 가장 널리 사용하는 방법 ==> ajaxForm === //
	  		   === 우선 ajaxForm 을 사용하기 위해서는 jquery.form.min.js 이 있어야 하며
	  		       /WEB-INF/tiles/layout/layout-tiles1.jsp 와 
	  		       /WEB-INF/tiles/layout/layout-tiles2.jsp 에 기술해 두었다. 
	  	  --%>
	  	  
	  	  <%--
	  	      // 보내야할 데이터를 선정하는 또 다른 방법
	  		  // jQuery에서 사용하는 것으로써,
	  		  // form태그의 선택자.serialize(); 을 해주면 form 태그내의 모든 값들을 name값을 키값으로 만들어서 보내준다. 
	  		  const queryString = $("form[name=addWriteFrm]").serialize();
	  	  --%>
	  	  
	  	  const queryString = $("form[name=addCommentFrm]").serialize();
	  	  
	  	  $("form[name=addCommentFrm]").ajaxForm({
	  		  url:"<%= request.getContextPath()%>/addComment_withAttach.groovy",
	  		  data:queryString,
	  	 	  type:"POST",
	  	 	  enctype:"multipart/form-data",
	  		  dataType:"JSON",
	  		  success:function(json){
	  			 // "{"n":1,"name":"엄정화"}" 또는 "{"n":0,"name":"서영학"}"
	  			 
	  			 const n = json.n;
	  			 if(n == 0) {
	  				 alert(json.name + "님의 포인트는 300점을 초과할 수 없으므로 댓글쓰기가 불가합니다.");
	  			 }
	  			 else {
	  			  // goReadComment();  // 페이징 처리 안한 댓글 읽어오기
	  			     //goViewComment(1); // 페이징 처리한 댓글 읽어오기
	  			 }
	  			 
	  			 $("input#commentContent").val("");
	  			 $("input#commentAttach").val("");
	  		  },
	  		  error: function(request, status, error){
	  				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	  		  }
	  	  });
	  	  
	  	  $("form[name=addCommentFrm]").submit();
	  	 
	    }// end of function goAddWrite_noAttach() {}--------------------------
	    
	    
	    ////////////////////
		 <%--  
		  // === #127. Ajax로 불러온 댓글내용을  페이징 처리 하기  === //
		    function goViewComment(currentShowPageNo, index ) {
		  	  
		  	  $.ajax({
		  		  url:"<%= ctxPath%>/commentList.groovy",
		  		  data:{"fk_board_seq":$("input#fk_board_seq").val(),
		  			    "currentShowPageNo":currentShowPageNo},
		  		  dataType:"JSON",
		  		  success:function(json){
		  			  // 첨부파일 기능이 없을 시
		  			  // [{"name":"서영학","regDate":"2022-04-27 15:03:36","content":"열세번째 댓글 입니다."},{"name":"서영학","regDate":"2022-04-27 15:03:28","content":"열두번째 댓글 입니다."},{"name":"서영학","regDate":"2022-04-27 15:03:23","content":"열한번째 댓글 입니다."}] 
		  			  // 또는
		  			  // [] 
		  			  
		  			  // 첨부파일 기능이 추가된 경우
		  			  // [{"fileName":"202205030921151062130006872565.jpg","fileSize":"71317","name":"엄정화","regDate":"2022-05-03 09:21:16","content":"첨부파일 추가 연습2","seq":"6","orgFilename":"berkelekle심플라운드01.jpg"},{"fileName":" ","fileSize":" ","name":"엄정화","regDate":"2022-05-02 16:04:06","content":"파일첨부 연습 1","seq":"3","orgFilename":" "},{"fileName":" ","fileSize":" ","name":"엄정화","regDate":"2022-05-02 15:17:39","content":"ㅎㅎ","seq":"1","orgFilename":" "}]
		  			  // 또는 
		  			  // []
		  			  
		  			  
		  			  let html = "";
		  			  if(json.length > 0) {
		  				  $.each(json, function(index, item){
		  					  html += "<tr>";
		  					  html += "<td class='comment'>"+(index+1)+"</td>";
		  					  html += "<td>"+item.content+"</td>";
		  					  
		  				 === 첨부파일 기능이 추가된 경우 시작 === 
		  					
		  					if(${sessionScope.loginuser != null}){ // 로그인을 한 경우 a가 걸리고,
		  						html += "<td><a href='<%=request.getContextPath()%>/downloadComment.action?seq="+item.seq+"'>"+item.orgFilename+"</a></td>";
		  					}  
		  					else{ //비로그인시 보기만 하세요
		  					  html += "<td>"+item.orgFilename+"</td>";
		  					}  
		  					  
		  					  html += "<td>"+ Number(item.fileSize).toLocaleString('en')+"</td>";
		  				 === 첨부파일 기능이 추가된 경우 끝 ===
		  				 
		  				  html += "<td class='comment'>"+item.name+"</td>";
		  				  html += "<td class='comment'>"+item.regDate+"</td>";
		  				  html += "</tr>";
		  			  });
		  		  }
		  		  else {
		  			  html += "<tr>";
		  			  html += "<td colspan='4' class='comment'>댓글이 없습니다</td>";
		  			  html += "</tr>";
		  		  }
		  		  
		  		  $("tbody#commentDisplay"+fk_board_seq).html(html);
		  		  
		  		  // 페이지바 함수 호출
		  		  makeCommentPageBar(currentShowPageNo);
		  	  },
		  	  error: function(request, status, error){
		  			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  	  }
		    });
		    
		    }// end of function goViewComment(currentShowPageNo) {}-------------------------
		   --%>
		  ///////////


function commentAdd(fk_board_seq){
	
	   const content = $("input.comment-writer-text").val();
	 
	   $.ajax({
		   url:"<%= ctxPath%>/boardCommentAdd.groovy",
		   type:"POST",
		   data:{"fk_board_seq":fk_board_seq,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
			   "name":"${sessionScope.loginuser.name}",
			   "content":content },
		   dataType:"JSON", 
		   success:function(json){
			   
		  	if(json.n == 1){
		  		$("input.comment-writer-text").val("");
		  		commentShow(fk_board_seq,1);   
		  	}else{
		  		alert("댓글쓰기 실패");
		  	}
			   
	 
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
} // end of function commentAdd(fk_board_seq) {}---------------



function commentShow(fk_board_seq, currentShowPageNo){
	
	   $.ajax({
		   url:"<%= ctxPath%>/boardCommentShow.groovy",
		   type:"GET",
		   data:{"fk_board_seq":fk_board_seq,
			   "currentShowPageNo":currentShowPageNo},
		   dataType:"JSON", 
		   success:function(json) {
			   
			  
	  			if(json.length>0){
	  				
	  				let html = ""
					   $.each(json, function(index, item) {
						   var regdate = moment(item.regdate).format('YYYY-MM-DD HH:mm');
					 
						     html += '<li class="card-footer-li" id="commentid-'+item.pk_cmt_seq+'">';
 			               
					         html += '<div class="comment-user-profile">';
					         html += '<span class="comment-user-profile-span"><a style="margin-right: 5px;"><img style="height:40px; width:40px;      border-radius: 16px;" class="writer-photo" src="<%= ctxPath%>/resources/images/프로필사진/'+item.emppicturename+'"  alt="icon-writerprofile"  /></a></span>';
					         html += '</div>';
					 			            
					         html += '<div class="comment-container">';
					         html += '<div class="comment-user-area">';
					         html += '<div class="comment-user">';
					         html += '<span class="comment-user-name">['+item.deptnamekor+' : '+item.spotnamekor+'] '+item.name+'</span>';
					         html += '<span class="comment-user-position"></span>';
					         html += '<span class="record-date">'+regdate+'</span>'; 
					         html += '</div>';
					 		if('${sessionScope.loginuser.pk_empnum}' == item.fk_empnum){
					 			 html += '<div class="comment-writer-menu">';
						         html += '<button type="button" class="comment-edit" onclick="commentEdit('+fk_board_seq+','+item.pk_cmt_seq+')">수정</button>';
						         html += '<button type="button" class="comment-delete" onclick="commentDel('+fk_board_seq+','+item.pk_cmt_seq+')">삭제</button>';
						         html += '</div>'; 
					 		}
					        
					         
					         html += '</div>';
					 			                
					         html += '<div class="comment-content">';
					         html += '<div class="comment-text-area">';
						     html += '<div class="comment-text"><div>'+item.content+'</div></div>';
						 	 html += '</div>';	
					         html += '</div>'; 
					         html += '</div>';

						     html += '</li>'; 
					   });
					   $("ul.card-footer-group").html(html);
					   $("ul.commentDisplay").html(html);
					   makeCommentPageBar(fk_board_seq, currentShowPageNo);
	  			}

		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------




function commentEdit(fk_board_seq,pk_cmt_seq){
	
   let html ="";
   html += '<input type="text" class="comment-writer-text"  placeholder="입력 Enter 입니다.">';
   html += '<input type="text" style="display:none;">';
   const backuptext = $("li#commentid-"+pk_cmt_seq+" div.comment-text div").text();

   $("li#commentid-"+pk_cmt_seq+" div.comment-text-area").html(html);
   $("li#commentid-"+pk_cmt_seq+" input.comment-writer-text").val(backuptext);
  
   $("div.card-footer2").hide();
   
   html ="";
   html += '<button type="button" class="comment-cancell" onclick="commentEditCancell('+fk_board_seq+')">취소</button>';
   $("li#commentid-"+pk_cmt_seq+" div.comment-writer-menu").html(html);
   
   
	$(document).on('keyup', 'li#commentid-'+pk_cmt_seq+' input.comment-writer-text', function (event) {
		if(event.keyCode == 13){ 
			 const contentEdit = $("li#commentid-"+pk_cmt_seq+" input.comment-writer-text").val();
			 
			 $.ajax({
				   url:"<%= ctxPath%>/boardCommentEdit.groovy",
				   type:"POST",
				   data:{"fk_board_seq":fk_board_seq,
					   "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
					   "pk_cmt_seq":pk_cmt_seq,
					   "content":contentEdit},
				   dataType:"JSON", 
				   success:function(json) {
					   
				  	if(json.n == 1){
				  		   alert("댓글수정 성공");
				  		 commentShow(fk_board_seq,1); 
						   $("div.card-footer2").show();
				  	}else{
				  		alert("댓글수정 실패");
				  	}
					   
			 
				   },
				   error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				   }
			   });	
			 

		}
	});
	
   

	   
}// end of function goLikeDislikeCount()-------------------

function commentDel(fk_board_seq,pk_cmt_seq){
	
	   $.ajax({
		   url:"<%= ctxPath%>/boardCommentDel.groovy",
		   type:"POST",
		   data:{"fk_board_seq":fk_board_seq,
			   "fk_empnum":"${sessionScope.loginuser.pk_empnum}",
			   "pk_cmt_seq":pk_cmt_seq},
		   dataType:"JSON", 
		   success:function(json) {
			   
		  	if(json.n == 1){
		  		   alert("댓글삭제 성공");
		  		 commentShow(fk_board_seq,1);   
		  	}else{
		  		alert("댓글삭제 실패");
		  	}
			   
	 
		   },
		   error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		   }
	   });	   
	   
}// end of function goLikeDislikeCount()-------------------


function commentEditCancell(fk_board_seq){
	
	commentShow(fk_board_seq,1); 
    $("div.card-footer2").show();
}
	    

//////////

function makeCommentPageBar(fk_board_seq, currentShowPageNo) {

<%-- === 원글에 대한 댓글의 totalPage 수를 알아오려고 한다. ===  --%>
$.ajax({
  url:"<%= ctxPath%>/getBoardCommentTotalPage.groovy",
  data:{"fk_board_seq":fk_board_seq,
	    "sizePerPage":"3"},
  type:"GET",
  dataType:"JSON",
  success:function(json){
	 //  console.log("확인용 댓글의 전체페이지수 : " + json.totalPage);
	 
	 if(json.totalPage > 0) {
		 // 댓글이 있는 경우 
		 
		 const totalPage = json.totalPage;
		 
		 let pageBarHTML = "<ul>";
		 
		 const blockSize = 5;
	//	 const blockSize = 2;
		 
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		                 1 2 3 4 5 6 7 8 9 10  [다음][마지막]           -- 1개블럭
		   [맨처음][이전]  11 12 13 14 15 16 17 18 19 20  [다음][마지막]   -- 1개블럭
		   [맨처음][이전]  21 22 23
		*/
		 
		 let loop = 1;
		 /*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	     */
	    

	     if(typeof currentShowPageNo == "string") {
	    	 currentShowPageNo = Number(currentShowPageNo);
	     }
	     
	     // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
	     let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
	     /*
	       currentShowPageNo 가 3페이지 이라면 pageNo 는 1 이 되어야 한다.
	       ((3 - 1)/10) * 10 + 1;
	       ( 2/10 ) * 10 + 1;
	       ( 0.2 ) * 10 + 1;
	       Math.floor( 0.2 ) * 10 + 1;  // 소수부가 있을시 Math.floor(0.2) 은 0.2 보다 작은 최대의 정수인 0을 나타낸다.
	       0 * 10 + 1 
	       1
	       
	       currentShowPageNo 가 11페이지 이라면 pageNo 는 11 이 되어야 한다.
	       ((11 - 1)/10) * 10 + 1;
	       ( 10/10 ) * 10 + 1;
	       ( 1 ) * 10 + 1;
	       Math.floor( 1 ) * 10 + 1;  // 소수부가 없을시 Math.floor(1) 은 그대로 1 이다.
	       1 * 10 + 1
	       11
	       
	       currentShowPageNo 가 20페이지 이라면 pageNo 는 11 이 되어야 한다.
	       ((20 - 1)/10) * 10 + 1;
	       ( 19/10 ) * 10 + 1;
	       ( 1.9 ) * 10 + 1;
	       Math.floor( 1.9 ) * 10 + 1;  // 소수부가 있을시 Math.floor(1.9) 은 1.9 보다 작은 최대의 정수인 1을 나타낸다.
	       1 * 10 + 1
	       11
	    
	       
		    1  2  3  4  5  6  7  8  9  10  -- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
		    11 12 13 14 15 16 17 18 19 20  -- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
		    21 22 23 24 25 26 27 28 29 30  -- 세번째 블럭의 페이지번호 시작값(pageNo)은 21 이다.
		    
		    currentShowPageNo         pageNo
		   ----------------------------------
		         1                      1 = ((1 - 1)/10) * 10 + 1
		         2                      1 = ((2 - 1)/10) * 10 + 1
		         3                      1 = ((3 - 1)/10) * 10 + 1
		         4                      1
		         5                      1
		         6                      1
		         7                      1 
		         8                      1
		         9                      1
		         10                     1 = ((10 - 1)/10) * 10 + 1
		        
		         11                    11 = ((11 - 1)/10) * 10 + 1
		         12                    11 = ((12 - 1)/10) * 10 + 1
		         13                    11 = ((13 - 1)/10) * 10 + 1
		         14                    11
		         15                    11
		         16                    11
		         17                    11
		         18                    11 
		         19                    11 
		         20                    11 = ((20 - 1)/10) * 10 + 1
		         
		         21                    21 = ((21 - 1)/10) * 10 + 1
		         22                    21 = ((22 - 1)/10) * 10 + 1
		         23                    21 = ((23 - 1)/10) * 10 + 1
		         ..                    ..
		         29                    21
		         30                    21 = ((30 - 1)/10) * 10 + 1
		         
		*/
	     
		// === [맨처음][이전] 만들기 === //
		pageBarHTML += "<li class='firstli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\"1\")'><span class='material-icons'> keyboard_double_arrow_left </span></a></li>";
		pageBarHTML += "<li class='previousli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+(pageNo-1)+"\")'><span class='material-icons'> keyboard_arrow_left </span></a></li>";
		
		if(pageNo != 1) {
			
			
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBarHTML += "<li class='numberli'>"+pageNo+"</li>";  
			}
			else {
				pageBarHTML += "<li class='numberli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {


			
		}
		pageBarHTML += "<li class='nextli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+pageNo+"\")'><span class='material-icons'> keyboard_arrow_right </span></a></li>";
		pageBarHTML += "<li class='lastli'><a href='javascript:commentShow(\""+fk_board_seq+"\",\""+totalPage+"\")'><span class='material-icons'> keyboard_double_arrow_right </span></a></li>"; 
		 
		pageBarHTML += "</ul>";
		 
		$("div.comment-header").html(pageBarHTML);
	 }// end of if(json.totalPage > 0){}-------------------------------
	  
  },
  error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  }    
});

}// end of function makeCommentPageBar(currentShowPageNo) {}--------------------







function makeBoardPageBar(BcurrentShowPageNo) {

<%-- === 원글에 대한 댓글의 totalPage 수를 알아오려고 한다. ===  --%>
$.ajax({
  url:"<%= ctxPath%>/getBoardTotalPage.groovy",
  data:{
	    "sizePerPage":"10"},
  type:"GET",
  dataType:"JSON",
  success:function(json){
	 //  console.log("확인용 댓글의 전체페이지수 : " + json.totalPage);
	 
	 if(json.totalPage > 0) {
		 // 댓글이 있는 경우 
		 
		 const totalPage = json.totalPage;
		 
		 let pageBarHTML = "<ul>";
		 
		 const blockSize = 10;
	//	 const blockSize = 2;
		 
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		                 1 2 3 4 5 6 7 8 9 10  [다음][마지막]           -- 1개블럭
		   [맨처음][이전]  11 12 13 14 15 16 17 18 19 20  [다음][마지막]   -- 1개블럭
		   [맨처음][이전]  21 22 23
		*/
		 
		 let loop = 1;
		 /*
	    	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
	     */
	    

	     if(typeof BcurrentShowPageNo == "string") {
	    	 BcurrentShowPageNo = Number(BcurrentShowPageNo);
	     }
	     
	     // *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
	     let pageNo = Math.floor( (BcurrentShowPageNo - 1)/blockSize ) * blockSize + 1;
	    

	     
		// === [맨처음][이전] 만들기 === //
		pageBarHTML += "<li class='firstli'><a href='javascript:boardRead(\"1\")'><span class='material-icons'> keyboard_double_arrow_left </span></a></li>";
		pageBarHTML += "<li class='previousli'><a href='javascript:boardRead(\""+(pageNo-1)+"\")'><span class='material-icons'> keyboard_arrow_left </span></a></li>";
		
		if(pageNo != 1) {
			
			
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == BcurrentShowPageNo) {
				pageBarHTML += "<li class='numberli'>"+pageNo+"</li>";  
			}
			else {
				pageBarHTML += "<li class='numberli'><a href='javascript:commentShow(\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
			}
			
			loop++;
			pageNo++;
			
		}// end of while-----------------------
		
		
		// === [다음][마지막] 만들기 === //
		if( pageNo <= totalPage ) {


			
		}
		pageBarHTML += "<li class='nextli'><a href='javascript:goReadBoardList(\""+pageNo+"\")'><span class='material-icons'> keyboard_arrow_right </span></a></li>";
		pageBarHTML += "<li class='lastli'><a href='javascript:goReadBoardList(\""+totalPage+"\")'><span class='material-icons'> keyboard_double_arrow_right </span></a></li>"; 
		 
		pageBarHTML += "</ul>";
		 
		$("div#feedpaging").html(pageBarHTML);
	 }// end of if(json.totalPage > 0){}-------------------------------
	  
  },
  error: function(request, status, error){
		alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  }    
});

}// end of function makeCommentPageBar(currentShowPageNo) {}--------------------






	    
</script>

<div id="top_content" style="display: flex;">
	<div style="margin: auto; width: 90%;">
		<div class="row">
			<div id="home_board" class="col-lg-9">
					 <div id="writeBoard" class="card border-dark mb-3" data-toggle="modal" data-target="#writeBoardModal" > 
					  	
					  	<div class="card-header">
							<table class="w-100">
								<tr align=center>
									<th class="w-25"><span id="text"><i class="far fa-file-alt"></i>글</span></th>
									<th class="w-25"><span id="task"><i class="fas fa-list-ul"></i>업무</span></th>
									<th class="w-25"><span id="schedule"><i class="far fa-calendar"></i>일정</span></th>
									<th class="w-25"><span id="todo"><i class="far fa-check-square"></i>할일</span></th>						
								</tr>
							</table>
					  	</div>
					  	
					  	<div class="card-body text-dark">
							<table class="w-100">
								<tr> <%-- 선택 탭(글, 업무, 일정, 할일)마다 형식이 다름 --%>
									<td>내용을 입력하세요</td>
									<td align="right">
										<i class="fas fa-paperclip"></i>
										<i class="far fa-image"></i>
										<i class="fas fa-map-marker-alt"></i>
										<i class="fas fa-hashtag"></i>
										<i class="fas fa-at"></i>
									</td>
								</tr>
							</table>
					  	</div>
					  	
					</div>
				
				
					<!-- 글쓰기 Modal -->
					<div id="myWrite" class="modal fade" role="dialog">
					  <div class="modal-dialog">
					
					    <!-- Modal content-->
					    <div class="modal-content" style="width: 670px; min-height:548px; ">
						      <div class="modal-header">
						        <button type="button" class="close" data-dismiss="modal">&times;</button>
						        <h4 class="modal-title">Modal Header</h4>
						      </div>
						      
						      
						      <div class="modal-body" class="card border-dark mb-3">
	
								  	<div class="card-header">
										<table class="w-100">
											<tr align=center>
												<th class="w-25"><span id="text"><i class="far fa-file-alt"></i>글</span></th>
												<th class="w-25"><span id="task"><i class="fas fa-list-ul"></i>업무</span></th>
												<th class="w-25"><span id="schedule"><i class="far fa-calendar"></i>일정</span></th>
												<th class="w-25"><span id="todo"><i class="far fa-check-square"></i>할일</span></th>						
											</tr>
										</table>
								  	</div>
								  	
								  	<form name="boardaddFrm" enctype="multipart/form-data">
									  	<div class="card-body text-dark">
											<table class="w-100">
												<tr>
													<th><input type="hidden" name="pk_empnum" value="${sessionScope.loginuser.pk_empnum}" />
														<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly />
													</th>
												</tr>
												<tr> <%-- 선택 탭(글, 업무, 일정, 할일)마다 형식이 다름 --%>
													<td><input id="postTitle" type="text" title="제목을 입력하세요" placeholder="제목을 입력하세요." autocomplete="off" data-required-yn="Y" class="js-post-title create-title-input" maxlength="100" ></td>
													
												</tr>
												<tr> 
													<td>내용을 입력하세요</td>
													
												</tr>
												<tr>
													<td align="right">
														<i class="fas fa-paperclip"></i>
														<i class="far fa-image"></i>
														<i class="fas fa-map-marker-alt"></i>
														<i class="fas fa-hashtag"></i>
														<i class="fas fa-at"></i>
													</td>
												</tr>
											</table>
									  	</div>
								  	</form>
						      </div>
						      
					      
						      <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						      </div>
					    </div>  <!-- Modal content 끝-->
					
					  </div>
					</div><!-- 글쓰기 Modal 끝 -->
				
					<!-- 글피드 보기  -->
					<a type="button" onclick="goReadBoard()">글피드보기</a><a type="button"  onclick="goReadBoardList()">글목록보기</a>
					<div id="feedAllbox"></div>
					
					
		  	</div>
		  	
			<%-- 프로젝트 참여자 목록 --%>
			<div id="memberlist" class="col-lg-3" style="position: fixed; right: 30px; top: 216px; width: 350px;">
				<div class="row">
					<div class="col-lg-6"><h6 style="display: inline-block; margin-left: 5px;">참여자<span class="text-muted ml-2">${requestScope.empvoList.size()}</span></h6></div>
					<div class="col-lg-6" align="right"><a id="showAllEmployee" data-toggle="modal" data-target="#showAllEmpModal">전체보기</a></div>
				</div>
				<div class="card mb-3">
					<div class="card-body scrollover" style="padding-bottom: 0; height: 550px; overflow: auto; overflow-x: hidden;">
				    	<c:forEach var="deptvo" items="${requestScope.deptvoList}" varStatus="status">
				    	<div>
				    		<a id="dept" class="text-muted" data-toggle="collapse" href="#${deptvo.deptnameeng.replaceAll(' ', '')}" aria-expanded="false" aria-controls="${deptvo.deptnameeng.replaceAll(' ', '')}">${deptvo.deptnamekor}</a>
				    		<input type="hidden" id="pk_detpnum" value="${deptvo.pk_deptnum}" />
				    		<input type="hidden" id="deptnameeng" value="${deptvo.deptnameeng.replaceAll(' ', '')}" />
				    	</div>
				    	<div class="collapse dept" id="${deptvo.deptnameeng.replaceAll(' ', '')}"></div>
				    	</c:forEach>
				  	</div>
				  	<div class="card-footer" align="center" style="padding: 0; height: 50px;">
				  		<table class="w-100 h-100">
				  			<tr align="center">
				  				<td class="w-50" style="border-right: solid 1px lightgray;">
				  					<button type="button" id="groupchat" onclick=""><i class="far fa-comment-dots"></i>채팅</button>
				  				</td>
				  			</tr>
				  		</table>
				  	</div>
				</div>
			</div>
		</div>
	
		<%-- modal_프로젝트 색상 설정 --%>
		<div class="modal fade" id="prjColorPickerModal">
		  	<div class="modal-dialog modal-dialog-centered">
		  	<!-- .modal-dialog-centered 클래스를 사용하여 페이지 내에서 모달을 세로 및 가로 중앙에 배치합니다. -->
		    	<div class="modal-content">
		    		<!-- Modal header -->
					<div class="modal-header" style="border: none;">
						<h5 class="modal-title">프로젝트 색상</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						Modal body....
					</div>
					<!-- Modal footer -->
					<div class="modal-footer" style="border: none;">
						<button type="button" class="btn btn-light text-secondary w-25" data-dismiss="modal">취소</button>
						<button type="button" class="btn text-white w-25" style="background-color: #6449fc;">확인</button>
					</div>
		    	</div>
		  	</div>
		</div>
		
		<%-- modal_전체 프로젝트 참여자 목록 보기 --%>
		<div class="modal fade" id="showAllEmpModal">
			<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content" style="height: 700px;">
					<!-- Modal header -->
					<div class="modal-header" style="border: none; height: 110px; position: relative;">
						<h5 class="modal-title">참여자 관리</h5>
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						
						<!-- 참여자 검색 -->
						<div style="position: absolute; top: 60px;">
							<div style="position: relative;">
								<i class="fas fa-search" style="position: absolute; left: 13px; top: 12px; opacity: 0.6;"></i>
								<input type="text" id="searchEmp" placeholder="참여자명으로 검색" style="width: 450px; height: 40px; border: solid 1px #eee; border-radius: 5px; padding-left: 40px;"/>
							</div>
						</div>
					</div>
					
					<!-- Modal body -->
					<div class="modal-body">
						
						<!-- 참여자 목록(기본_검색 X) -->
						<div id="defaultEmpList">
							<table class="tblEmpList" style="width: 100%;">
					    		<c:forEach var="empvo" items="${requestScope.empvoList}">
					    		<tr style="border-bottom: solid 1px #eeeeee;">
					    			<td class="empProfile" style="cursor: pointer;" onclick="javascript:showEmpProfile('${empvo.pk_empnum}')">
					    				<img class="my-2 mr-2" src="<%= ctxPath %>/resources/images/프로필사진/${empvo.emppicturename}" style="width: 40px; border-radius: 15px;">
					    				<span class="name font-weight-bold">${empvo.name}</span>
					    				<input type="hidden" id="pk_empnum" value="${empvo.pk_empnum}"/>
					    			</td>
					    			<td align="right">
					    				<span style="background-color: #6449fc; border-radius: 20px; color: white; padding: 5px 10px; font-size: 10pt;">${empvo.spotnamekor}</span>
					    				<i class="fas fa-ellipsis-v ml-2" data-toggle="dropdown"></i>
					    				<div class="dropdown-menu prjSetting my-0 py-0">
					    				<!-- c:if로 로그인 유저 이름과 목록 상의 이름이 동일한 경우에는 내보내기가 아니라 나가기로 보여주어야 함. -->
					    				<!-- name은 c:set으로 설정해두기 -->
									      	<a class="dropdown-item" href="">내보내기</a>
									      	<a class="dropdown-item" href="">${empvo.spotnamekor}해제</a>
									    </div>
					    			</td>
					    		</tr>
				    			</c:forEach>
				    		</table>
						</div>
						<!-- 참여자 목록(검색 O) -->
						<div id="searchEmpList">
							<table id="tblSearchEmpList" class="tblEmpList" style="width: 100%;"></table>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<%-- modal_프로젝트 참여자 프로필 보기 --%>
		<div class="modal fade" id="showEmpProfileModal">
		  	<div class="modal-dialog modal-dialog-centered">
		    	<div class="modal-content" style="height: 600px; width: 350px;">
		    		<!-- Modal header -->
					<div class="modal-header" style="border: none; height: 300px; position: relative;">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						
						<div id="empName" style="position: absolute; top: 260px; color: white; font-weight: bold; font-size: 16pt;"></div>
					</div>
					<!-- Modal body -->
					<div class="modal-body">
						<table class="w-100">
							<tr style="border-bottom: solid 1px #eee;">
								<td><i class="far fa-envelope"></i></td>
								<td id="email"></td>
							</tr>
							<tr style="border-bottom: solid 1px #eee;">
								<td><i class="fas fa-mobile-alt"></i></td>
								<td id="phone"></td>
							</tr>
						</table>
					</div>
					<!-- Modal footer -->
					<div class="modal-footer" style="border: none; text-align: center;">
						<button type="button" id="goChat" class="btn btn-light" style="border: solid 1px #eee; width: 40%;">채팅</button>
						<button type="button" class="btn btn-light" style="border: solid 1px #eee; width: 40%;">정보수정</button>
					</div>
		    	</div>
		  	</div>
		</div>
		<jsp:include page="../tiles2/board/writeBoardModal.jsp"/> 
		<jsp:include page="../tiles2/board/editBoardModal.jsp"/>   
		
		
		
		
<!-- 카드 -->
<div class="card showBoardDetail">


  	
</div>
		
		
		
		
		
		<!--  -->
	</div>
</div>

<input type="hidden" class="boardno"/>	