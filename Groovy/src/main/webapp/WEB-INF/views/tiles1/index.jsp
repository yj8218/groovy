<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%
   	String ctxPath = request.getContextPath();

	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	
	int portnumber = request.getServerPort();
	
	String serverName = "http://" + serverIP + ":" + portnumber;
%>

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
	
	div#content {margin-top: 150px;}
	
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
    top: -20px;
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

	$(document).ready(function() {
		
		showEmpByDept();
		
		goReadBoard();
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
			var openchatConfirm = confirm("프로젝트 채팅방을 개설하시겠습니까?\n현재 접속중인 직원 모두가 참여하는 채팅방입니다.");
			
			if(openchatConfirm) {
				const url = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy";
		        const popup_name = "multichat";
		        const option = "width = 450, height = 650, top = 300, left = 600";
				
				window.open("", popup_name, option);
				
				const frm = document.openGroupChatFrm;
				frm.target = popup_name;
				frm.action = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy";
				frm.method = "get";
				frm.submit();
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
		
		
		
		/* $('.modal').on('hidden.bs.modal', function (e) {
			$(this).find('form')[0].reset();
		}); */
		
		
		///////////////////////////////////////////////////////////////////
		
		// @@@@ 웹소켓 연결 @@@@ //
		// 웹브라우저의 주소창의 포트까지 가져옴
		const url = window.location.host;
	//	alert("url : " + url);
		// url : 221.155.187.235:9090
		
		// '/' 부터 오른쪽에 있는 모든 경로
		const pathname = window.location.pathname;
	//	alert("pathname : " + pathname);
		// pathname : /board/chatting/multichat.action
		
		// "전체 문자열".lastIndexOf("검사할 문자"); 
		const appCtx = pathname.substring(0, pathname.lastIndexOf("/"));
	//	alert("appCtx : " + appCtx);
		// appCtx : /groovy/chatting
		
		const root = url + appCtx;
	//	alert("root : " + root);
		// root : 172.30.1.42:9090/groovy
		
		// 웹소켓통신을 하기 위해서는 http://을 사용하는 것이 아니라 ws://을 사용해야 한다.
		// "/multichatstart.action"에 대한 것은 /WEB-INF/spring/config/websocketContext.xml 파일에 있는 내용이다.
		const wsUrl = "ws://" + root + "/websocketConnectEmp.groovy";
	//	alert("wsUrl : " + wsUrl);
		// wsUrl : ws://221.155.187.235:9090/board/websocketConnectEmp.groovy
		
		const websocket = new WebSocket(wsUrl);
		// 즉, const websocket = new WebSocket(ws://221.155.187.235:9090/board/chatting/websocketConnectEmp.groovy); 이다.
		
		// === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수 정의하기 === //
	   	websocket.onopen = function() {
	   		
	   	};
		
		// === 메시지 수신시 콜백함수 정의하기 === //
	   	websocket.onmessage = function(event) {
	   		
	   		// event.data는 수신되어진 메시지이다.
	        if(event.data.substr(0,1)=="<" && event.data.substr(event.data.length-1)==">") { 
	            $("div#connectEmp").html(event.data);
	        }
	   	};
		
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
				
			//	var url = "<%= ctxPath %>/openPersonalChatEnd.groovy?name=" + json.name;
			//	var url = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy";
	            var popup_name = "openChat";
	            var option = "width = 450, height = 650, top = 300, left = 600";
				
				window.open("", popup_name, option);
				
				const frm = document.openPersonalChatFrm;
				frm.target = popup_name;
				frm.action = "<%= serverName %><%= ctxPath %>/chatting/multichat.groovy?name=" + json.name;
				frm.method = "get";
				frm.submit();
			},
			error: function(request, status, error) {
            	alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
		}); // $.ajax({})
	}
	
	
	// 그룹 채팅을 활성화하는 메소드
	function openGroupChat() {
		
	}
	
	  
	  // === 페이징 처리 안한 글 읽어오기  === //
	  function goReadBoard() {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/readBoard.groovy",
			/*   data:jsonArr,   */
		/* 	   data:{"pk_board_seq":1},  */
			  dataType:"json",
			  success:function(json){
				  // [{"name":"엄정화","regDate":"2022-04-25 10:23:51","content":"두번째 댓글 입니다."},{"name":"엄정화","regDate":"2022-04-25 10:13:47","content":"첫번째 댓글 입니다."}] 
				  // 또는
				  // [] 
				  
				  console.log(json);
				  
				   if(json.length > 0) {
					  $.each(json, function(index, item){
					  /* for(var i=0; i<json.length; i++){} */
						 /*  $("tbody#commentDisplay").html(html); */
						  
						 	html = "";
						  
						 	  html += "<div class='card mb-4 feedAll'>";
						      html += "<div class='card-body'>";
						   	  html +=  "<table style='width: 95%; margin: auto; padding: 10px;' class='tbl_boardInCard mb-3'>";
						   	  html +=  "<thead>";
						   	  html +=  "<tr>";
						   	  html +=  "<td>";
						   	  html +=  "<i class='far fa-user-circle'></i>";
						   	  html +=  "<span id='write_name'>"+ (index+1) + item.name + "</span>/<span id='write_date'>"+ item.b_regdate + "</span>  ";
						   	  html +=  "</td>";
						   	  
						   	  
						   	html +=  "<td align='right'>;"
						   	html +=  "<i class='fas fa-thumbtack'></i>	상단고정";
						   	html +=  "<i class='fas fa-ellipsis-v' data-toggle='dropdown'></i>	설정";
						   	html +=  "<div class='dropdown-menu'>";
						   	html +=  "  	<a class='dropdown-item' href='<%= ctxPath%>/boardedit.groovy?seq="+item.pk_board_seq+"'><i class='far fa-board-alt'></i>수정</a>";
						   	html +=  "  	<a class='dropdown-item' href='#'><i class='far fa-trash-alt'></i>삭제</a>";
						   	html +=  "  	<a class='dropdown-item' href='#'><i class='fas fa-external-link-alt'></i>다른 프로젝트에 복사</a>";
						   	html +=  "  	<a class='dropdown-item' href='#'><i class='far fa-clone'></i>링크 복사</a>";
						   	html +=  "</div>";
						   	html +=  "</td>";
						   	html +=  "</tr>";
						   	html +=  "</thead>";
						   	html +=  "<tbody>";
						   	html +=  "<tr>";
						   	html +=  "<td id='write_subject' colspan='2' style='font-size: 18pt;'>"+ item.b_subject + "</td>";
						   	html +=  "</tr>";
						   	html +=  "<tr style='border-top: solid 1px lightgray; border-bottom: solid 1px lightgray; height: 150px;'>";
						   	html +=  "<td id='write_content' colspan='2'>"+ item.b_content + "</td>";
						   	html +=  "</tr>";
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
							html +=  "</table> 	";
							html +=  "</div>";
							html +=  "<div class='card-footer' align='center'>";
							html +=  "<i class='far fa-user-circle'></i>";
							html +=  "<input type='text' class='form-control' style='display: inline-block; width: 90%;' placeholder='댓글 입력' />";
							html +=  "<label class='btn_inputFile' for='inputFile'><i class='fas fa-paperclip ml-2'></i></label>";
							html +=  "<input type='file' id='inputFile' style='display: none;'/>";
							html +=  "</div></div>";
						   			
						  $("div#feedAllbox").append(html); 
				/* 	      $("#write_name").append(item.name);
						  $("#write_date").append(item.b_regdate);
					//	  $("#write_date").append(item.b_subject);
						  $("#write_content").append(item.b_content); */
						 // alert("반복");	 
										
											
									
					   });
				  }
				  else {
					 alert("error");
				  }
				   
				  
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goReadComment(){}--------------------------
	
</script>

<%-- final_html --%>
<%-- 
<div id="fixedTab">
	프로젝트 색상 / 프로젝트 제목 / 공개여부 / 프로젝트 설명 / 멤버 초대 / 검색 
	프로젝트 색상
	<div id="prjColor" data-toggle="modal" data-target="#prjColorPickerModal" style="width: 50px; height: 50px; background-color: blue; border-radius: 10px; display: inline-block;"></div>
	프로젝트 제목
	<div id="prjTitle" style="display: inline-block; margin-left: 10px;">
		<i class="far fa-star"></i>
		<i class="fas fa-ellipsis-v" data-toggle="dropdown"></i>
		<div class="dropdown-menu prjSetting my-0 py-0">
			<a class="dropdown-item bg-dark text-white">프로젝트 번호<span class="ml-5">1312117</span></a>
	      	<a class="dropdown-item" href=""><i class="fas fa-paint-roller"></i>색상 설정</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-tag"></i>프로젝트 폴더 설정</a>
	      	<a class="dropdown-item" href=""><i class="far fa-bell"></i>알림 설정</a>
	      	<a class="dropdown-item" href=""><i class="far fa-eye-slash"></i>숨김</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-clipboard-check"></i>프로젝트 템플릿 설정</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-sign-out-alt"></i>프로젝트 나가기</a>
	      	<a class="dropdown-item" href=""><i class="fas fa-pencil-alt"></i>프로젝트 수정</a>
	      	<a class="dropdown-item" href=""><i class="far fa-trash-alt"></i>프로젝트 삭제</a>
	    </div>
		<span style="font-weight: bold; font-size: 16pt;">프로젝트 제목</span>
		<p>프로젝트 설명</p>
	</div>
</div>
 --%>
<div id="content" style="display: flex; margin-top: 50px;">
	<div style="margin: auto; width: 90%;">
		<div class="row">
			<div id="home_board" class="col-lg-9">
				<%-- Tab panes(홈) 
				<div class="tab-content">
				  	<div class="tab-pane container active" id="home">
				--%>
		  		<div>
					<h5>게시글작성 하세요~#!</h5>
					 <div id="writeBoard" class="card border-dark mb-3" data-toggle="modal" data-target="#writeBoardModal" > 
					<!-- <div id="writeBoard" class="card border-dark mb-3"  onclick="showwrite()">   -->
					<%-- <div id="writeBoard" class="card border-dark mb-3"   OnClick="location.href ='<%=ctxPath%>/add.groovy'" style="cursor:pointer;"> --%>
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
    </div>

  </div>
</div>
				
				
				
				
				
				<div id="feedAllbox">
					
					<%-- 반복 --%>
					<%-- <c:forEach items="${requestScope.boardList}" var="item" varStatus="status"> --%>
					<!-- 
					<div class="card mb-4 feedAll">
						 <div class="card-body">
					    	<table style="width: 95%; margin: auto; padding: 10px;" class="tbl_boardInCard mb-3">
					    		<thead>
					    			<tr>
										<td>
											<i class="far fa-user-circle"></i>
											<span id="write_name">사용자명</span>/<span id="write_date">작성일자</span>  
										</td>
										<td align="right">
											<i class="fas fa-thumbtack"></i>	상단고정
											<i class="fas fa-ellipsis-v" data-toggle="dropdown"></i>	설정
											<div class="dropdown-menu">
										      	<a class="dropdown-item" href="#"><i class="far fa-trash-alt"></i>삭제</a>
										      	<a class="dropdown-item" href="#"><i class="fas fa-external-link-alt"></i>다른 프로젝트에 복사</a>
										      	<a class="dropdown-item" href="#"><i class="far fa-clone"></i>링크 복사</a>
										    </div>
										</td>
									</tr>
					    		</thead>
					    		<tbody>
					    			<tr>
										<td id="write_subject" colspan="2" style="font-size: 18pt;">게시글 제목</td>
									</tr>
									<tr style="border-top: solid 1px lightgray; border-bottom: solid 1px lightgray; height: 150px;">
										<td id="write_content" colspan="2">게시글 내용(글 탭을 선택한 경우)</td>
									</tr>
									<tr>
										<td style="width: 50%;">
											<i class="far fa-meh-blank" data-toggle="dropdown"></i>좋아요&nbsp;&nbsp;&nbsp;
											<div class="dropdown-menu emotion">
												<a class="dropdown-item" href=""><i class="far fa-smile-beam"></i><span>좋아요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-kiss-beam"></i><span>부탁해요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-sad-tear"></i><span>힘들어요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-grin-stars"></i><span>훌륭해요</span></a>
												<a class="dropdown-item" href=""><i class="far fa-grin-hearts"></i><span>감사해요</span></a>
											</div>
											<i class="far fa-bookmark"></i>북마크
											<i class="fas fa-bookmark"></i> 북마크 설정했을때
										</td>
										<td align="right">댓글(댓글수) / 읽음(조회수)</td>
									</tr>
					    		</tbody>
					    	</table> 	
					  	</div>
					  	<div class="card-footer" align="center">
					  		<i class="far fa-user-circle"></i>
							<input type="text" class="form-control" style="display: inline-block; width: 90%;" placeholder="댓글 입력" />
							<label class="btn_inputFile" for="inputFile"><i class="fas fa-paperclip ml-2"></i></label>
							<input type="file" id="inputFile" style="display: none;"/>
					  	</div>
			        </div> -->
			       <%--  </c:forEach> --%>
			        <!-- 반복끝  -->
				</div>
		  	</div>
		  	
			<%-- 프로젝트 참여자 목록 --%>
			<div id="memberlist" class="col-lg-3" style="position: fixed; right: 30px; top: 130px; width: 350px;">
				<div class="row">
					<div class="col-lg-6"><h6 style="display: inline-block; margin-left: 5px;">참여자<span class="text-muted ml-2">${requestScope.empvoList.size()}</span></h6></div>
					<div class="col-lg-6" align="right"><a id="showAllEmployee" data-toggle="modal" data-target="#showAllEmpModal">전체보기</a></div>
				</div>
				<div class="card mb-3">
					<div class="card-body scrollover" style="padding-bottom: 0; height: 500px; overflow: auto; overflow-x: hidden;">
				    <%--  	
				    	<c:forEach var="deptvo" items="${requestScope.deptvoList}" varStatus="status">
				    	<div>
				    		<a id="dept" class="text-muted" data-toggle="collapse" href="#${deptvo.deptnameeng.replaceAll(' ', '')}" aria-expanded="false" aria-controls="${deptvo.deptnameeng.replaceAll(' ', '')}">${deptvo.deptnamekor}</a>
				    		<input type="hidden" id="pk_detpnum" value="${deptvo.pk_deptnum}" />
				    		<input type="hidden" id="deptnameeng" value="${deptvo.deptnameeng.replaceAll(' ', '')}" />
				    	</div>
				    	<div class="collapse dept" id="${deptvo.deptnameeng.replaceAll(' ', '')}"></div>
				    	</c:forEach>
				  	--%>
				    	<div id="connectEmp"></div>
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
		
	</div>
</div>