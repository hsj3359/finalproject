<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="org.springframework.context.annotation.AnnotationConfigApplicationContext" %>
<%@ page import="com.sungjun.web.controller.UserDao" %>
<%@ page import="com.sungjun.web.controller.User" %>
<%@ page import="com.sungjun.web.controller.TableDao" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: hsj33
  Date: 2020-06-11
  Time: 오후 1:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>

<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <title>Wordbook</title>
  <!-- Favicon-->
  <link rel="icon" type="image/x-icon" href="<%=request.getContextPath() %>/resources/assets/img/favicon.ico" />
  <!-- Font Awesome icons (free version)-->
  <script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
  <!-- Google fonts-->
  <link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
  <link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
  <!-- Third party plugin CSS-->
  <link href="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/magnific-popup.min.css" rel="stylesheet" />
  <!-- Core theme CSS (includes Bootstrap)-->
  <link href="<%=request.getContextPath() %>/resources/css/styles.css" rel="stylesheet" />
  <script src="//code.jquery.com/jquery-1.11.2.min.js"></script>

</head>
<body id="page-top" onload="makeList()">
<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
  <div class="container">
    <a class="navbar-brand js-scroll-trigger" href="#page-top">Wordbook</a><button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto my-2 my-lg-0">
        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#about">About</a></li>
        <li class="nav-item"><a class="nav-link js-scroll-trigger" href="#services">Services</a></li>
      </ul>
    </div>
  </div>
</nav>
<!-- Masthead-->
<header class="masthead">
  <div class="container h-100">
    <div class="row h-100 align-items-center justify-content-center text-center">
      <div class="col-lg-10 align-self-end">
        <h1 class="text-uppercase text-white font-weight-bold">단어공부를 도와줍니다.</h1>
        <hr class="divider my-4" />
      </div>
      <div class="col-lg-8 align-self-baseline">
        <p class="text-white-75 font-weight-light mb-5">단어가 힘드신 당신을 위하여!</p>
        <a class="btn btn-primary btn-xl js-scroll-trigger" href="#about">Find Out More</a>
      </div>
    </div>
  </div>
</header>
<!-- About-->
<section class="page-section bg-primary" id="about">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-8 text-center">
        <h2 class="text-white mt-0">단어장 만들기</h2>
        <hr class="divider light my-4" />
        <p>엔터키는 뜻 추가</p>
        <p>↓키는 단어 추가</p>
        <p>현재 입력중인 칸은 데이터에 입력되지 않습니다.</p>
        <p>한줄에는 단어와 뜻이 필수적으로 필요합니다.</p>
        <div class="card" sytle="width:100%;">
          <div class="card-header">
            <select id="tableName" style="float:left;"></select>
            <button onclick="dataBuild()" style="float: right">가져오기</button>
              <button onclick="deleteData()" style="float: right">삭제하기</button>
            <%--            <input id="fileinput" accept=".csv" style="float:left;" type="file"><button onclick="fileBuild()" style="float: right">만들기</button>--%>
          </div>
          <div class="card-header">
            <input id="fileinput" accept=".csv" style="float:left;" type="file" onchange="fileBuild(this)">
          </div>
          <div id='wordData'>
            <div class="input-group">
              <div class="input-group-prepend">
                <span class="input-group-text">단어장 이름</span>
              </div>
              <input id="DatatableName" style="width: 80%">
            </div>
            <table id="wordTable" onkeydown="makeTable()">
              <tr>
                <td>단어</td>
                <td colspan="99">뜻</td>
              </tr>

            </table>

            <button style="float: right" class="mt-3" onclick="makeData()">테이블 생성하기</button>
            <script>
              var row,cell = null;
              var totalArray = new Array();
              var rowArray = new Array();
              const reader = new FileReader()
              var tableListArray = new Array();
              function makeList() {
                var list = "${tableList}".replace("[","").replace("]","");
                tableListArray = list.split(",");
                var select = document.getElementById("tableName");
                var html = "<option value=''>단어장 선택</option>";
                for(var i=0; i<tableListArray.length; i++){
                  html += "<option value='"+tableListArray[i]+"'>"+tableListArray[i]+"</option>"
                }
                select.innerHTML = html;
              }
              function tableBuild() {
                var table = document.getElementById('wordTable');
                row = table.insertRow();
                cell = row.insertCell();
                cell.innerHTML = "<input type='text' id=0-0>";
              }
              tableBuild();
              function fileBuild(sender) {
                  var name = sender.value;
                  name = name.replace("C:\\fakepath\\","").replace(".csv","");
                  const csv = sender.files[0]
                  reader.readAsText(csv)
                  document.getElementById("DatatableName").value = name;
              }
              function replaceAll(str, searchStr, replaceStr) {
                  return str.split(searchStr).join(replaceStr);
              }
              reader.onload = function (e) {
                  var re =/\r?\n|\r/;
                  data = e.target.result;
                  data = replaceAll(data,re,"^");
                  var tampArray = data.split("^");
                  for(var i =0; i< tampArray.length-1; i++){
                      rowArray = tampArray[i].split(",");
                      totalArray.push(rowArray);
                  }
                  console.log(totalArray);
                  rowArray = new Array();
                  makeFileTable();
              }
              function makeFileTable() {
                var table = document.getElementById('wordTable');
                  for(var i=0; i<totalArray.length; i++){
                    console.log(i);
                    for(var j=0; j<totalArray[i].length; j++){
                      if(totalArray[i][j]!=""){
                        var currentInput = document.getElementById(i+"-"+j);
                        console.log(totalArray[i][j])
                        currentInput.value =totalArray[i][j] ;
                        currentInput.disabled = true;
                        if(j!= totalArray[i].lenth-1){
                          cell = row.insertCell();
                          cell.innerHTML = "<input type='text' id="+i+"-"+(j+1)+">";
                        }
                      }
                    }
                    row.removeChild(cell);
                    row = table.insertRow();
                    cell = row.insertCell();
                    cell.innerHTML = "<input type='text' id="+(i+1)+"-0>";
                  }
              }
              function deleteData() {
                var data = document.getElementById("tableName").value;
                $.ajax({
                  url: "deleteTable",
                  type: "POST",
                  data: data,
                  contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                  success: function(data){
                    alert("테이블을 삭제하였습니다.");
                  },
                  error: function(){
                    alert("error deleteTable");
                  }
                });
              }

              function makeTable() {
                var currentInput = document.getElementById(totalArray.length+"-"+rowArray.length);
                if (window.event.keyCode == 13)makeCell(currentInput);
                else if(window.event.keyCode == 40){
                  var cellData = currentInput.value;
                  if(cellData!=""){
                    if(rowArray.length>=1){
                      makeCell(currentInput)
                      row.removeChild(cell);
                      makeRow();
                    }
                    else alert("입력이 잘못되었습니다.")
                  }
                  else{
                    if(rowArray.length>1){
                      row.removeChild(cell);
                      makeRow();
                    }
                    else alert("입력이 잘못되었습니다.")
                  }
                }
              }
              function makeCell(input) {
                var cellData = input.value;
                if(cellData !=""){
                  input.disabled = true;
                  rowArray.push(cellData);
                  cell = row.insertCell();
                  cell.innerHTML = "<input type='text' id="+totalArray.length+"-"+rowArray.length+">";
                  document.getElementById(totalArray.length+"-"+rowArray.length).focus();
                }
                else{
                  alert("입력이 잘못되었습니다.")
                }

              }
              function makeRow() {
                totalArray.push(rowArray);
                rowArray = new Array();
                var table = document.getElementById('wordTable');
                row = table.insertRow();
                cell = row.insertCell();
                cell.innerHTML = "<input type='text' id="+totalArray.length+"-"+rowArray.length+">";
                document.getElementById(totalArray.length+"-"+rowArray.length).focus();
              }

              function CleanTable() {
                var currentInput = document.getElementById(totalArray.length+"-"+rowArray.length);
                console.log(currentInput);
                if (currentInput.value !="")makeCell(currentInput);
                if(rowArray.length>1)totalArray.push(rowArray);
              }

              function createJson() {
                  var data = document.getElementById("DatatableName").value;
                var tampJson =null;
                var id=1;
                for(var i=0; i<totalArray.length; i++){
                  for(var j=1; j<totalArray[i].length; j++){
                    if(totalArray[i][j]!=""){
                      var tampData = [id,totalArray[i][0],totalArray[i][j]]
                      tampJson = JSON.stringify({
                        "table" : [data],
                        "data" : tampData
                      })
                      id +=1;
                      $.ajax({
                        url: "createData",
                        type: "POST",
                        data: tampJson,
                        contentType : "application/json; charset=UTF-8",
                        success: function(data){

                        },
                        error: function(){
                          alert("error createData");
                        }
                      });
                    }
                  }
                }

              }
              function makeModal() {
                var clientData = document.getElementById("client");
                var text = "";
                for(var i=0; i<totalArray.length; i++){
                    text+= totalArray[i];
                    text +="<br>";
                }
                clientData.innerHTML = text;
                var name = document.getElementById("DatatableName").value;
                var tableData = new Array();
                $.ajax({
                  url: "sendData",
                  type: "POST",
                  data: name,
                  contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                  success: function(data){
                    tableData = data;
                    var databaseData = document.getElementById("dataBase");
                    text="";
                    for(var i=0; i<tableData.length; i++){
                      if(i > 0) {
                        if(tableData[i].word == tableData[i-1].word){
                          text += ", "+ tableData[i].mean;
                        }
                        else{
                          text += "<br>"+ tableData[i].word + ","+tableData[i].mean;
                        }
                      }
                      else{
                        text+= tableData[i].word + ","+tableData[i].mean;
                      }
                    }
                    databaseData.innerHTML = text;
                  },
                  error: function(){
                    alert("error createTable");
                  }
                });

              }
              function makeData() {
                //html 테이블에 적힌값을 DataBase에 생성
                CleanTable();
                var data = document.getElementById("DatatableName").value;
                for(var i=0; i<tableListArray.length; i++){
                    if(data == tableListArray[i]){
                        console.log("같은 테이블이 있스니다.")
                        $('#myModal').modal('show');
                        makeModal();
                        return;
                    }
                }
                if(totalArray.length>0){
                  $.ajax({
                    url: "createTable",
                    type: "POST",
                    data: data,
                    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
                    success: function(data){
                      if(data){
                          createJson();
                          alert("데이터 베이스에 테이블을 생성하였습니다.");
                      }
                      else alert("같은 이름의 테이블이 이미 존재합니다.");
                    },
                    error: function(){
                      alert("error createTable");
                    }
                  });
                }
                else alert("단어를 한줄이상 작성해주세요");
                }

            </script>
          </div>
        </div>
        <p class="text-white-50 mb-4"></p>
        <a class="btn btn-light btn-xl js-scroll-trigger" href="#services">Get Started!</a>
      </div>
    </div>
  </div>
</section>
<!-- Services-->
<section class="page-section" id="services">
  <div class="container">
    <h2 class="text-center mt-0">서비스 이용</h2>
    <hr class="divider my-4" />
    <div>
      <div class="card">
        <div class="card-body" id="word" style="text-align: center">
          시작하시려면 단어를 등록하시고 enter키를 누르세요
        </div>
      </div>
      <div class="input-group mb-3">
        <input type="text" class="form-control" id = "inputText" onkeyup="enterkey();" placeholder="" aria-label="Recipient's username" aria-describedby="basic-addon2">
      </div>
    </div>

    <div >
      <div id="textArea" style="display: flex; flex-flow: wrap;">

      </div>
    </div>
  </div>
</section>

<!-- Footer-->
<footer class="bg-light py-5">
  <div class="container"><div class="small text-center text-muted">Copyright © 2020 - Start Bootstrap</div></div>
</footer>

<!-- 모달 영역 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">모달 타이틀</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
              <h1>저장된 내용</h1>
                <div id ="dataBase">

                </div>
                <hr width="100%">
              <h1>변경할 내용</h1>
                <div id ="client">

                </div>
            </div>
            <div class="modal-footer">
              <p style="float:left;">테이블의 내용을 바꾸시겠습니까?</p>
                <button type="button" class="btn btn-primary">확인</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<!-- Bootstrap core JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
<!-- Core theme JS-->
<script src="<%=request.getContextPath() %>/resources/js/scripts.js"></script>
</body>
</html>
